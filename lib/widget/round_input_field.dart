import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final double height;
  const TextFieldContainer({
    Key key,
    this.child,
    this.height,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),//此行是用来和周边控件的间距
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      width: size.width * 0.8,
      height: height,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(height/2),
          border: Border.all(color: Colors.black54,width: 0.5)

      ),

      child: child,
    );
  }
}

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final String initValue;
  final double height;
  final double fontSize;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.email,
    this.onChanged,
    this.initValue,
    this.height,
    this.fontSize = 14.0,
    Color color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      height: height,
      child: Center(child: TextField(
        onChanged: onChanged,
        style: TextStyle(fontSize: fontSize, color: Color.fromRGBO(30,30,30,1.0)),
        controller: TextEditingController.fromValue(TextEditingValue(text: initValue, selection: TextSelection.fromPosition(TextPosition(affinity: TextAffinity.downstream, offset:initValue.length)),)),
        decoration: InputDecoration(
            fillColor: Colors.green,
            icon: Icon(
              icon,
              color: Color.fromRGBO(30,30,30,1.0),
            ),
            hintText: hintText,
            hintStyle: TextStyle(fontSize: fontSize, color: Colors.grey),

            border: InputBorder.none),
      ),)
    );
  }
}

class RoundButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  final double fontSize;
  final double height;
  const RoundButton({
    Key key,
    this.text,
    this.press,
    this.color = Colors.green,
    this.textColor = Colors.white,
    this.fontSize = 18,
    this.height = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      width: size.width * 0.8,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(height/2),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          color: color,
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: fontSize),
          ),
        ),
      ),
    );
  }
}