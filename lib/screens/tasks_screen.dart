import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/screens/add_tasks_screen.dart';
import 'package:todoey/screens/single_task_screen.dart';
import 'package:todoey/view_model/task_provider.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({
    super.key,
  });

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    final taskProviderRef1 = context.watch<TaskProvider>(); // OPTION 1
    // final taskProviderRef2 =
    //   Provider.of<TaskProvider>(context, listen: true); // OPTION 2

    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => const AddTaskScreen(),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 30.0,
                left: 30.0,
                right: 30.0,
                bottom: 30.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      taskProviderRef1.getMyTodos();
                    },
                    child: const CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.list,
                        size: 30.0,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'Todoey',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '${taskProviderRef1.taskCount} tasks', // uses getter // OPTION 2
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Consumer<TaskProvider>(
                  // OPTION 3
                  builder: (context, taskProvider, child) {
                    return taskProvider.todoList.isNotEmpty
                        ? ListView.separated(
                            itemCount: taskProvider.todoList.length,
                            itemBuilder: (context, index) {
                              final taskItem = taskProvider.todoList[index];

                              return ListTile(
                                leading: Text(
                                  '${index + 1}',
                                ),
                                title: Text(
                                  taskItem.title ?? 'N/A',
                                  style: TextStyle(
                                    decoration: (taskItem.isCompleted ?? false)
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                ),
                                subtitle: Text(
                                  taskItem.description ?? 'N/A',
                                  style: TextStyle(
                                    decoration: (taskItem.isCompleted ?? false)
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                ),
                                trailing: Checkbox(
                                  activeColor: Colors.lightBlueAccent,
                                  value: (taskItem.isCompleted ?? false),
                                  onChanged: (value) {
                                    taskProvider.updateTodo(
                                      id: taskItem.id ?? '',
                                      title: taskItem.title ?? '',
                                      description: taskItem.description ?? '',
                                      isCompleted: value ?? false,
                                      context: context,
                                    );
                                  },
                                ),
                                onLongPress: () {
                                  taskProvider.deleteTodoById(
                                    id: taskItem.id ?? '',
                                    context: context,
                                  );
                                },
                                onTap: () async {
                                  final response =
                                      await taskProvider.getSingleTodo(
                                    id: taskItem.id ?? '',
                                  );

                                  if (response) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            const SingleTaskScreen(),
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 5,
                            ),
                          )
                        : const Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'No todo available!',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Your todos will be shown here.',
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
