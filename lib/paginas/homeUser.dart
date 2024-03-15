// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names

import 'package:flutter/material.dart';
import 'package:mindfullday_v1/models/note_model.dart';
import 'package:mindfullday_v1/paginas/adicionarNotas.dart';
import 'package:mindfullday_v1/util/tarefas.dart';
import 'package:mindfullday_v1/util/sidebar.dart';


class HomeUser extends StatefulWidget {
  const HomeUser({super.key});

  @override
  State<HomeUser> createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
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
                            Text('Olá, (Usuario)',
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
                              '21 Jan 2024',
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => AddNotas(onNewNoteCreated: onNewNoteCreated,)),
                                );
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => AddNotas(onNewNoteCreated: onNewNoteCreated,)),
                                );
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => AddNotas(onNewNoteCreated: onNewNoteCreated,)),
                                );
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => AddNotas(onNewNoteCreated: onNewNoteCreated,)),
                                );
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
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 74, 66, 228), borderRadius: BorderRadius.only(
                      topRight:  Radius.circular(30), 
                      topLeft: Radius.circular(30)
                    ),
                    boxShadow: 
                    [
                      BoxShadow(
                        color: Color.fromARGB(43, 51, 51, 51),
                        blurRadius: 4,
                        offset: Offset(0, -8),
                        spreadRadius: -4,
                      ),
                    ],
                  ), 
                padding: EdgeInsets.all(25),
                child: Center(
                  child: Column(
                    children: [
                      // Heading Tarefas
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Tarefas',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      //Lista de Tarefas
                      Expanded(
                        child: ListView(
                          children: [
                            Tarefas(
                              icon: Icons.favorite,
                              nomeTarefa: 'Tarefa 1',
                              descricaoTarefa: 'Descrição da Tarefa',
                              color: Colors.lightBlue,
                            ),
                            //ola Garden
                            Tarefas(
                              icon: Icons.earbuds,
                              nomeTarefa: 'Tarefa 2',
                              descricaoTarefa: 'Descrição da Tarefa',
                              color: Colors.orange,
                            ),
                            Tarefas(
                              icon: Icons.person,
                              nomeTarefa: 'Tarefa 3',
                              descricaoTarefa: 'Descrição da Tarefa',
                              color: Colors.green,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
  void onNewNoteCreated(Note note){
    setState(() {});
  }
}
