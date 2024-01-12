class User {
  String? userid;
  String? useremail;
  String? usercontact;
  String? username;
  String? userpassword;
  String? userdate;
  String? useraddress;

  User(
      {this.userid,
      this.useremail,
      this.usercontact,
      this.username,
      this.userpassword,
      this.userdate,
      this.useraddress});

  User.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    useremail = json['useremail'];
    usercontact = json['usercontact'];
    username = json['username'];
    userpassword = json['userpassword'];
    userdate = json['userdate'];
    useraddress = json['useraddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userid'] = userid;
    data['useremail'] = useremail;
    data['usercontact'] = usercontact;
    data['username'] = username;
    data['userpassword'] = userpassword;
    data['userdate'] = userdate;
    data['useraddress'] = useraddress;
    return data;
  }
}