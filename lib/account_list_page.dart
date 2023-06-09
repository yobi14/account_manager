import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'add_page.dart';
import 'widget/dialog.dart';
import 'edit_page.dart';
import 'common.dart';
import 'event_bus_manager.dart';
import 'info/accout.dart';
import 'info/app_info.dart';

class ItemAccount extends StatelessWidget{
  final int index;
  final Function morePress;
  final Function seePress;
  final Function numPress;
  final Function copyNamePress;
  final Function copyPasswordPress;
  final Function copyAllPress;
  final double  monthsWidth = 0;
  final double  rightWidth = 40;
  final double  numWidth = 30;
  final double  wSpace = 5;
  final Account account;
  final double copyIconSize = 25;
  final double eyeIconSize = 28;
  final bool onlyShowTitle;
  Size size;
  ItemAccount({
    Key key,
    this.index,
    this.account,
    this.numPress,
    this.morePress,
    this.seePress,
    this.copyNamePress,
    this.copyPasswordPress,
    this.copyAllPress,
    this.onlyShowTitle = false,
  }) : super(key: key);
  List<Color> getColors(){
    return [themeLight, themeLight];
  }
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0), //调节间距
          width: numWidth,
          height: numWidth,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: FlatButton(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              color: themeLight,
              onPressed: (){
                if(numPress != null){
                  numPress();
                }
              },
              child: Text(getIndexStr(), style: TextStyle(color: Colors.white,fontSize: getIndexSize(),)),
            ),
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              gradient: RadialGradient( //背景径向渐变
                  colors: [Colors.transparent, Colors.transparent],
                  center: Alignment.bottomRight,
                  radius: 0.5
              ),
              boxShadow: [ //卡片阴影
                BoxShadow(
                    color: Colors.black54,
                    offset: Offset(6.0, 8.0),
                    blurRadius: 8.0
                ),
              ]
          ),
        ),

        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () async{
            copyAllPress(account);
          },

          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 10000000,
              minHeight: 40,
            ),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              width: size.width - wSpace*4 - rightWidth - numWidth,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  gradient: RadialGradient(
                      colors: getColors(),
                      center: Alignment.bottomRight,
                      radius: 0.5
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black54,
                        offset: Offset(6.0, 8.0),
                        blurRadius: 8.0
                    ),
                  ]
              ),
              child: getWidget(),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          width: rightWidth,
          height: rightWidth,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: FlatButton(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              color: themeLight,
              onPressed: (){
                morePress();
              },
              child: Icon(Icons.more_vert,size: 26,color: Colors.white,),
            ),
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              gradient: RadialGradient( //背景径向渐变
                  colors: [Colors.transparent, Colors.transparent],
                  center: Alignment.bottomRight,
                  radius: 0.5
              ),
              boxShadow: [ //卡片阴影
                BoxShadow(
                    color: Colors.black54,
                    offset: Offset(6.0, 8.0),
                    blurRadius: 8.0
                ),
              ]
          ),
        ),
      ],
    );
  }
  double getIndexSize(){
    if(index<99){
      return 14;
    }else if(index<999){
      return 12;
    }else{
      return 10;
    }
  }
  String getIndexStr(){
    return (index+1).toString();
  }


  Widget getWidget(){
    if(onlyShowTitle && account.title != null && account.title.length > 0){
      return showTitleWidget();
    }else{
      return showAllInfoWidget();
    }
  }
  Widget showAllInfoWidget(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getTitleWidget(Icon(Icons.title, color: Colors.white, size: 16,), account.title),
        getAccountWidget(true, Icon(Icons.account_box, color: Colors.white, size: 16,), account.name),
        getAccountWidget(false, Icon(Icons.lock_outline, color: Colors.white, size: 16,), account.password),
        getNoteWidget(Icon(Icons.note, color: Colors.white, size: 16,), account.note),
      ],
    );
  }
  Widget showTitleWidget(){
    return getTitleWidget(Icon(Icons.title, color: Colors.white, size: 16,), account.title);
  }
  Widget getTitleWidget(Icon icon, String v){
    if(v == null || v.length <= 0){
      return SizedBox(height: 0,);
    }
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        icon,
        SizedBox(width: 5,),
        Expanded(child:Text(v,style: TextStyle(color: Colors.white, fontSize: 14),),),
      ],
    );
  }
  Widget getNoteWidget(Icon icon, String v){
    if(v == null || v.length <= 0){
      return SizedBox(height: 0,);
    }
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        icon,
        SizedBox(width: 5,),
        Expanded(child:Text(v,style: TextStyle(color: Colors.white, fontSize: 14),),),
      ],
    );
  }
  Widget getAccountWidget(bool isName, Icon icon, String v){
    if(v == null || v.length <= 0){
      return SizedBox(height: 0,);
    }
    return  Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        icon,
        SizedBox(width: 5,),
        Expanded(child:Text(getValue(isName, v), style: TextStyle(fontSize: 14, color: Colors.white))),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          width: 80,
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () async{
                    seePress(isName, account);
                  },
                  child: getEyeWidget(isName)),
              GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () async{
                    if(isName){
                      copyNamePress(account);
                    }else{
                      copyPasswordPress(account);
                    }
                  },
                  child: Icon(Icons.content_copy, color: Colors.green, size:copyIconSize,)),
            ],
          ),
        ),
      ],
    );
  }
  String getValue(bool isName, String v){
    if(isName) {
      if(account.nameCanSee){
        return v;
      }else{
        return "********";
      }
    }else{
      if(account.passwordCanSee){
        return v;
      }else{
        return "********";
      }
    }

  }

  Widget getEyeWidget(bool isName){
    if(isName) {
      if(account.nameCanSee){
        return Icon(Icons.visibility,color: Colors.green,);
      }else{
        return Icon(Icons.visibility_off,color: Colors.green,);
      }
    }else{
      if(account.passwordCanSee){
        return Icon(Icons.visibility,color: Colors.green,);
      }else{
        return Icon(Icons.visibility_off,color: Colors.green,);
      }
    }

  }
}

// ignore: must_be_immutable
class AccountListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AccountListPage();
  }

}

class _AccountListPage extends State<AccountListPage>{
  bool onlyShowTitle = false; //true：列表仅显示标题（前提是有标题）；false：显示所有内容
  void initState(){
    super.initState();
    init();
  }

  void init() async{
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      loadData();
   });

  }

  void loadData() async{
    List<Account> tmpList = await AppInfo.instance.loadAccountFromJson();
    if(tmpList == null){

    }else if(tmpList.length > 0){
      setState(() {});
    }else if(tmpList.length <= 0){
      showDecryptDialog();
    }

    EventBusManager.eventBus.on<ValueChangeEvent>().listen((event) {
      if(event.value == Event.addAccount){
        addAccount();
      }else if(event.value == Event.refreshList){
        setState(() {
        });
      }
    });
  }
  void showDecryptDialog(){
    InputDialog dialog = InputDialog(title: "数据已被加密",hintText: "请求输入密码",cancel: "退出App",confirm: "解密",cancelFunc:(){
      SystemNavigator.pop();//退出app
    },confirmFunc: (password) async{
      loadingDialog(context, "正在解密...");
      String aesKey = await AppInfo.instance.passwordToAesKey(password);
      bool isSuccess = await AppInfo.instance.decrypt(aesKey);
      Navigator.pop(context);//关闭loadingDialog
      if(isSuccess){
        Navigator.pop(context);//关闭InputDialog
        AppInfo.instance.setPassword(password);
        AppInfo.instance.setAesKey(aesKey);
        EventBusManager.eventBus.fire(ValueChangeEvent(Event.decryptSuccess));
        setState(() {});
      }else{
        toastShort("解密失败，请输入正确的密码");
      }
    },);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });
  }
  void addAccount() {
    Navigator.push(this.context, MaterialPageRoute(
      builder: (context) {
        return AddPage((account){
          AppInfo.instance.addAccount(account);
          setState(() {});
        });
      },
    ),);
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
      // ),
      body: getBody(),
    );
  }
  Widget getBody(){
    return Stack(
      alignment:Alignment.center, //指定未定位或部分定位widget的对齐方式
      overflow: Overflow.clip,
      children: [
        Positioned(
          top: MediaQuery.of(context).size.height/2,
          child:Container(
            //color: Colors.amberAccent,
            width: MediaQuery.of(context).size.width - 40,
            height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
            child:  SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              reverse :false, //false：初始位置在上面，true：初始位置在下面
              child: getHintWidget(),
            ),
          ),
        ),
        Positioned(
          top: 0,
          child: Container(
            //color: Colors.amberAccent,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
            child: getListWidget(),
          ),
        ),

      ],
    );
  }
  Widget getListWidget(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      children: [
        SizedBox(height: MediaQuery.of(context).padding.top),
        Expanded(child: ListView.separated(
          padding: const EdgeInsets.all(5),
          physics: AlwaysScrollableScrollPhysics(parent:BouncingScrollPhysics()),
          itemCount: AppInfo.instance.getAccountList().length,
          separatorBuilder: (BuildContext context, int index) =>
              Divider(
                height: 10.0,//每个item的间距
                color: Color(0x00000000),//分割线颜色
              ),
          itemBuilder: (context, index) {
            return ItemAccount(index:index, account:AppInfo.instance.getAccountList()[index],onlyShowTitle:this.onlyShowTitle,
              numPress:(){
                this.onlyShowTitle = !this.onlyShowTitle;
                setState(() {});
              },
              copyAllPress: (a){
                String content = "";
                if(a.title != null && a.title.length >0 ){
                  content += a.title+"\n";
                }
                if(a.name != null && a.name.length >0 ){
                  content += a.name+"\n";
                }
                if(a.password != null || a.password.length >0 ){
                  content += a.password+"\n";
                }
                if(a.note != null && a.note.length >0 ){
                  content += a.title+"\n";
                }
                Clipboard.setData(ClipboardData(text: content));
                toastShort("账号、密码已复制到剪切板");
              },copyNamePress: (a){
                Clipboard.setData(ClipboardData(text: a.name));
                toastShort("账号已复制到剪切板");
              },copyPasswordPress: (a){
                Clipboard.setData(ClipboardData(text: a.password));
                toastShort("密码已复制到剪切板");
              },morePress: (){
                setState(() {});
                Navigator.push(this.context, MaterialPageRoute(
                  builder: (context) {
                    return EditPage(AppInfo.instance.getAccountList()[index], (editAccount){
                      AppInfo.instance.saveAccounts();
                      setState(() {});
                    }, (delAccount){
                      AppInfo.instance.deleteAccount(delAccount);
                      setState(() {});
                    });
                  },
                ),);
              },seePress: (isName, account){
                if(isName){
                  account.nameCanSee = !account.nameCanSee;
                }else{
                  account.passwordCanSee = !account.passwordCanSee;
                }
                setState(() {});
              },);
          },
        ),
        ),
      ],
    );
  }

  Widget getHintWidget(){
    if(AppInfo.instance.getAccountList().length <= 0 ){
      return Text('还没有数据，请添加，数据默认明文保存在本地，也可在设置界面添加密码，加密保存在本地。加密后每次进入程序都需要输入密码，如果忘记密码，加密数据将永久丢失',
        style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold,),);
    }else if(AppInfo.instance.getAccountList().length > 0 && AppInfo.instance.getAccountList().length <= 2){
      return Text('点击左边的序号可切换只显示标题（前提是有标题）、显示所有内容。点击中间的选项，可把账号、密码同时复制到剪切板',
        style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold,),);
    }
    return SizedBox(height: 0,);
  }
}