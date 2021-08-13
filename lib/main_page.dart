import 'package:flutter/material.dart';
import 'package:simple_todo_list/task_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final newTaskTextController = TextEditingController();

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
    return Container(
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
      ]),
    );
  }
}
