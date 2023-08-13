class UserModel {
  String? address;
  String? username;
  String? schoolName;
  int? id;
  String? phoneNo;
  String? userClass;

  UserModel(
      {this.address,
      this.username,
      this.schoolName,
      this.id,
      this.phoneNo,
      this.userClass});

  UserModel.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    username = json['username'];
    schoolName = json['school_name'];
    id = json['id'];
    phoneNo = json['phone_no'];
    userClass = json['user_class'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['username'] = username;
    data['school_name'] = schoolName;
    data['id'] = id;
    data['phone_no'] = phoneNo;
    data['user_class'] = userClass;
    return data;
  }
}
