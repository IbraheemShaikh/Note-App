import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_node_app/button/Round_Button.dart';
import 'package:flutter_node_app/screens/Signup_screen.dart';

import 'package:flutter_node_app/services/utils.dart';

import '2nd Screen.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text("Login"),
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Your Email";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Your Password";
                        } else {
                          return null;
                        }
                      },
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
                        title: "Login",
                        onpress: () {
                          if (_formkey.currentState!.validate()) {
                            login();
                          }
                        }),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account"),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Signupscreen(),
                                  ));
                            },
                            child: Text("Signup"))
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

  void login() {
    _auth
        .signInWithEmailAndPassword(
            email: _emailcontroller.text.toString(),
            password: _passwordcontroller.text.toString())
        .then((value) {
      utils().toastmessage(value.user!.email.toString());
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => mainscreen(),
          ));
    }).onError((error, stackTrace) {
      utils().toastmessage(error.toString());
    });
  }
}
