import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_node_app/screens/2nd%20Screen.dart';
import 'package:flutter_node_app/screens/get_started_screen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 3),
        () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Getstartedscreen(),
            )));
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 188, 250, 235),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 230, width: 230, child: Image.asset("images/img1.png")),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "WriteNote",
                style: TextStyle(
                    color: Color.fromARGB(255, 35, 65, 98),
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
