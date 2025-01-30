import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/task_provider.dart';

class SingleTaskScreen extends StatefulWidget {
  const SingleTaskScreen({super.key});

  @override
  State<SingleTaskScreen> createState() => _SingleTaskScreenState();
}

class _SingleTaskScreenState extends State<SingleTaskScreen> {
  @override
  Widget build(BuildContext context) {
    final taskProviderRef = context.watch<TaskProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Current Task',
        ),
      ),
      body: ListView(
        children: [
          Center(
            child: ListTile(
              leading: const Text(
                'Task',
              ),
              title: Text(
                taskProviderRef.singleTodo?.title ?? '',
                style: TextStyle(
                  decoration: (taskProviderRef.singleTodo?.isCompleted ?? false)
                      ? TextDecoration.lineThrough
                      : null,
                  fontSize: 20,
                ),
              ),
              subtitle: Text(
                taskProviderRef.singleTodo?.description ?? 'N/A',
                style: TextStyle(
                  decoration: (taskProviderRef.singleTodo?.isCompleted ?? false)
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
              trailing: Checkbox(
                activeColor: Colors.lightBlueAccent,
                value: (taskProviderRef.singleTodo?.isCompleted ?? false),
                onChanged: (value) {
                  taskProviderRef.updateTodo(
                    id: taskProviderRef.singleTodo?.id ?? '',
                    title: taskProviderRef.singleTodo?.title ?? '',
                    description: taskProviderRef.singleTodo?.description ?? '',
                    isCompleted: value ?? false,
                    context: context,
                  );
                },
              ),
              onLongPress: () {
                taskProviderRef.deleteTodoById(
                  id: taskProviderRef.singleTodo?.id ?? '',
                  context: context,
                );

                Future.delayed(const Duration(seconds: 3), () {
                  Navigator.of(context).pop();
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
