class MessagesModel {
  String senderId = ''; // Default value
  String text = ''; // Default value
  int chatId = 0; // Default value for int
  String time = ''; // Default value

  MessagesModel({
    required this.senderId,
    required this.text,
    required this.chatId,
    required this.time,
  });

  MessagesModel.fromJson(Map<String, dynamic> json) {
    senderId = json['uId_sender'] ?? '';
    text = json['text'] ?? '';
    chatId = json['chat_id'] ?? 0; // Use 0 as the default for int
    time = json['time'] ?? '';
  }

  Map<String, dynamic> toMap() {
    return {
      'uId_sender': senderId,
      'text': text,
      'chat_id': chatId,
      'time': time,
    };
  }
}
