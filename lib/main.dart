import 'package:chat_app/chat/chat_screen.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:chat_app/ui/add_room/add_room_screen.dart';
import 'package:chat_app/ui/create_account/create_account.dart';
import 'package:chat_app/ui/home/home_screen.dart';
import 'package:chat_app/ui/login/login_screen.dart';
import 'package:chat_app/ui/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (context) => UserProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          CreateAccount.routeName: (context) => CreateAccount(),
          LoginScreen.routeName: (context) => LoginScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          AddRoomScreen.routeName: (context) => AddRoomScreen(),
          ChatScreen.routeName: (context) => ChatScreen(),
          SplashScreen.routeName: (context) => SplashScreen(),
        },
        initialRoute: provider.firebaseUser != null
            ? HomeScreen.routeName
            : SplashScreen.routeName);
  }
}
