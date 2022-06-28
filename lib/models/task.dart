class Task {
  final String name;
  bool isDone = false; // no need for false since required

  Task({required this.name, required this.isDone});

  void toggleDone() {
    isDone = !isDone;
  }
}
