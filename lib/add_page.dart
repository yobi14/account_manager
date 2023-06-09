

import 'package:account_manager/widget/edit_input_field.dart';
import 'package:account_manager/widget/round_input_field.dart';
import 'package:account_manager/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'info/accout.dart';



class AddPage extends StatefulWidget {
  // This widget is the root of your application.
  Function callback;
  AddPage(Function f){
    this.callback = f;
  }
  @override
  State<StatefulWidget> createState() {
    return _AddPage(this.callback);
  }

}


class _AddPage extends State<AddPage>{
  String title = "";
  String name = "";
  String password = "";
  String note = "";
  Function callback;

  _AddPage(Function callback){
    this.callback =  callback;
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
        brightness: Brightness.light,//这里light，状态栏的字体才为黑色
        title: Text("添加账号",style: TextStyle(color: Colors.black, fontSize: 16)),
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
               print("note: "+note);
             },
           ),
           SizedBox(height: 20,),
           RoundButton(
             text: "添 加",
             press: () {
               if(this.callback != null) {
                 //新添加
                 if (this.title.length > 0 || this.name.length > 0 ||
                     this.password.length > 0 || this.note.length > 0) {
                   Account newAccount = Account();
                   newAccount.title = this.title;
                   newAccount.name = this.name;
                   newAccount.password = this.password;
                   newAccount.note = this.note;
                   newAccount.createTime = currentTimeMillis();
                   callback(newAccount);
                 }
                 Navigator.pop(context);
               }
             },
           ),
           SizedBox(height: 20,),
         ],
       ),
     ),
   );
  }
}