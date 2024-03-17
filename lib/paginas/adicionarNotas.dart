// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, avoid_print, invalid_return_type_for_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddNotas extends StatefulWidget {
  const AddNotas({super.key});


  @override
  State<AddNotas> createState() => _AddNotasState();
}

class _AddNotasState extends State<AddNotas> {
  
  String data = DateTime.now().toString();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(134, 150, 254, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Adicionar Nota"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Titulo da Nota'
              ),
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            SizedBox(height: 8),
            Text(
              data,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 22),
            TextField(
              controller: descController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Descrição da Nota'
              ),
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          FirebaseFirestore.instance.collection("notas").add({
            "Titulo da Nota": titleController.text,
            "Data de Criação da Nota": data,
            "Descrição da Nota": descController.text,
            "Email": FirebaseAuth.instance.currentUser!.email!,
          }).then((value) {
            print(value.id);
            Navigator.pop(context);
          }).catchError((error) => print("Falha ao Criar a nota $error"));
        },
        child: Icon(Icons.save),
      ),
    );
  }
}