import 'dart:ui';

import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  String title;
  VoidCallback onpress;
  RoundButton({
    super.key,
    required this.title,
    required this.onpress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.teal, borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
