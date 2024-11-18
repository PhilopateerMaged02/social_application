class PostsModel {
  int id;
  String name;
  String uId;
  String image;
  String dateTime;
  String text;
  String? postImage;
  int postLikes;

  PostsModel({
    required this.postLikes,
    required this.id,
    required this.name,
    required this.uId,
    required this.image,
    required this.dateTime,
    required this.text,
    this.postImage,
  });

  PostsModel.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? '',
        id = json['id'] ?? '',
        uId = json['uId'] ?? '',
        image = json['image'] ?? '',
        dateTime = json['dateTime'] ?? '',
        text = json['text'] ?? '',
        postLikes = json['likes_count'] != null
            ? (json['likes_count'] is String
                ? int.tryParse(json['likes_count']) ?? 0
                : json['likes_count'])
            : 0,
        postImage = json['postImage'] ?? '';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
      'text': text,
      'postImage': postImage,
      'likes_count': postLikes,
    };
  }

  @override
  String toString() {
    return 'PostsModel(id: $id, name: $name, uId: $uId, image: $image, dateTime: $dateTime, text: $text, postImage: $postImage, postLikes: $postLikes)';
  }
}
