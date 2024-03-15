// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Emoticons extends StatelessWidget {
  final String emoticons;

  const Emoticons({required this.emoticons, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(131, 255, 255, 255),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(59, 20, 5, 5).withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Center(
        child: Text(
          emoticons,
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
