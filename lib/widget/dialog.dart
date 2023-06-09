import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

void toastShort(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Color(0xFF222222),
      textColor: Colors.white,
      fontSize: 14.0);
}

void toastLong(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Color(0xFF222222),
      textColor: Colors.white,
      fontSize: 14.0);
}
class LoadingDialog extends Dialog {
  final String text;
  LoadingDialog({Key key, @required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child:Material(
        type: MaterialType.transparency,
        child: new Center(
          child: new SizedBox(
            width: 100.0,
            height: 100.0,
            child: new Container(
              decoration: ShapeDecoration(
                color: Color(0xffffffff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.green),),
                  new Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                    ),
                    child: new Text(
                      text,
                      style: new TextStyle(fontSize: 12.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      onWillPop: () async {
        return Future.value(false);
      },
    );
  }
}
void loadingDialog(BuildContext context, String msg) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return LoadingDialog(text: msg);
      });
}


class InputDialog extends Dialog {
  final double circular;
  final Function cancelFunc;
  final Function confirmFunc;
  final String title;
  final String hintText;
  final String cancel;
  final String confirm;
  String  initValue;
  String newPassword = "";
  bool hasChange = false;
  final List<TextInputFormatter> inputFormatters;
  InputDialog({Key key,
    this.title,
    this.hintText,
    this.cancel="取消",
    this.confirm="确定",
    this.circular = 16,
    this.initValue = "",
    this.cancelFunc,
    this.confirmFunc,
    this.inputFormatters,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //屏幕的整体宽高尺寸
    return  GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async{
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child:WillPopScope(
        child:Material(
          type: MaterialType.transparency,
          //color: Color(0x00ffffff),
          child:  _getView(context),
        ),
        onWillPop: () async {
          return Future.value(false);
        },
      ),
    );
  }
  Widget _getView(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        color: Color(0xffffffff),
        width: size.width*0.8,
        height: 210,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 5,),
            Text(title, style: TextStyle(fontSize: 16, color: Colors.green)),
            SizedBox(height: 3,),
            SizedBox(width: size.width*0.8 -10,height: 1,child: DecoratedBox(decoration: BoxDecoration(color: Colors.grey), ),),
            SizedBox(height: 3,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              width: size.width * 0.7,
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: TextField( maxLines: 1, minLines: 1,onChanged: onChanged, style: TextStyle(fontSize: 16.0, color: Colors.black),//输入文本的样式
                    inputFormatters: inputFormatters,
                    controller: TextEditingController.fromValue(TextEditingValue(text: initValue, selection: TextSelection.fromPosition(TextPosition(affinity: TextAffinity.downstream, offset:initValue.length)),)),
                    decoration: InputDecoration(
                      fillColor: Colors.black,
                      hintText: hintText,
                      hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey),),
                  ),),
                ],
              ),
            ),
            SizedBox(height: 3,),
            SizedBox(width: size.width*0.8 -10,height: 1,child: DecoratedBox(decoration: BoxDecoration(color: Colors.grey), ),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: size.width*0.4 - 0.5,
                  height: 50,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      if(cancelFunc != null){
                        cancelFunc();
                      }
                    },
                    child: new Text(cancel,style: TextStyle(color: Colors.green,)),
                  ),
                ),
                SizedBox(width: 1,height: 40,child: DecoratedBox(decoration: BoxDecoration(color: Colors.grey), ),),
                Container(
                  width: size.width*0.4 - 0.5,
                  height: 50,
                  child: FlatButton(
                    onPressed: () {
                      if(hasChange){
                        if(confirmFunc != null){
                          confirmFunc(newPassword);
                        }else{
                          Navigator.of(context).pop();
                        }
                      }
                    },
                    child: new Text(confirm,style: TextStyle(color: Colors.green,)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onChanged(String newPassword){
    this.initValue = newPassword;
    this.newPassword = newPassword;
    hasChange = true;
  }
}