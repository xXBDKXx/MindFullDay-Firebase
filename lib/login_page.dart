// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, use_build_context_synchronously, avoid_print
 
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mindfullday_v1/User_auth/firebase_auth_services.dart';
import 'package:mindfullday_v1/paginas/cadastro.dart';
import 'package:mindfullday_v1/homeControl.dart';
import 'package:mindfullday_v1/util/textfield.dart';
 
 
class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController senhaController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
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
                    opacity: 0.5,
                    fit: BoxFit.cover,
                  ),
                ),
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
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Campotexto(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Campotexto(
                        controller: senhaController,
                        hintText: 'Senha',
                        obscureText: true
                      ),
                      SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Esqueceu sua senha?',
                            style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _signIn();
                      },
                      child: Text('Entrar'),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Não é cadastrado?',
                          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))
                        ),
                        const SizedBox(width: 4,),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Cadastro()),
                            );
                          },
                          child: Text(
                            'Cadastre-se agora!',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 72, 33, 243),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _signIn() async {
    String email = emailController.text;
    String senha = senhaController.text;

    showDialog(
        context: context, 
        builder: (context){
          return Center(child: CircularProgressIndicator());
        },
      );

    User? user = await _auth.signInWithEmailAndPassword(email, senha);

    Navigator.of(context).pop();

    if (user!= null){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } else {
      showDialog(
        context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Erro'),
              content: Text('Usuario ou Senha Incorreto!!'),
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
}