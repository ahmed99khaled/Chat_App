import 'package:chat_app/database/my_database.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:chat_app/ui/base/base.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/room_category/room.dart';

abstract class ChatNavigator extends BaseNavigator {
  void clearMessageFrommTextField();
}

class ChatViewModel extends BaseViewModel<ChatNavigator> {
  late Room room;
  late MyUser myUser;

  void sendMessage(String content) {
    Message message = Message(
        content: content,
        senderName: myUser.firstName,
        senderId: myUser.id,
        roomId: room.id,
        dateTime: DateTime.now().millisecondsSinceEpoch);
    MyDatabase.addMessage(message).then((value) {
      navigator!.clearMessageFrommTextField();
    });
  }

  Stream<QuerySnapshot<Message>> getMessages() {
    return MyDatabase.getMessage(room.id ?? '');
  }
}
