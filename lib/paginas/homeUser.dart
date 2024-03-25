// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mindfullday_v1/paginas/adicionarNotas.dart';
import 'package:mindfullday_v1/util/Tarefas.dart';
import 'package:mindfullday_v1/util/sidebar.dart';


class HomeUser extends StatefulWidget {
  const HomeUser({super.key});

  @override
  State<HomeUser> createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {  
  String data = DateTime.now().toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(134, 150, 254, 1),
      drawer: SideBar(),
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/imagens/bg-home.png'),
                opacity: 0.5,
                fit: BoxFit.fill,
              ),
            ),
          child: Column(
            children: [
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: [
                    //Olá usuario e notificações
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Olá, ${FirebaseAuth.instance.currentUser!.displayName}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              )
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              data,
                              style: TextStyle(color: Colors.deepPurple[100]),
                            )
                          ],
                        ),
                        //Notificação
                        Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(0, 82, 45, 168),
                              borderRadius: BorderRadius.circular(12)),
                          padding: EdgeInsets.all(12),
                          child: Icon(
                            Icons.notifications,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    //Barra de Busca
                    Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(120, 255, 255, 255),
                          borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Procurar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
          
                    //Como você está se sentindo hoje
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Como você está se sentindo hoje?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        Icon(
                          Icons.more_horiz,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    //Emoções
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Triste
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotas()));
                              },
                              child: Image.asset(
                                'assets/imagens/sad.png',
                                height: 55,
                                width: 55,
                              ),
                            ), // Image
                            SizedBox(
                              height: 12,
                            ), // Sized Box
                            Text(
                              'Triste',
                              style: TextStyle(color: Colors.white),
                            ), // Text
                          ],
                        ), // Column
                        //Feliz
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotas()));
                              },
                              child: Image.asset(
                                'assets/imagens/happy.png',
                                height: 55,
                                width: 55,
                              ),
                            ), // Image
                            SizedBox(
                              height: 12,
                            ), // Sized Box
                            Text(
                              'Feliz',
                              style: TextStyle(color: Colors.white),
                            ), // Text
                          ],
                        ), 
                        //Pensativo(a)
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotas()));
                              },
                              child: Image.asset(
                                'assets/imagens/shy.png',
                                height: 55,
                                width: 55,
                              ),
                            ), // Image
                            SizedBox(
                              height: 12,
                            ), // Sized Box
                            Text(
                              'Tímido',
                              style: TextStyle(color: Colors.white),
                            ), // Text
                          ],
                        ), 
                        //Furioso(a)
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotas()));
                              },
                              child: Image.asset(
                                'assets/imagens/angry.png',
                                height: 55,
                                width: 55,
                              ),
                            ), // Image
                            SizedBox(
                              height: 12,
                            ), // Sized Box
                            Text(
                              'Nervoso',
                              style: TextStyle(color: Colors.white),
                            ), // Text
                          ],
                        ), 
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('tarefas')
                  .where('Email', isEqualTo: FirebaseAuth.instance.currentUser!.email!)
                  .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Erro: ${snapshot.error}');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
