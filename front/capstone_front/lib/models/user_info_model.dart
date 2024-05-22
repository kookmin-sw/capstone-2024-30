class UserInfoModel {
  String createdDate;
  String modifiedDate;
  String id;
  String email;
  String major;
  String bigMajor;
  String country;
  String name;
  String role;

  UserInfoModel.fromJson(Map<String, dynamic> json)
      : createdDate = json['createdDate'],
        modifiedDate = json['modifiedDate'],
        id = json['id'],
        email = json['email'],
        major = json['major'],
        bigMajor = json['bigmajor'],
        country = json['country'],
        name = json['name'],
        role = json['role'];
}
