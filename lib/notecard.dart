import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class notecard extends StatelessWidget {
  VoidCallback ontap;
  String title;
  String note;

  // QueryDocumentSnapshot doc;
  notecard(
      {super.key,
      required this.ontap,
      required this.title,
      required this.note});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black45),
          // color: Colors.deepPurple.shade100,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 17,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              note,
              style: TextStyle(color: Colors.black38, fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}
