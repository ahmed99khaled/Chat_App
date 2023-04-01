import 'package:chat_app/model/message.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatelessWidget {
  Message message;

  MessageWidget(this.message);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return provider.user!.id == message.senderId
        ? SenderMessage(message)
        : RecivedMessage(message);
  }
}

class SenderMessage extends StatelessWidget {
  Message message;

  SenderMessage(this.message);

  @override
  Widget build(BuildContext context) {
    int? ts = message.dateTime;
    var dt = DateTime.fromMillisecondsSinceEpoch(ts ?? 0);
    var date = DateFormat('hh:mm a').format(dt);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            child: Text(
              message.content ?? '',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Text(
            date.toString(),
            style: TextStyle(color: Colors.grey[600]),
          ),
          SizedBox(
            height: 6,
          ),
        ],
      ),
    );
  }
}

class RecivedMessage extends StatelessWidget {
  Message message;

  RecivedMessage(this.message);

  @override
  Widget build(BuildContext context) {
    int? ts = message.dateTime;
    var dt = DateTime.fromMillisecondsSinceEpoch(ts ?? 0);
    var date = DateFormat('hh:mm a').format(dt);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                topLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Text(
              message.content ?? '',
            ),
          ),
          Text(
            date.toString(),
          ),
          SizedBox(
            height: 6,
          ),
        ],
      ),
    );
  }
}
