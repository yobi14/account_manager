
import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

int currentTimeMillis() {
  return new DateTime.now().millisecondsSinceEpoch;
}

//毫秒级时间戳转为日期格式字符串，返回 格式：1970-01-19 12:45:17
String timestampToDateStr(int timestamp){
  String timeStr = DateTime.fromMillisecondsSinceEpoch(timestamp).toString();
  if(timeStr.contains(".")){
    int index = timeStr.indexOf(".");
    timeStr = timeStr.substring(0, index);
  }
  return timeStr;
}


//把字符转成MD5码
String stringToMd5(String data) {
  var content = new Utf8Encoder().convert(data);
  var digest = md5.convert(content);
  return hex.encode(digest.bytes);
}