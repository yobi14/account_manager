import 'package:account_manager/utils.dart';
import 'package:encrypt/encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

import 'accout.dart';


//持久化保存数据
class AppInfo{

  String _keyAgreePrivacy = "_keyAgreePrivacy";
  String _keyAccountsJson = "_keyAccountsJson";
  String _password  = "";//用于生产aes密钥的字符串，不保存本地，每次都需要手动输入
  String _aesKey;
  List<Account> _accountList; //
  factory AppInfo() =>_getInstance();
  static AppInfo get instance => _getInstance();
  static AppInfo _instance;
  AppInfo._internal() {
    // 初始化
    _accountList = List(); //
  }
  static AppInfo _getInstance(){
    if (_instance == null) {
      _instance = new AppInfo._internal();
    }
    return _instance;
  }


  Future<void> saveAccounts() async {
    if(_accountList == null || _accountList.length <= 0){
      return;
    }
    String jsonStr =   jsonEncode(_accountList);
    if(jsonStr == null || jsonStr.length <= 0){
      return;
    }
    SharedPreferences sp = await SharedPreferences.getInstance();
    if(_aesKey != null && _aesKey.length > 0){
      jsonStr = _encrypt(jsonStr, _aesKey);
    }
    sp.setString(_keyAccountsJson, jsonStr);
  }

  Future<List<Account>> loadAccountFromJson() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String jsonStr = sp.getString(_keyAccountsJson);
    if(jsonStr == null || jsonStr.length < 3){
      return null;
    }
    if(jsonStr.startsWith("[{")){
      _jsonToList(jsonStr);
      return _accountList;
    }else{
      return _accountList;
    }
  }

  Future<bool> decrypt(String aesKey) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String jsonStr = sp.getString(_keyAccountsJson);
    if(jsonStr == null || jsonStr.length < 3){
      return false;
    }
    jsonStr = _decrypt(jsonStr, aesKey);
    if(jsonStr == null || jsonStr.length < 3){
      return false;
    }
    _jsonToList(jsonStr);
    if(_accountList.length > 0){
      return true;
    }
    return false;
  }



  void _jsonToList(String jsonStr){
    try {
      List<dynamic> tempList = jsonDecode(jsonStr);
      if (tempList != null && tempList.length > 0) {
        for (int i = 0; i < tempList.length; i++) {
          _accountList.add(Account.fromJson(tempList[i]));
        }
      }
    } catch (e, stack) {

    }
  }

  List<Account> getAccountList(){
    return _accountList;
  }


  List<Account> addAccount(Account account){
    if(account != null){
      _accountList.add(account);
    }
    AppInfo.instance.saveAccounts();
    return _accountList;
  }

  Future<void> setAgreePrivacy(bool agree) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool(_keyAgreePrivacy, agree);
  }
  Future<bool> getAgreePrivacy() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool value = sp.getBool(_keyAgreePrivacy);//
    if(value == null){
      value = false;
    }
    return value;
  }

  List<Account> deleteAccount(Account account){
    if(account == null){
      return _accountList;
    }
    _accountList.remove(account);
    AppInfo.instance.saveAccounts();
    return _accountList;
  }
  bool existAesKey(){
    if(_aesKey == null || _aesKey.length <= 0){
      return false;
    }
    return true;
  }
  String getPassword(){
    if(_password == null){
      return "";
    }
    return _password;
  }
  void setPassword(String password){
    _password = password;
  }

  Future<String> passwordToAesKey(String password) async{
    if(password == null || password.length <= 0){
      return "";
    }
    password = stringToMd5(password);
    for(int i=0; i < 5000; i++){
      password += i.toString()+"passwordToAesKey";
      password = stringToMd5(password);
    }
    return password;
  }
  void setAesKey(String key){
    _aesKey = key;
  }
  String getAesKey(){
    return _aesKey;
  }
  //Aes加密，返回加密后的字符串
  String _encrypt(String plainText, String aesKey){
    if(plainText == null || plainText.length <= 0){
      return "";
    }
    final key = Key.fromUtf8(aesKey);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  //Aes解密，返回解密后的字符串
  String _decrypt(String encryptedBase64, String aesKey){
    if(encryptedBase64 == null || encryptedBase64.length <= 0){
      return "";
    }
    try {
      final key = Key.fromUtf8(aesKey);
      final iv = IV.fromLength(16);
      final encrypter = Encrypter(AES(key));
      final decrypted = encrypter.decrypt64(encryptedBase64, iv: iv);
      return decrypted;
    } catch (e, stack) {
      return "";
    }
  }

  String getJsonStr(){
    if(_accountList == null || _accountList.length <= 0){
      return null;
    }
    String jsonStr =  jsonEncode(_accountList);
    return jsonStr;
  }

  String getSafeJsonStr(){
    if(_accountList == null || _accountList.length <= 0){
      return null;
    }
    String jsonStr =  jsonEncode(_accountList);
    jsonStr = _encrypt(jsonStr, _aesKey);
    return jsonStr;
  }

  Future<int> importData(String jsonStr, String password) async{
    if(jsonStr.startsWith("[")){//是明文
      int oldLen = _accountList.length;
      _jsonToList(jsonStr);
      int newLen = _accountList.length;
      if(newLen > oldLen){
        await saveAccounts();
        return 0;
      }
      return 1;
    }else{//是密文
      if(password == null || password.length <= 0){
        return 2;
      }
      String aesKey = await AppInfo.instance.passwordToAesKey(password);
      jsonStr = _decrypt(jsonStr, aesKey);
      if(jsonStr == null || jsonStr.length < 3){
        return 3;
      }
      int oldLen = _accountList.length;
      _jsonToList(jsonStr);
      int newLen = _accountList.length;
      if(newLen > oldLen){
        await saveAccounts();
        return 0;
      }
      return 1;
    }
  }

  void onlyShowTitle(bool onlyShowTitle){
    for(int i=0; i<_accountList.length; i++){
      _accountList[i].onlyShowTitle = onlyShowTitle;
    }
  }
}