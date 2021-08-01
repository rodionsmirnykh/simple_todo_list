import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:simple_todo_list/task_card.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  Future<String> get getCards async {
    Map<String, dynamic> tasks = {};

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String str = prefs.getString('tasks') ?? '';
    if (str.isNotEmpty) {
      tasks = json.decode(prefs.getString('tasks') ?? '');
    }
    return json.encode(tasks);
  }

  void removeTask(String id) async {
    Map<String, dynamic> tasks = {};
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String str = prefs.getString('tasks') ?? '';
    if (str.isNotEmpty) {
      tasks = json.decode(prefs.getString('tasks') ?? '');
    }
    tasks.remove(id);
    prefs.setString('tasks', json.encode(tasks));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCards,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            Map<String, dynamic> cardMap =
                json.decode(snapshot.data.toString());
            return Container(
              height: 300,
              child: ListView(
                  children: cardMap.entries.map((entry) {
                return TaskCard(
                    entry.key.toString(), entry.value.toString(), removeTask);
              }).toList()),
            );
          } else {
            return Text(
              'No tasks',
              textAlign: TextAlign.center,
            );
          }
        });
  }
}
