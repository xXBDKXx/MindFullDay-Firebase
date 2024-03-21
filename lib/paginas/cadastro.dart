// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, use_build_context_synchronously, prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mindfullday_v1/User_auth/firebase_auth_services.dart';
import 'package:mindfullday_v1/login_page.dart';
import 'package:mindfullday_v1/util/textfield.dart';


class Cadastro extends StatefulWidget {
  Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController nomeController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    nomeController.dispose();
    senhaController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override

  Widget build(BuildContext context) {
    const logo = "assets/imagens/logo.png";
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(134, 150, 254, 1),
        body: ListView(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                  //MediaQuery e um metodo de pegar o tamanho do dispositivo
                  maxHeight: MediaQuery.of(context).size.height,
                  maxWidth: MediaQuery.of(context).size.width,
                ),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/imagens/bg-login.png'),
                    fit: BoxFit.cover,
                    opacity: 0.5,
                    
                  ),
                ),
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Column(
                        children: [
                          const Image(
                            image: AssetImage(logo),
                            width: 266,
                          ),
                          Text(
                            'Cadastre-se!!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Campotexto(
                        controller: nomeController,
                        hintText: 'Nome',
                        obscureText: false,
                      ),
                      SizedBox(height: 10),
                      Campotexto(
                          controller: emailController,
                          hintText: 'Email',
                          obscureText: false
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Campotexto(
                          controller: senhaController,
                          hintText: 'Senha',
                          obscureText: true
                      ),
                      SizedBox(
                        height: 10
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: _signUp,
                            child: Text('Cadastrar'),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage()),
                              );
                            },
                            child: Text('Voltar'),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _signUp() async {
    String nome = nomeController.text;
    String email = emailController.text;
    String senha = senhaController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, senha);
    await user?.updateDisplayName(nome);
    addUserDetails(
      nome,
      email,
    );

    if (user!= null){
      print("Usuario ");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      showDialog(
        context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Erro'),
              content: Text('Todos os campos devem ser preechidos'),
              actions: <Widget>[
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                }, 
                child: Text('Tentar Novamente'),
              ),
            ],
          );
        },
      );
    }
  }
  Future addUserDetails(String nome, String email) async {

    showDialog(
        context: context, 
        builder: (context){
          return Center(child: CircularProgressIndicator());
        },
      );

    await FirebaseFirestore.instance.collection('users').add({
      'nome': nome,
      'email' : email,
    });

    Navigator.of(context).pop();
  }
}