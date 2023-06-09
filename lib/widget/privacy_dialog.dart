
import 'package:flutter/material.dart';

PrivacyDialog privacyDialog(BuildContext context, String title, String msg, Function cancelF, Function okF, Function privacyF) {
  PrivacyDialog dialog = PrivacyDialog(title:title, text: msg, cancel: cancelF, ok:okF, privacy:privacyF);
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: UnconstrainedBox(child: dialog,),
        );

      });
  return dialog;
}
class PrivacyDialog extends Dialog {
  final String title;
  final String text;
  final String okName;
  final String cancelName;
  final double circular;
  final Function ok;
  final Function cancel;
  final Function privacy;
  PrivacyDialog({Key key,
    @required this.title,
    @required this.text,
    this.circular = 16,
    this.okName = "同意",
    this.cancelName = "退出",
    this.ok,
    this.cancel,
    this.privacy,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async{
      },
      child:WillPopScope(
        child:Material(
          type: MaterialType.transparency,
          child:  getView(context),
        ),
        onWillPop: () async {
          return Future.value(true);
        },
      ),
    );
  }

  Widget getView(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        width: size.width*0.7,
        decoration: ShapeDecoration(
          color: Color(0xffffffff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(circular),
            ),
          ),
        ),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20.0,right: 20,top: 20,bottom: 20
                ),
                child: new Text(
                  title,
                  style: new TextStyle(fontSize: 16.0,color: Colors.black, fontWeight: FontWeight.bold,),
                ),
              ),
            ),
            Divider(height: 1.0,indent: 10.0, endIndent:10, color: Colors.black,),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20.0,right: 20,top: 20,bottom: 20
                ),
                child: Text(
                  text,
                  style: new TextStyle(fontSize: 14.0, color: Colors.black,),
                ),
              ),
            ),
            Container(
              //height: 99,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20.0,right: 20,top: 0,bottom: 20
                ),
                child: GestureDetector(
                  child: Text("《用户隐私政策》",style: new TextStyle(color:Colors.green, fontSize: 14.0, decoration: TextDecoration.underline),),
                  onTap: (){
                    if(privacy!=null){
                      privacy();
                    }
                  },
                ),
              ),
            ),
            Divider(height: 1.0,indent: 10.0, endIndent:10, color: Colors.black,),
            Container(
              width: size.width*0.7,
              height: 50,
              child: Row(
                children: [
                  Container(
                    width: size.width*0.7/2 -0.5,
                    height: 50,
                    child: ClipRRect(
                      child: FlatButton(
                        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                        //color: color,
                        onPressed: (){
                          Navigator.of(context).pop();
                          if(cancel != null){
                            cancel();
                          }
                        },
                        child: Text(cancelName, style: TextStyle(color: Colors.grey, fontSize: 16,  fontWeight: FontWeight.bold,),
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(width: 1.0,indent: 5.0, endIndent:5, color: Colors.black,),
                  Container(
                    width: size.width*0.7/2 -0.5,
                    height: 50,
                    child: ClipRRect(
                      child: FlatButton(
                        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                        //color: color,
                        onPressed: (){
                          Navigator.of(context).pop();
                          if(ok != null){
                            ok();
                          }
                        },
                        child: Text(okName, style: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold,),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}