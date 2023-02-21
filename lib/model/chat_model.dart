enum User { bot, human }

class ChatModel {
  String? id;
  String? content;
  DateTime? dateTime;
  User? user;

  ChatModel({
    required this.id,
    required this.content,
    required this.dateTime,
    required this.user,
  });

  ChatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['text'];
    user = json['user'];
    dateTime = json['dateTime'];
  }
}
