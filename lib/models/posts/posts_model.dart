class PostsModel {
  String name;
  String uId;
  String image;
  String dateTime;
  String text;
  String postImage;

  PostsModel({
    required this.name,
    required this.uId,
    required this.image,
    required this.dateTime,
    required this.text,
    required this.postImage,
  });

  PostsModel.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? '',
        uId = json['uId'] ?? '',
        image = json['image'] ?? '',
        dateTime = json['dateTime'] ?? '',
        text = json['text'] ?? '',
        postImage = json['postImage'] ?? '';

  // Convert UserModel instance to Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
      'text': text,
      'postImage': postImage
    };
  }
}
