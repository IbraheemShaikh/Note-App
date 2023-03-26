import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_node_app/button/Round_Button.dart';
import 'package:flutter_node_app/screens/2nd%20Screen.dart';

import 'loginscreen.dart';

class Getstartedscreen extends StatefulWidget {
  const Getstartedscreen({super.key});

  @override
  State<Getstartedscreen> createState() => _GetstartedscreenState();
}

class _GetstartedscreenState extends State<Getstartedscreen> {
  void islogin() {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => mainscreen(),
          ));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Loginscreen(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/noteapp5.webp"),
                    fit: BoxFit.fill)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Text(
                  "WriteNote",
                  style: TextStyle(
                      color: Color.fromARGB(255, 35, 65, 98),
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    textAlign: TextAlign.center,
                    "Keep track of all your important notes and ideas with our easy-to-use note-taking app. Stay organized and never forget an important thought again.",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,

                        // fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.all(60.0),
                  child: RoundButton(
                      title: "Get Started",
                      onpress: () {
                        islogin();
                      }),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
