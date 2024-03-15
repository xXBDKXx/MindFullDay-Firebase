// ignore_for_file: prefer_final_fields

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService{
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(String email, String senha) async {
    try {
      UserCredential credential =await _auth.createUserWithEmailAndPassword(email: email, password: senha,);
      return credential.user;
    } catch (e) {
      print('Um erro ocorreu!');
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(String email, String senha) async {
    try {
      UserCredential credential =await _auth.signInWithEmailAndPassword(email: email, password: senha);
      return credential.user;
    } catch (e) {
      print('Um erro ocorreu!');
    }
    return null;
  }

}