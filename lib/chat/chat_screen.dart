import 'package:chat_app/chat/chat_view_model.dart';
import 'package:chat_app/chat/message_widget.dart';
import 'package:chat_app/model/room_category/room.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:chat_app/ui/base/base.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/message.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = 'chat screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends BaseView<ChatScreen, ChatViewModel>
    implements ChatNavigator {
  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var room = ModalRoute.of(context)!.settings.arguments as Room;
    var provider = Provider.of<UserProvider>(context);
    viewModel.room = room;
    viewModel.myUser = provider.user!;
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.fill)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(room.titleRoom ?? ''),
            centerTitle: true,
          ),
          body: Card(
            margin: EdgeInsets.all(18),
            elevation: 14,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                      child: Container(
                    child: StreamBuilder<QuerySnapshot<Message>>(
                      stream: viewModel.getMessages(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return const Text('Some thing went wrong');
                        }
                        var messagesList =
                            snapshot.data!.docs.map((e) => e.data()).toList();
                        return ListView.builder(
                          itemBuilder: (context, index) =>
                              MessageWidget(messagesList[index]),
                          itemCount: messagesList.length,
                        );
                      },
                    ),
                  )),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          decoration: InputDecoration(
                            hintText: 'Type a message ',
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black26,
                                width: 1.4,
                              ),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      InkWell(
                        onTap: () {
                          viewModel.sendMessage(messageController.text);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.blue,
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                          child: Row(
                            children: [
                              Text(
                                'send',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  ChatViewModel initViewModel() {
    return ChatViewModel();
  }

  @override
  void clearMessageFrommTextField() {
    setState(() {
      messageController.clear();
    });
  }
}
