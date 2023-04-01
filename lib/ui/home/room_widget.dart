import 'package:chat_app/chat/chat_screen.dart';
import 'package:flutter/material.dart';

import '../../model/room_category/room.dart';

class RoomWidget extends StatelessWidget {
  Room room;

  RoomWidget(this.room);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ChatScreen.routeName, arguments: room);
      },
      child: Card(
        elevation: 18,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/images/${room.categoryId}.png',
                width: 120,
                height: 120,
              ),
              Text(
                room.titleRoom ?? '',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
