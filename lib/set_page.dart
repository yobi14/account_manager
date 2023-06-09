

import 'package:account_manager/widget/edit_input_field.dart';
import 'package:account_manager/widget/round_input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widget/dialog.dart';
import 'event_bus_manager.dart';
import 'info/app_info.dart';



class SetPage extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState() {
    return _SetPage();
  }

}


class _SetPage extends State<SetPage>{

  String password = "";
  String newPassword = "";

  String importContent = "";
  String importPassword = "";
  double vSpace1 = 20;
  double vSpace2 = 20;
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {

    });
    EventBusManager.eventBus.on<ValueChangeEvent>().listen((event) {
     if(event.value == Event.decryptSuccess){//解密成功，刷新解密
       setState(() {});
     }
    });
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
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () async{
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: getBody()),
    );
  }

  Widget getBody(){
    return Center(
      child: SingleChildScrollView(
        //physics: BouncingScrollPhysics(),
        physics: AlwaysScrollableScrollPhysics(parent:BouncingScrollPhysics()),
        reverse :false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top+5),
            Icon(Icons.account_box, color:Colors.green, size: 50,),
            Text('开源账号管家',style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold,),),
            SizedBox(height: 5,),
            Text('版本： 1.0',style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.normal,),),
            SizedBox(height: 10,),
            GestureDetector(
                child: Text("开源：github.com/yobi14/account_manager.git", style: TextStyle(decoration: TextDecoration.underline, color: Colors.green)),
                onTap: () {
                  _launchUrl("https://github.com/yobi14/account_manager.git");
                }
            ),
            SizedBox(height: 10,),
            GestureDetector(
                child: Text("作者网站：www.helpercow.com", style: TextStyle(decoration: TextDecoration.underline, color: Colors.green)),
                onTap: () {
                  _launchUrl("http://www.helpercow.com/");
                }
            ),
            SizedBox(height: vSpace1,),
            getDivider(),
            SizedBox(height: vSpace2,),
            getInputAesKeyWidget(),
            SizedBox(height: vSpace1,),
            getDivider(),
            SizedBox(height: vSpace2,),
            RoundButton(
              fontSize: 12,
              color: Color.fromRGBO(240,110,50,1.0),
              text: "导出数据到剪切板（明文）",
              press: () async{
                String content = AppInfo.instance.getJsonStr();
                if(content == null || content.length <= 0){
                  toastShort("还没有数据，不能复制");
                  return;
                }
                Clipboard.setData(ClipboardData(text: content));
                toastShort("明文已复制到剪切板");
              },
            ),
            SizedBox(height: 10,),
            RoundButton(
              fontSize: 12,
              color: Colors.green,
              text: "导出数据到剪切板（密文）",
              press: () async{
                if(AppInfo.instance.getAesKey() == null || AppInfo.instance.getAesKey().length <= 0){
                  toastShort("数据未加密，不能复制密文");
                  return;
                }
                String content = AppInfo.instance.getSafeJsonStr();
                if(content == null || content.length <= 0){
                  toastShort("还没有数据，不能复制");
                  return;
                }
                Clipboard.setData(ClipboardData(text: content));
                toastShort("密文已复制到剪切板");
              },
            ),
            SizedBox(height: vSpace1,),
            getDivider(),
            SizedBox(height: vSpace2,),
            EditInputField(
              icon: Icons.text_fields,
              fontSize: 12,
              maxHeight: MediaQuery.of(context).size.height*0.8,
              width: MediaQuery.of(context).size.width*0.8,
              hintText: "粘贴其他设备的数据",
              initValue:  this.importContent,
              onChanged: (value) {
                this.importContent = value;
                setState(() { });
              },
            ),
            getImportPasswordWidget(),
            SizedBox(height: 10,),
            RoundButton(
              fontSize: 12,
              color: Colors.green,
              text: "开始导入数据",
              press: () async{
                loadingDialog(context, "正在导入...");
                String password;
                if(this.importPassword.length <= 0){
                  password = AppInfo.instance.getPassword();
                }else{
                  password = this.importPassword;
                }
                int result = await AppInfo.instance.importData(this.importContent, password);
                Navigator.pop(context);//关闭dialog

                if(result == 0){
                  toastShort("导入成功");
                  EventBusManager.eventBus.fire(ValueChangeEvent(Event.refreshList));
                  setState(() {
                    this.importContent = "";//清空输入框
                  });
                }else if(result ==1){
                  toastShort("json解析失败");
                  setState(() {
                    this.importContent = "";//清空输入框
                  });
                }else if(result ==2){
                  toastShort("没有密码，请输入密码");
                }else if(result ==3){
                  toastShort("解密失败，请输入正确的密码");
                }
              },
            ),
            SizedBox(height: 80,),
          ],
        ),
      ),
    );
  }

  Widget getInputAesKeyWidget(){
    if(AppInfo.instance.existAesKey()){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RoundedInputField(
            icon: Icons.lock,
            height: 50,
            fontSize: 12,
            hintText: "请输入当前密码",
            initValue:  this.password,
            onChanged: (value) {
              this.password = value;
            },
          ),
          SizedBox(height: 10,),
          RoundedInputField(
            icon: Icons.lock_outline,
            height: 50,
            fontSize: 12,
            hintText: "请输入新密码，不填则清空密码",
            initValue:  this.newPassword,
            onChanged: (value) {
              this.newPassword = value;
            },
          ),
          SizedBox(height: 10,),
          RoundButton(
            fontSize: 12,
            text: "更换密码、并且保存数据",
            press: () async{
              if(this.password != AppInfo.instance.getPassword()){
                toastShort("当前密码错误，不能更换");
                return;
              }
              if(this.newPassword == null || this.newPassword.length == 0){
                showCupertinoDialog(
                    context: context,
                    barrierDismissible: true, //true：点空白处可关闭
                    builder: (context) {
                      return new CupertinoAlertDialog(
                        content: new Text("是否要清空密码？"),
                        actions: <Widget>[
                          new FlatButton(
                            onPressed: () async{
                              Navigator.of(context).pop();
                              loadingDialog(context, "正在明文保存...");
                              AppInfo.instance.setPassword("");
                              AppInfo.instance.setAesKey("");
                              await AppInfo.instance.saveAccounts();
                              Navigator.pop(context);
                              toastLong("密码已清空，数据明文保存");
                              setState(() {});
                            },
                            child: new Text("清空", style: TextStyle(color: Colors.red,)),
                          ),
                          new FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: new Text("取消", style: TextStyle(color: Colors.green,)),
                          ),
                        ],
                      );
                    });
                return;
              }else if(this.newPassword.length < 4){
                toastShort("密码长度不能小于4位数");
                return;
              }
              loadingDialog(context, "正在加密...");
              AppInfo.instance.setPassword(this.newPassword);
              String aseKey = await AppInfo.instance.passwordToAesKey(this.newPassword);
              AppInfo.instance.setAesKey(aseKey);
              await AppInfo.instance.saveAccounts();
              Navigator.pop(context);//关闭dialog
              toastLong("密码已更新，请记住新密码");
            },
          ),
        ],
      );
    }else{
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RoundedInputField(
            icon: Icons.lock,
            height: 50,
            fontSize: 12,
            hintText: "请输入加密数据的密码",
            initValue:  this.password,
            onChanged: (value) {
              this.password = value;
            },
          ),
          SizedBox(height: 10,),
          RoundButton(
            fontSize: 12,
            text: "加密保存数据",
            press: () async{
              if(this.password == null || this.password.length < 4){
                toastShort("密码长度不能小于4位数");
                return;
              }
              loadingDialog(context, "正在加密...");
              AppInfo.instance.setPassword(this.password);
              String aseKey = await AppInfo.instance.passwordToAesKey(this.password);
              AppInfo.instance.setAesKey(aseKey);
              await AppInfo.instance.saveAccounts();
              Navigator.pop(context);//关闭dialog
              toastLong("数据已被加密保存，请记住密码");
              setState(() {});
            },
          ),
        ],
      );
    }
  }

  Widget getImportPasswordWidget(){
    if(this.importContent.startsWith("[") || this.importContent.length <= 0) {
      return SizedBox(height: 0,);
    }else{
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        SizedBox(height: 10,),
          RoundedInputField(
            icon: Icons.lock_outline,
            fontSize: 12,
            height: 50,
            hintText: "输入密码，默认用当前设备的密码",
            initValue:  this.importPassword,
            onChanged: (value) {
              this.importPassword = value;
            },
          ),
        ],
      );
    }
  }

  Future<void> _launchUrl(String url ) async{
    if(await canLaunch(url)){
      await launch(url);
    }else{
      toastShort("网址打开失败："+url);
    }
  }
  Widget getDivider(){
    return Divider(height: 1.5,indent: 30.0, endIndent:30, color: Colors.black,);
  }
}