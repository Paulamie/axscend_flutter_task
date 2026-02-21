import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/user.dart';
import '../models/todo.dart';

// API layer for JSONPlaceholder.
/// Keeps networking separate from UI code to improve maintainability and testability.
class ApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  // Injected HTTP client allows mocking in unit tests.
  final http.Client _client;

  ApiService({http.Client? client}) : _client = client ?? http.Client();

  /// Fetches list of users from `/users`.
  /// Throws an Exception on non-200 responses or parsing errors.
  Future<List<User>> fetchUsers() async {
    final uri = Uri.parse('$_baseUrl/users');

    try {
      final res = await _client.get(uri);
      if (res.statusCode != 200) {
        throw Exception('Failed to load users (HTTP ${res.statusCode}).');
      }

      final List<dynamic> data = jsonDecode(res.body) as List<dynamic>;
      return data
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Could not fetch users. ${e.toString()}');
    }
  }
  /// Fetches todos for a specific user from `/todos?userId={id}`.
  /// Throws an Exception on non-200 responses or parsing errors.
  Future<List<Todo>> fetchTodosByUser(int userId) async {
    final uri = Uri.parse('$_baseUrl/todos?userId=$userId');

    try {
      final res = await _client.get(uri);
      if (res.statusCode != 200) {
        throw Exception('Failed to load todos (HTTP ${res.statusCode}).');
      }

      final List<dynamic> data = jsonDecode(res.body) as List<dynamic>;
      return data
          .map((e) => Todo.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Could not fetch todos. ${e.toString()}');
    }
  }
}