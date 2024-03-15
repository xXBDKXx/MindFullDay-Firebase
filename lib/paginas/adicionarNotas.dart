// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:mindfullday_v1/models/note_model.dart';

class AddNotas extends StatefulWidget {
  const AddNotas({super.key, required this.onNewNoteCreated});

  final Function(Note) onNewNoteCreated;


  @override
  State<AddNotas> createState() => _AddNotasState();
}

class _AddNotasState extends State<AddNotas> {

  final titleController = TextEditingController();
  final bodyController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(134, 150, 254, 1),
      appBar: AppBar(
        title: Text("Adicionar Nota"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                style: TextStyle(
                  fontSize: 28,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Titulo"
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: bodyController,
                style: TextStyle(
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Descrição"
                ),
              ),
            ],
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(titleController.text.isEmpty){
            return;
          }
          if(bodyController.text.isEmpty){
            return;
          }

          final note = Note(
            body: bodyController.text,
            title: titleController.text,
          );

          widget.onNewNoteCreated(note);
          Navigator.of(context).pop();
        },
        child: Icon(Icons.save),
      )
    );
  }
}