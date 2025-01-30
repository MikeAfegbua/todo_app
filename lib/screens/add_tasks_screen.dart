import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:todoey/view_model/task_provider.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({
    super.key,
  });

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String newTaskTitle = '';

  String newTaskTitleDescription = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff757575),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Add Task',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30.0, color: Colors.lightBlueAccent),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (newText) {
                newTaskTitle = newText;
              },
              decoration: const InputDecoration(
                hintText: 'Title',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (text) {
                newTaskTitleDescription = text;
              },
              decoration: const InputDecoration(
                hintText: 'Description',
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            TextButton(
              onPressed: () async {
                // Provider.of<TaskProvider>(context, listen: false).addTask(
                //   newTaskTitle,
                // );

                //  context.read<TaskProvider>().addTask(newTaskTitle);

                await context.read<TaskProvider>().createTodo(
                      title: newTaskTitle,
                      description: newTaskTitleDescription,
                      context: context,
                    );

                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                textStyle: const TextStyle(
                  fontSize: 24,
                ),
              ),
              child: const Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
