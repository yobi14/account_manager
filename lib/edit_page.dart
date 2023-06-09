

import 'package:account_manager/widget/edit_input_field.dart';
import 'package:account_manager/widget/round_input_field.dart';
import 'package:account_manager/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'info/accout.dart';



class EditPage extends StatefulWidget {
  // This widget is the root of your application.
  Function editCallback;
  Function delCallback;
  Account account;
  EditPage(Account account, Function editF,Function delF){
    this.account = account;
    this.editCallback = editF;
    this.delCallback = delF;
  }
  @override
  State<StatefulWidget> createState() {
    return _EditPage(this.account, this.editCallback, this.delCallback);
  }

}


class _EditPage extends State<EditPage>{
  Account account;
  String title = "";
  String name = "";
  String password = "";
  String note = "";
  Function editCallback;
  Function delCallback;

  _EditPage(Account account,Function editF,Function delF){
    this.account =  account;
    this.editCallback = editF;
    this.delCallback = delF;
    this.title = account.title;
    this.name = account.name;
    this.password = account.password;
    this.note = account.note;
  }
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {


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
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        elevation: 0.5,
        brightness: Brightness.light,
        title: Text("编辑账号",style: TextStyle(color: Colors.black, fontSize: 16)),
        centerTitle: true,
        toolbarHeight: 50,
        backgroundColor:  Colors.white,
        actions: <Widget>[

        ],
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.close, color: Colors.black), //自定义图标
            onPressed: () {
              Navigator.pop(context);
            },
          );
        }),
      ),
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
       physics: BouncingScrollPhysics(),
       reverse :false,
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           SizedBox(height: 20,),
           getTimeWidget(),
           SizedBox(height: 20,),
           RoundedInputField(
             icon: Icons.title,
             height: 50,
             hintText: "请输入标题（可不写）",
             initValue:  this.title,
             onChanged: (value) {
               this.title = value;
             },
           ),
           SizedBox(height: 20,),
           RoundedInputField(
             icon: Icons.account_box,
             height: 50,
             hintText: "请输入账号",
             initValue:  this.name,
             onChanged: (value) {
               this.name = value;
             },
           ),
           SizedBox(height: 20,),
           RoundedInputField(
             icon: Icons.lock_outline,
             height: 50,
             hintText: "请输入密码",
             initValue:  this.password,
             onChanged: (value) {
               this.password = value;
             },
           ),
           SizedBox(height: 20,),
           EditInputField(
             icon: Icons.note,
             maxHeight: MediaQuery.of(context).size.height*0.8,
             width: MediaQuery.of(context).size.width*0.8,
             hintText: "请输入备注（可不写）",
             initValue:  this.note,
             onChanged: (value) {
               this.note = value;
             },
           ),
           SizedBox(height: 20,),
           RoundButton(
             text: "修 改",
             press: () {
               if(editCallback != null){
                 //编辑旧账号
                 account.title = this.title;
                 account.name = this.name;
                 account.password = this.password;
                 account.note = this.note;
                 editCallback(account);
               }
               Navigator.pop(context);
             },
           ),
           SizedBox(height: 20,),
           getDeleteBtn(),
           SizedBox(height: 20,),
         ],
       ),
     ),
   );
  }

  Widget getTimeWidget(){
    return Text("创建日期："+timestampToDateStr(account.createTime), style:TextStyle(color: Colors.black, fontSize: 14));
  }

  Widget getDeleteBtn(){
    return RoundButton(
      text: "删 除",
      color: Color.fromRGBO(240,110,50,1.0),
      press: () {
        if(delCallback != null){
          showDialog(context);
        }else{
          Navigator.pop(context);
        }
      },
    );
  }
  void showDialog(BuildContext context) {
    showCupertinoDialog(
        context: context,
        barrierDismissible: true, //true：点空白处可关闭
        builder: (context) {
          return new CupertinoAlertDialog(
            content: new Text("是否要删除？"),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pop(context);

                },
                child: new Text("取 消",style: TextStyle(color: Colors.green,)),
              ),
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  delCallback(account);
                  Navigator.pop(context);
                },
                child: new Text("删 除",style: TextStyle(color: Colors.red,)),
              ),
            ],
          );
        });
  }
}