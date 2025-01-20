import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todoey/core/crud_dio_api.dart';
import 'package:todoey/models/task.dart';
import 'package:todoey/models/todo_model.dart';

class TaskProvider extends ChangeNotifier {
  // CREATE - POST
  // READ  - GET
  // UPDATE - PUT
  // DELETE - DELETE

  //  2 s - SUCCESS
  //  4 s - FAILED YOU
  //  5 s - FAILED BACKED

  List<Task> tasks = [
    Task(name: 'Buy Milk', isDone: false),
    Task(name: 'Buy Eggs', isDone: false),
    Task(name: 'Buy Bread', isDone: true),
  ];

  //// GETTERS AND SETTERS

  int taskCountNumber = 0;

  int get taskCount {
    taskCountNumber = todoList.length;
    return taskCountNumber;
  }

  set taskCount(int newNumber) {
    taskCountNumber = newNumber;

    notifyListeners();
  }

  /////

  void addTask(String newTaskTitle) {
    final newTask = Task(name: newTaskTitle, isDone: false);
    tasks.add(newTask);

    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggleDone();

    notifyListeners();
  }

  void removeTask(Task task) {
    tasks.remove(task);

    notifyListeners();
  }

  //////////////////////
  ////////GET-TODO//////
  //////////////////////

  List<Todo> todoList = [];

  Future<void> getMyTodos() async {
    final myList = await TodoService.instance.getTodos();

    if (kDebugMode) print('My list count is ${myList.length}');

    todoList = myList;

    notifyListeners();
  }

  //////////////////////
  ////////CREATE-TODO///
  //////////////////////

  Future<void> createTodo({
    required String title,
    required String description,
    required BuildContext context,
  }) async {
    final response = await TodoService.instance.createTodo(
      title: title,
      description: description,
    );

    const successSnackBar = SnackBar(
      content: Text(
        'Todo created successfully!',
      ),
    );

    const failedSnackBar = SnackBar(
      content: Text(
        'Todo cannot be created, please try again!',
        style: TextStyle(
          color: Colors.red,
        ),
      ),
    );

    if (response) {
      ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
      getMyTodos();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(failedSnackBar);
    }
  }

  //////////////////////
  ////////UPDATE-TODO///
  //////////////////////

  Future<void> updateTodo({
    required String id,
    required String title,
    required String description,
    required bool isCompleted,
    required BuildContext context,
  }) async {
    final response = await TodoService.instance.updateTodo(
      title: title,
      description: description,
      id: id,
      isCompleted: isCompleted,
    );

    const successSnackBar = SnackBar(
      content: Text(
        'Todo updated successfully!',
      ),
    );

    const failedSnackBar = SnackBar(
      content: Text(
        'Todo cannot be updated, please try again!',
        style: TextStyle(
          color: Colors.red,
        ),
      ),
    );

    if (response) {
      ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
      getMyTodos();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(failedSnackBar);
    }
  }
}
