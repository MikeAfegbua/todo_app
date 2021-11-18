// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  const TaskTile(
      {required this.isChecked,
      required this.taskTitle,
      required this.checkboxCallback,
      required this.onlongpressCallback});

  final bool isChecked;
  final String taskTitle;
  final Function(bool?) checkboxCallback;
  final Function() onlongpressCallback;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: onlongpressCallback,
      leading: Text(
        taskTitle,
        style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null),
      ),
      trailing: Checkbox(
        activeColor: Colors.lightBlueAccent,
        value: isChecked,
        onChanged: checkboxCallback,
      ),
    );
  }
}
