import 'package:flutter/material.dart';
import 'package:todoey/models/task.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> tasks = [
    Task(name: 'Buy Milk', isDone: false),
    Task(name: 'Buy Eggs', isDone: false),
    Task(name: 'Buy Bread', isDone: true),
  ];

  //// GETTERS AND SETTERS

  int taskCountNumber = 0;

  int get taskCount {
    taskCountNumber = tasks.length;
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
}
