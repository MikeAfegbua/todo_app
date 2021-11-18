class Task {
  final String name;
  bool isDone = false;

  Task({required this.name, required this.isDone});

  void toggleDone() {
    isDone = !isDone;
  }
}
