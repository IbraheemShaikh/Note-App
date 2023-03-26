import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_node_app/screens/2nd%20Screen.dart';
import 'package:flutter_node_app/services/utils.dart';

import '../button/Round_Button.dart';

class noteEditscreen extends StatefulWidget {
  noteEditscreen({
    super.key,
  });

  @override
  State<noteEditscreen> createState() => _noteEditscreenState();
}

class _noteEditscreenState extends State<noteEditscreen> {
  final _notecontroller = TextEditingController();
  final _titlecontroller = TextEditingController();

  final _firestore = FirebaseFirestore.instance.collection("Notes");
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          String id = DateTime.now().microsecondsSinceEpoch.toString();

          _firestore.doc(id).set({
            "note": _notecontroller.text.toString(),
            "title": _titlecontroller.text.toString(),
            "id": id
          }).then((value) {
            Navigator.pop(context);

            utils().toastmessage("Note Added");
          }).onError((error, stackTrace) {
            utils().toastmessage(error.toString());
          });
        },
        label: Text("Save"),
        icon: Icon(Icons.save_alt_outlined),
      ),
      // appBar: AppBar(
      //   centerTitle: true,

      //   elevation: 0,
      //   title: Text("Add Note"),
      // ),
      // backgroundColor: Colors,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => mainscreen(),
                            ));
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade300),
                          child: Icon(Icons.arrow_back_ios_new_outlined))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: Text(
                      "WriteNote",
                      style: TextStyle(
                          color: Colors.teal,
                          fontSize: 25,
                          // fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * .02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: _titlecontroller,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  cursorHeight: 25,
                  decoration: InputDecoration(
                      hintText: "Title",
                      hintStyle: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      border: InputBorder.none),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: _notecontroller,
                  maxLines: 10,
                  decoration: InputDecoration(
                      hintText: "Note",
                      hintStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      border: InputBorder.none),
                ),
              ),
              Spacer(),
              SizedBox(
                height: height * .05,
              ),
              // RoundButton(
              //   title: "Save",
              //   onpress: () {
              // _firestore.doc().set({
              //   "note": _notecontroller.text.toString(),
              //   "title": _titlecontroller.text.toString(),
              // }).then((value) {
              //   utils().toastmessage("Succsesfull Add");
              // }).onError((error, stackTrace) {
              //   utils().toastmessage(error.toString());
              // });
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
