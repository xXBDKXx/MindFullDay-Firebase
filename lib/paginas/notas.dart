// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mindfullday_v1/models/note_model.dart';
import 'package:mindfullday_v1/paginas/adicionarNotas.dart';
import 'package:mindfullday_v1/util/sidebar.dart';
import 'package:mindfullday_v1/util/note_card.dart';

class Notas extends StatefulWidget {
  const Notas({super.key});

  @override
  State<Notas> createState() => _NotasState();
}

class _NotasState extends State<Notas> {

  List<Note> notes = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(134, 150, 254, 1),
      drawer: SideBar(),
      appBar: AppBar(
        title: Text('Minhas notas'),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index){
          return NoteCard(note: notes[index], index: index, onNoteDeleted: onNoteDeleted,);
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddNotas(onNewNoteCreated: onNewNoteCreated,)));
        },
        child: Icon(Icons.add),
      ),

    );
  }

  void onNewNoteCreated(Note note){
    notes.add(note);
    setState(() {});
  }


  void onNoteDeleted(int index){
    notes.removeAt(index);
    setState(() {});
  }
}