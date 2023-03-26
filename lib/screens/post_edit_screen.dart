// // import 'package:flutter/material.dart';

// // import '2nd Screen.dart';

// // class updatenotescreen extends StatefulWidget {
// //   const updatenotescreen({super.key});

// //   @override
// //   State<updatenotescreen> createState() => _updatenotescreenState();
// // }

// // class _updatenotescreenState extends State<updatenotescreen> {
// //   @override
// //   Widget build(BuildContext context) {
// //     final height = MediaQuery.of(context).size.height * 1;

// //     return Scaffold(
// //       body: SafeArea(
// //         child: Padding(
// //           padding: const EdgeInsets.all(10.0),
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.start,
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               InkWell(
// //                   onTap: () {
// //                     Navigator.push(
// //                         context,
// //                         MaterialPageRoute(
// //                           builder: (context) => mainscreen(),
// //                         ));
// //                   },
// //                   child: Icon(Icons.arrow_back_ios_new_outlined)),
// //               SizedBox(
// //                 height: height * .04,
// //               ),
// //               Padding(
// //                   padding: const EdgeInsets.symmetric(horizontal: 10),
// //                   child: notesave()),
// //               Spacer(),
// //               SizedBox(
// //                 height: height * .05,
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// // }

// // // class notesave extends StatelessWidget {
// // //   const notesave({super.key});

// // //   @override
// // //   Widget build(BuildContext context) {

// // //     return Column(
// // //       children: [
//         TextFormField(
//           controller: _titlecontroller,
//           style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//           cursorHeight: 25,
//           decoration: InputDecoration(
//               hintText: "Title",
//               hintStyle: TextStyle(
//                 fontSize: 25,
//                 fontWeight: FontWeight.bold,
//               ),
//               border: InputBorder.none),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: TextFormField(
//             controller: _notecontroller,
//             maxLines: 10,
//             decoration: InputDecoration(
//                 hintText: "Note",
//                 hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 border: InputBorder.none),
//           ),
//         ),
// // //       ],
// // //     );
// // //   }
// // // }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_node_app/services/utils.dart';

import '2nd Screen.dart';

class posteditscreen extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance.collection("Notes");
  String title;
  String note;
  String id;

  posteditscreen({
    super.key,
    required this.note,
    required this.title,
    required this.id,
  });

  final _notecontroller = TextEditingController();

  final _titlecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              _firestore.doc(id).update({
                "title": _titlecontroller.text.toString(),
                "note": _notecontroller.text.toString(),
              }).then((value) {
                Navigator.pop(context);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => mainscreen(),
                //     ));
                utils().toastmessage(
                  "Post Update",
                );
              }).onError((error, stackTrace) {
                // print(error);
                utils().toastmessage(error.toString());
              });
            },
            label: Text("Update")),
        body: SafeArea(child: showdialog(context, title, note))

        // Column(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     InkWell(
        //         onTap: () {
        //           Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                 builder: (context) => mainscreen(),
        //               ));
        //         },
        //         child: Icon(Icons.arrow_back_ios_new_outlined)),
        //     SizedBox(
        //       height: height * .04,
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 10),
        //       child: TextFormField(
        //         controller: _titlecontroller,
        //         style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        //         cursorHeight: 25,
        //         decoration: InputDecoration(
        //             hintText: "Title",
        //             hintStyle: TextStyle(
        //               fontSize: 25,
        //               fontWeight: FontWeight.bold,
        //             ),
        //             border: InputBorder.none),
        //       ),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 10),
        //       child: TextFormField(
        //         controller: _title,
        //         maxLines: 10,
        //         decoration: InputDecoration(
        //             hintText: "Note",
        //             hintStyle:
        //                 TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        //             border: InputBorder.none),
        //       ),
        //     ),
        //   ],
        );
  }

  showdialog(
    BuildContext context,
    String title,
    String note,
  ) {
    _titlecontroller.text = title;
    _notecontroller.text = note;
    final height = MediaQuery.of(context).size.height * 1;

    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 5),
      child: Container(
        width: double.infinity,
        height: double.infinity,
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
                const Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: Text(
                    "Update Note",
                    style: TextStyle(
                        color: Colors.teal,
                        fontSize: 25,
                        // fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Icon(Icons.delete)
              ],
            ),

            SizedBox(
              height: height * .02,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                textAlignVertical: TextAlignVertical.top,
                // maxLines: 2,
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

            // SizedBox(
            //   height: 10,
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: _notecontroller,
                maxLines: 10,
                decoration: InputDecoration(
                    hintText: "Note",
                    hintStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );

    // actions: [TextButton(onPressed: () {}, child: Text("Cancel"))],
  }

  // Future<void> updatedata() async {

  //   return
  // }
}
