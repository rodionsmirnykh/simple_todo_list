import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String id;
  final String taskLabel;
  final Function func;

  TaskCard(this.id, this.taskLabel, this.func);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.all(15),
                    child: Text(
                      taskLabel,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    child: IconButton(
                      onPressed: () {
                        func(id);
                      },
                      icon: Icon(Icons.close),
                      alignment: Alignment.centerRight,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
