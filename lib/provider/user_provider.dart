import 'package:chat_app/database/my_database.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  MyUser? user;
  User? firebaseUser;

  UserProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initUser();
    }
  }

  void initUser() async {
    user = await MyDatabase.getUser(firebaseUser!.uid);
  }

  saveUserId(MyUser user) {
    this.user = user;
  }
}
