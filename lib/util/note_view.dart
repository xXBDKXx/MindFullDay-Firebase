// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mindfullday_v1/models/note_model.dart';

class NoteView extends StatelessWidget {
  const NoteView({super.key, required this.note, required this.index, required this.onNoteDeleted});

  final Note note;
  final int index;

  final Function(int) onNoteDeleted;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(134, 150, 254, 1),
      appBar: AppBar(
        title: Text("Editar Nota"),
        actions: [
          IconButton(onPressed: (){
            showDialog(
              context: context, 
              builder: (context){
                return AlertDialog(
                  title: Text("Deseja Excluir?"),
                  content: Text("Nota ${note.title} será deletada!"),

                  actions: [
                    TextButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                        onNoteDeleted(index);
                        Navigator.of(context).pop();
                      }, 
                      child: Text("Excluir")
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      }, 
                      child: Text("Cancelar")
                    )
                  ],
                );
              }
            );
          }, icon: Icon(Icons.delete))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.title,
                  style: TextStyle(
                    fontSize: 26,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  note.body,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                )
              ],
            ),
          )
        ),
    );
  }
}