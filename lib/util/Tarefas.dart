// ignore_for_file: file_names, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Tarefas extends StatelessWidget {
  final String titulo;
  final String descricao;
  final DateTime data;

  const Tarefas({
    Key? key,
    required this.titulo,
    required this.descricao,
    required this.data,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título
                Text(
                  titulo,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 4,),
                // Descrição
                Text(
                  descricao,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 14),
                ),
                SizedBox(height: 4,),
                // Data
                Text(
                  'Data: ${data.day}/${data.month}/${data.year}',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
            Icon(Icons.more_horiz)
          ],
        ),
      ),
    );
  }
}

class TarefasPage extends StatelessWidget {
  const TarefasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarefas'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('tarefas')
        .where('Email', isEqualTo: FirebaseAuth.instance.currentUser!.email!)
        .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Erro: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              return Tarefas(
                titulo: data['Titulo'],
                descricao: data['Descrição'],
                data: (data['Data'] as Timestamp).toDate(),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
