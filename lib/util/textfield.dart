// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, prefer_const_literals_to_create_immutables
 
import 'package:flutter/material.dart';
 
class Campotexto extends StatelessWidget {
 
  final controller;
  final String hintText;
  final bool obscureText;
 
  const Campotexto({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    });
 
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 297,
        height: 47,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(33),
           
          ),
          shadows: [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 55.0),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
             border: InputBorder.none,
            hintText: hintText,
          ),
        ),
      ),
    );
  }
}