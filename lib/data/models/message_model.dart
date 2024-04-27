// ignore_for_file: public_member_api_docs, sort_constructors_first
class MessageModel {
  String content;
  String date;
  String senderID;
  MessageModel({
    required this.content,
    required this.date,
    required this.senderID,
  });
  factory MessageModel.fromJson(jsonData) {
    return MessageModel(
      content: jsonData['content'],
      date: jsonData['date'],
      senderID: jsonData['senderID'],
    );
  }
}
