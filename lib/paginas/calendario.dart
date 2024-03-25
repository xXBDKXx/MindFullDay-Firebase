// ignore_for_file: prefer_const_constructors

import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mindfullday_v1/util/sidebar.dart';
import 'package:table_calendar/table_calendar.dart';

class Event {
  final String title;
  final String? description;
  final DateTime date;
  final String id;
  final String email;
  Event({
    required this.title,
    this.description,
    required this.date,
    required this.id,
    required this.email,
  });

  factory Event.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      [SnapshotOptions? options]) {
    final data = snapshot.data()!;
    return Event(
      date: data['Data'].toDate(),
      title: data['Titulo'],
      description: data['Descrição'],
      id: snapshot.id, 
      email: data['Email'],
    );
  }

  Map<String, Object?> toFirestore() {
    return {
      "Data": Timestamp.fromDate(date),
      "Titulo": title,
      "Descrição": description
    };
  }
}

class Calendario extends StatefulWidget {
  const Calendario({super.key});

  @override
  State<Calendario> createState() => _CalendarioPageState();
}

class _CalendarioPageState extends State<Calendario> {
  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;
  late DateTime _selectedDay;
  late CalendarFormat _calendarFormat;
  late Map<DateTime, List<Event>> _events;

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  @override
  void initState() {
    super.initState();
    _events = LinkedHashMap(
      equals: isSameDay,
      hashCode: getHashCode,
    );
    _focusedDay = DateTime.now();
    _firstDay = DateTime.now().subtract(const Duration(days: 1000));
    _lastDay = DateTime.now().add(const Duration(days: 1000));
    _selectedDay = DateTime.now();
    _calendarFormat = CalendarFormat.month;
    _loadFirestoreEvents();
  }

  _loadFirestoreEvents() async {
  _events = {};

  final userEmail = FirebaseAuth.instance.currentUser!.email!;

  final snap = await FirebaseFirestore.instance
      .collection('tarefas')
      .where('Email', isEqualTo: userEmail) // Add this line to filter by email
      .withConverter(
          fromFirestore: Event.fromFirestore,
          toFirestore: (event, options) => event.toFirestore())
      .get();
  for (var doc in snap.docs) {
    final event = doc.data();
    final day = DateTime.utc(event.date.year, event.date.month, event.date.day);
    if (_events[day] == null) {
      _events[day] = [];
    }
    _events[day]!.add(event);
  }
  setState(() {});
}


  List<Event> _getEventsForTheDay(DateTime day) {
    return _events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      drawer: SideBar(),
      appBar: AppBar(title: const Text('Calendario')),
      body: ListView(
        children: [
          TableCalendar(
            locale: 'pt-BR', 
            headerStyle: HeaderStyle(formatButtonVisible: true,titleCentered: true),
            eventLoader: _getEventsForTheDay,
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            focusedDay: _focusedDay,
            firstDay: _firstDay,
            lastDay: _lastDay,
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
              _loadFirestoreEvents();
            },
            selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
            onDaySelected: (selectedDay, focusedDay) {
              print(_events[selectedDay]);
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: const CalendarStyle(
              weekendTextStyle: TextStyle(
                color: Colors.red,
              ),
              selectedDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.red,
              ),
            ),
            calendarBuilders: CalendarBuilders(
              headerTitleBuilder: (context, day) {
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(day.toString()),
                );
              },
            ),
          ),
          ..._getEventsForTheDay(_selectedDay).map(
            (event) => ListTile(
              title: Text(
                event.title,
              ),
              subtitle: Text(
                event.date.toString(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push<bool>(
            context,
            MaterialPageRoute(
              builder: (_) => AddEvent(
                firstDate: _firstDay,
                lastDate: _lastDay,
                selectedDate: _focusedDay,
              ),
            ),
          );
          if (result ?? false) {
            _loadFirestoreEvents();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddEvent extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? selectedDate;
  const AddEvent(
      {Key? key,
      required this.firstDate,
      required this.lastDate,
      this.selectedDate})
      : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  late DateTime _selectedDate;
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Adicionar Tarefa")),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          InputDatePickerFormField(
            firstDate: widget.firstDate,
            lastDate: widget.lastDate,
            initialDate: _selectedDate,
            onDateSubmitted: (date) {
              print(date);
              setState(() {
                _selectedDate = date;
              });
            },
          ),
          TextField(
            controller: _titleController,
            maxLines: 1,
            decoration: const InputDecoration(labelText: 'Titulo'),
          ),
          TextField(
            controller: _descController,
            maxLines: 5,
            decoration: const InputDecoration(labelText: 'Descrição'),
          ),
          ElevatedButton(
            onPressed: () {
              _addEvent();
            },
            child: const Text("Criar Tarefa"),
          ),
        ],
      ),
    );
  }

  void _addEvent() async {
    final title = _titleController.text;
    final description = _descController.text;
    if (title.isEmpty) {
      print('Titulo não pode ficar vazio');
      return;
    }
    await FirebaseFirestore.instance.collection('tarefas').add({
      "Titulo": title,
      "Descrição": description,
      "Data": Timestamp.fromDate(_selectedDate),
      "Email": FirebaseAuth.instance.currentUser!.email!,
    });
    if (mounted) {
      Navigator.pop<bool>(context, true);
    }
  }
}