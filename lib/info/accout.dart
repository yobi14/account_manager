
class Account {

  String category = "default"; //分类功能暂未实现
  String title; //标题，可不写
  String name; //账号
  String password;//密码
  String note; //备注
  int createTime; //创建日期，毫秒级时间戳
  bool nameCanSee = true;
  bool passwordCanSee = false;
  bool onlyShowTitle = true; //true：列表仅显示标题（前提是有标题）；false：显示所有内容
  Account();

  Map toJson() {
    Map map = new Map();
    map["category"] = this.category;
    map["title"] = this.title;
    map["name"] = this.name;
    map["password"] = this.password;
    map["note"] = this.note;
    map["createTime"] = this.createTime;
    return map;
  }

  factory Account.fromJson(Map<String, dynamic> map){
    Account account = Account();
    account.category = map["category"];
    account.title = map["title"];
    account.name = map["name"];
    account.password = map["password"];
    account.note = map["note"];
    account.createTime = map["createTime"];
    return account;
  }
}