import 'package:flutter_test/flutter_test.dart';
import 'package:axscend_flutter_task/models/todo.dart';

// Unit tests for model parsing. Ensures JSON → Dart mapping is correct.
void main() {
  test('Todo.fromJson parses expected fields', () {
    final json = {
      "userId": 1,
      "id": 1,
      "title": "delectus aut autem",
      "completed": false,
    };

    final todo = Todo.fromJson(json);

    expect(todo.userId, 1);
    expect(todo.id, 1);
    expect(todo.title, "delectus aut autem");
    expect(todo.completed, false);
  });
}