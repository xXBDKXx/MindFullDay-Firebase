// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, prefer_const_literals_to_create_immutables

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mindfullday_v1/login_page.dart';
import 'package:intl/date_symbol_data_local.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseOptions(apiKey: "AIzaSyCzt8-tCQWslYtbDIpyjymba1ioB9mSRj0", appId: "1:691378528376:web:92950413d3f5579bfa0d8d", messagingSenderId: "691378528376", projectId: "mindfullday"));
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MindFullDay',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: LoginPage(),
     /*  localizationsDelegates: [
        GlobalKey.delegate; // Enables the use of Flutter'
      ],
       supportedLocales: [
         const Locale('en'),
         const Locale('fr')
       ], */
    );
  }
}
