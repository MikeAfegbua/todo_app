class Todo {
  final String? id;
  final String? title;
  final String? description;
  final bool? isCompleted;

  Todo({
    this.id,
    this.title,
    this.description,
    this.isCompleted,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['_id'] ?? '' as String?,
      title: json['title'] ?? '' as String?,
      description: json['description'] ?? '' as String?,
      isCompleted: json['is_completed'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
    };
  }
}
