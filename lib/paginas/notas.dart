// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mindfullday_v1/paginas/adicionarNotas.dart';
import 'package:mindfullday_v1/util/note_card.dart';
import 'package:mindfullday_v1/util/note_view.dart';
import 'package:mindfullday_v1/util/sidebar.dart';


class Notas extends StatefulWidget {
  const Notas({super.key});

  @override
  State<Notas> createState() => _NotasState();
}

class _NotasState extends State<Notas> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(134, 150, 254, 1),
      drawer: SideBar(),
      appBar: AppBar(
        title: Text('Minhas notas'),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Suas notas recentes",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("notas").where("Email", isEqualTo: FirebaseAuth.instance.currentUser!.email!).snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(
                      child: CircularProgressIndicator()
                    );
                  }
                  if(snapshot.hasData){
                    return GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    children: snapshot.data!.docs.map((note) => noteCard(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NoteView(note)));
                    }, note)).toList(),
                    );
                  }
                  return Text("Você não possui notas", style: TextStyle(color: Colors.white),);
                }
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotas()));
        }, 
        label: Text("Adicionar Nota"),
        icon: Icon(Icons.add),
      ),

    );
  }

}