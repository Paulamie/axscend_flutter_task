/// Represents a todo returned by JSONPlaceholder `/todos`.
class Todo {
  final int id;
  final int userId;
  final String title;
  final bool completed;

  Todo({
    required this.id,
    required this.userId,
    required this.title,
    required this.completed,
  });

/// Builds a Todo from API JSON.
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as int,
      userId: json['userId'] as int,
      title: (json['title'] ?? '') as String,
      completed: (json['completed'] ?? false) as bool,
    );
  }
}