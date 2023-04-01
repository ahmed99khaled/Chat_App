import 'dart:async';

import 'package:chat_app/ui/login/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = 'splash';

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    });

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage('assets/images/logo_splash.png'))),
    );
  }
}
