class Message {
  String? id;
  String? content;
  String? senderName;
  String? senderId;
  String? roomId;
  int? dateTime;

  Message(
      {this.id = '',
      required this.content,
      required this.senderName,
      required this.senderId,
      required this.roomId,
      required this.dateTime});

  Message.fromJson(Map<String, dynamic> data)
      : this(
          id: data['id'],
          content: data['content'],
          senderName: data['senderName'],
          senderId: data['senderId'],
          roomId: data['roomId'],
          dateTime: data['dateTime'],
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'senderName': senderName,
      'senderId': senderId,
      'roomId': roomId,
      'dateTime': dateTime,
    };
  }
}
