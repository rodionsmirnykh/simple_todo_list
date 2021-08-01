import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:simple_todo_list/task_list.dart';

void main() {
  runApp(ToDoApp());
}

class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'simple todo list',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Simple todo list'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void setNewCard(String cardLabel) async {
    Map<String, dynamic> tasks = {};
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String str = prefs.getString('tasks') ?? '';
    if (str.isNotEmpty) {
      tasks = json.decode(prefs.getString('tasks') ?? '');
    }

    tasks[DateTime.now().toString()] = cardLabel;
    prefs.setString('tasks', json.encode(tasks));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final newTaskTextController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
            padding: EdgeInsets.all(5),
            child: Column(children: [
              Container(
                child: TextField(
                  controller: newTaskTextController,
                  decoration: InputDecoration(
                    hintText: 'Write new task',
                  ),
                  onSubmitted: (_) {
                    setNewCard(newTaskTextController.text);
                  },
                ),
              ),
              TaskList(),
            ])));
  }
}

/*
*/
