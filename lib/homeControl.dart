// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names

import 'package:flutter/material.dart';
import 'package:mindfullday_v1/paginas/calendario.dart';
import 'package:mindfullday_v1/paginas/homeUser.dart';
import 'package:mindfullday_v1/paginas/notas.dart';

class Home extends StatefulWidget {
  const Home( {super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  void _navigateBottomBar(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    HomeUser(),
    Notas(),
    Calendario(),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon((Icons.home)),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon((Icons.notes)),
            label: 'Notas'
          ),
          BottomNavigationBarItem(
            icon: Icon((Icons.calendar_month_outlined)),
            label: 'Calendario'
          ),
        ],
      ),
    );
  }
}