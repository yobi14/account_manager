
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckWidget extends StatelessWidget{
  final bool value;
  final Icon icon;
  final Icon selectIcon;
  final Function press;
  final String text;
  final double width;
  const CheckWidget({
    Key key, this.icon, this.selectIcon, this.press,this.text,this.value,this.width=0,

  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0), //调节间距
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      width: this.width,
      // height: 60,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          //color: Colors.red,
          onPressed: (){
            press(!value);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getIcon(),
              SizedBox(width: 4,),
              Text(this.text, style: TextStyle(color: Colors.black, fontSize: 14.0),)
            ],
          ),
        ),
      ),
    );
  }

  Widget getIcon(){
    if(value){
      return selectIcon;
    }else{
      return icon;
    }
  }

}