class UserModel {
  late final String name;
  late final String email;
  late final String phone;
  late final String uId;
  late final bool isEmailVerified;

  UserModel(
      {required this.name,
      required this.email,
      required this.phone,
      required this.uId,
      required this.isEmailVerified});

  UserModel.fromJson(Map<String, dynamic> json) {
    name:
    json['name'];
    email:
    json['email'];
    phone:
    json['phone'];
    uId:
    json['uId'];
    isEmailVerified:
    json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'isEmailVerified': isEmailVerified,
    };
  }
}
