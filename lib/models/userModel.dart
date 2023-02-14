class UserModel{

    String? uid;
  String? fullname;
  String? email;
  String? profilepic;
  String? phone;
  bool? booktable;


    UserModel({this.uid, this.fullname, this.email, this.profilepic,this.phone,this.booktable=false});


      UserModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    fullname = map["fullname"];
    email = map["email"];
    profilepic = map["profilepic"];
    phone=map['phone'];
    booktable=map["booktable"];



  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "fullname": fullname,
      "email": email,
      "profilepic": profilepic,
      "phone":phone,
      "booktable":booktable
    };
  }

}