
import 'package:account_manager/main_page.dart';
import 'package:account_manager/privacy_policy_page.dart';
import 'package:account_manager/widget/privacy_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'info/app_info.dart';



class LaunchPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _LaunchPage();
  }

}


class _LaunchPage extends State<LaunchPage>{

  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if(await AppInfo.instance.getAgreePrivacy()){
        goToMainPage();
      }else{
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          privacyDialog(context, "欢迎使用开源账号管家", "本应用没有网络、存储卡权限，不收集任何隐私信息，"
              "用户记录的所有数据均保存在本地，数据可明文保存，也可加密保存，加密密钥只有用户知道。点击同意开始使用", (){
            SystemNavigator.pop();//退出app
          }, () async {
            await AppInfo.instance.setAgreePrivacy(true);
            goToMainPage();
          },(){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return PrivacyPolicyPage();
                },
              ),
            );
          });
        });
      }

    });
  }

  void goToMainPage(){
    Navigator.pop(context);//退出page
    Navigator.push(this.context, MaterialPageRoute(
      builder: (context) {
        return MainPage();
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
      appBar: null,
      resizeToAvoidBottomInset: false,
      body:Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.green[500],
      ),
    );
  }
}