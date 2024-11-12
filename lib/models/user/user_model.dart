class UserModel {
  String name;
  String email;
  String phone;
  String uId;
  String cover;
  String image;
  String bio;
  bool isEmailVerified;

  // Primary constructor
  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uId,
    required this.bio,
    required this.cover,
    required this.image,
    required this.isEmailVerified,
  });

  // Named constructor fromJson
  UserModel.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? '', // Default to empty string if null
        email = json['email'] ?? '',
        phone = json['phone'] ?? '',
        uId = json['uId'] ?? '',
        bio = json['bio'] ?? '',
        cover = json['cover'] ?? '',
        image = json['image'] ?? '',
        isEmailVerified = json['isEmailVerified'] ?? false; // Default to false

  // Convert UserModel instance to Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'bio': bio,
      'cover': cover,
      'image': image,
      'isEmailVerified': isEmailVerified,
    };
  }
}
