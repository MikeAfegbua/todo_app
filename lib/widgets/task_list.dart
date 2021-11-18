// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'task_tile.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/task_data.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (BuildContext context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return TaskTile(
              isChecked: Provider.of<TaskData>(context)
                  .tasks[index]
                  .isDone, //or taskData.tasks[index].isDone
              taskTitle: Provider.of<TaskData>(context).tasks[index].name,
              checkboxCallback: (checkboxState) {
                taskData.updateTask(taskData.tasks[index]);
              },
              onlongpressCallback: () {
                taskData.removeTask(taskData.tasks[index]);
              },
            );
          },
          itemCount: Provider.of<TaskData>(context).tasks.length,
        );
      },
    );
  }
}
