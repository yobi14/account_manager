import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class EditFieldContainer extends StatelessWidget {
  final double maxHeight;
  final double width;
  final Widget child;
  const EditFieldContainer({
    Key key,
    this.width,
    this.child,
    this.maxHeight = 999999999,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 10000000,
          minHeight: 40,
          maxHeight: maxHeight
        ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        width: width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black54,width: 0.5)

        ),

        child: child,
      )
    );
  }
}

class EditInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final String initValue;
  final double width;
  final double fontSize;
  final double maxHeight;
  const EditInputField({
    Key key,
    this.hintText,
    this.icon = Icons.email,
    this.onChanged,
    this.initValue,
    this.width,
    this.fontSize = 14.0,
    this.maxHeight = 999999999,
    Color color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return EditFieldContainer(
      width: width,
      maxHeight: maxHeight,
      child: TextField(
        maxLines: 99999999999, minLines: 1,
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
      ),
    );
  }
}