import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

import 'main.dart';

class PrivacyPolicyPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _PrivacyPolicyPage();
  }
}

class _PrivacyPolicyPage extends State<PrivacyPolicyPage> {
//html代码
  String htmlData="""
<div style="overflow:visible;height:auto;min-height:100%;">
    <!--Main Content-->
    <div>
        <div style="padding: 20px 20px 20px 20px;">
            <!--Main-->
            <div>
                <p style="margin-top: 20px; font-size: 18px; color: #2C2C2C; line-height: 26px;"><b>隐私政策</b></p>
                <p>
                    开源账号管家是一款专门用于记录和整理账号信息的 App。为了让用户能更加放心的整理自己的数据，我们的应用不会接入互联网，
                    不申请存储卡权限，并且开放所有源代码，用户记录的所有数据均存储于用户自己的设备中，数据可明文或者加密存储，加密密钥只有用户自己知道。本隐私政策属于本应用中不可或缺的一部分。
                </p>
                <p><b> </b></p>
                <p style="margin-top: 20px; font-size: 18px; color: #2C2C2C; line-height: 26px;"><b>① 权限说明：</b></p>
                <p>本应用只用到剪切板写权限，没用到读权限，写权限为了方便用户复制账号、密码信息</p>
                <p><b> </b></p>
                <p style="margin-top: 20px; font-size: 18px; color: #2C2C2C; line-height: 26px;"><b>② 信息说明：</b></p>
                <p>本应用不接入互联网且不会收集用户的任何隐私信息，用户记录的所有数据均可以明文或者密文的方式存储于设备本地。</p>
                <p><b> </b></p>
                <p style="margin-top: 20px; font-size: 18px; color: #2C2C2C; line-height: 26px;"><b>③ 数据存储安全：</b></p>
                <p>本应用可设置密码，如果数据是密文保存，进入应用主界面前都需要用户输入正确的密码，该密码不保存在任何地方，只有用户本人知道，以确保用户保存的信息安全。</p>
                <p><b> </b></p>
                <p style="margin-top: 20px; font-size: 18px; color: #2C2C2C; line-height: 26px;"><b>④ 隐私政策的变更：</b></p>
                <p>我们保留随时修改本政策的权利，如果我们需要调整此隐私政策，我们会在应用中及时通知所有用户。</p>
                <p><b> </b></p>
                <p style="margin-top: 20px; font-size: 18px; color: #2C2C2C; line-height: 26px;"><b>⑤ 关于我们：</b></p>
                <p>可在应用内，通过开发者网站提供的信息联系我们</p>
                <p>本应用名称：开源账号管家</p>
                <p>应用开发者：覃永斌</p>
                <p><b> </b></p>
            </div>
            <!--Main-->
        </div>
    </div>
    <!--Main Content-->
</div>""";

  _PrivacyPolicyPage(){
    SystemChrome.setSystemUIOverlayStyle(statusStyle);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('《用户隐私政策》'),backgroundColor: Colors.green, centerTitle:true,brightness: Brightness.light,), //Brightness.light表示背景颜色
        body: SingleChildScrollView(
          child: Html(
            data: htmlData,//调用
            ///页面样式
            style: {
              "html": Style(
                backgroundColor: Colors.white,
              ),
              "h4":Style(
                width: 50,
                backgroundColor: Colors.lightBlueAccent,
              )
            },
          ),
        ),
    );
  }

}