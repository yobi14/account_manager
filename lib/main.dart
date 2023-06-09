import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'launch_page.dart';

//登录界面状态栏
const SystemUiOverlayStyle statusStyle = SystemUiOverlayStyle(
  systemNavigationBarColor: Colors.white, //底部导航栏颜色 //虚拟按键颜色
  systemNavigationBarDividerColor: null,//
  statusBarColor: Colors.white,//顶部状态栏颜色
  systemNavigationBarIconBrightness: Brightness.light,
  statusBarIconBrightness: Brightness.dark,
  statusBarBrightness: Brightness.dark,

);

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(statusStyle);
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '开源账号管家',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: LaunchPage(),
    );
  }
}