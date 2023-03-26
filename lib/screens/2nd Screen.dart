import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_node_app/notecard.dart';
import 'package:flutter_node_app/screens/loginscreen.dart';

import 'package:flutter_node_app/screens/note_save_screen.dart';
import 'package:flutter_node_app/screens/post_edit_screen.dart';
import 'package:flutter_node_app/services/utils.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class mainscreen extends StatefulWidget {
  const mainscreen({super.key});

  @override
  State<mainscreen> createState() => _mainscreenState();
}

class _mainscreenState extends State<mainscreen> {
  final _auth = FirebaseAuth.instance;
  final _titlecontroller = TextEditingController();
  final _notecontroller = TextEditingController();
  final _firestore = FirebaseFirestore.instance.collection("Notes").snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: InkWell(
                onTap: () {
                  _auth.signOut().then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Loginscreen(),
                        ));
                  }).onError((error, stackTrace) {
                    utils().toastmessage(error.toString());
                  });
                },
                child: Icon(Icons.logout_outlined)),
          )
        ],
        automaticallyImplyLeading: false,
        title: Text(
          "Note App",
          style: TextStyle(),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.teal,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => noteEditscreen(),
              ));
        },
        label: Text("Add Note"),
        icon: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        gapPadding: 10,
                        borderRadius: BorderRadius.circular(50)),
                    hintText: 'Search'),
              ),
              SizedBox(
                height: 15,
              ),
              StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("Notes").snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(
                      color: Colors.black,
                    );
                  }
                  if (snapshot.hasError) {
                    return Text("Some Error");
                  } else {
                    return
                        // Expanded(
                        //   child: GridView(
                        //       gridDelegate:
                        //           SliverGridDelegateWithFixedCrossAxisCount(
                        //         crossAxisCount: 2,
                        //       ),
                        //       children: [
                        //         snapshot.data!.map(
                        //             (note) => notecard(ontap: () {}, doc: note))
                        //       ]),
                        // );

                        Expanded(
                            child: MasonryGridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate:
                          SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        final title =
                            snapshot.data.docs[index]["title"].toString();
                        final note =
                            snapshot.data.docs[index]["note"].toString();
                        // final id = snapshot.data.docs["id"].toString();
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            notecard(
                              ontap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => posteditscreen(
                                              id: snapshot
                                                  .data.docs[index]["id"]
                                                  .toString(),
                                              note: note,
                                              title: title,
                                            )));
                                // showdialog(title, note);
                              },
                              note:
                                  snapshot.data.docs[index]["note"].toString(),
                              title:
                                  snapshot.data.docs[index]["title"].toString(),
                            )
                          ],
                        );
                      },
                    ));
                    //     Expanded(
                    //   child: ListView.builder(
                    //     itemCount: snapshot.data!.docs.length,
                    //     itemBuilder: (context, index) {
                    //       return Column(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           notecard(
                    //             ontap: () {},
                    //             note: snapshot.data.docs[index]["note"]
                    //                 .toString(),
                    //             title: snapshot.data.docs[index]["title"]
                    //                 .toString(),
                    //           )
                    //         ],
                    //       );
                    //       // ListTile(

                    //       //   title: Text(
                    //       //       snapshot.data!.docs[index]["title"].toString()),
                    //       // );
                    //     },
                    //   ),
                    // );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future showdialog(String title, String note) async {
    _titlecontroller.text = title;
    _notecontroller.text = note;
    return Scaffold(
      body: Column(
        children: [
          TextField(
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
          TextField(
            controller: _notecontroller,
            maxLines: 10,
            decoration: InputDecoration(
                hintText: "Note",
                hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                border: InputBorder.none),
          )
        ],
      ),
    );
    // actions: [TextButton(onPressed: () {}, child: Text("Cancel"))],
  }
}
