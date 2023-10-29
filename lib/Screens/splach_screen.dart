import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_app/Screens/login_screen.dart';

class Splach_View extends StatefulWidget {
  const Splach_View({super.key});

  @override
  State<Splach_View> createState() => _Splach_ViewState();
}

class _Splach_ViewState extends State<Splach_View> {
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login_View())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEB3738),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/Group 155.png",
            ),
          
          ],
        ),
      ),
    );
  }
}
