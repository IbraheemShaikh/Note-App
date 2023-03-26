import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_node_app/button/Round_Button.dart';
import 'package:flutter_node_app/services/utils.dart';

import '2nd Screen.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  final _auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();

  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text("Signup"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _emailcontroller,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email",
                      ),
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    TextFormField(
                      controller: _passwordcontroller,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                      ),
                    ),
                    SizedBox(
                      height: height * .06,
                    ),
                    RoundButton(
                        title: "Signup",
                        onpress: () {
                          if (_formkey.currentState!.validate()) {
                            _auth
                                .createUserWithEmailAndPassword(
                                    email: _emailcontroller.text.toString(),
                                    password:
                                        _passwordcontroller.text.toString())
                                .then((value) {
                              utils().toastmessage("Signes in Successful");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => mainscreen(),
                                  ));
                            }).onError((error, stackTrace) {
                              utils().toastmessage(error.toString());
                            });
                          }
                        }),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("already have an account"),
                        TextButton(onPressed: () {}, child: Text("Login"))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
