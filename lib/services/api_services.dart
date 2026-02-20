import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/user.dart';
import '../models/todo.dart';

class ApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<User>> fetchUsers() async {
    final uri = Uri.parse('$_baseUrl/users');

    try {
      final res = await http.get(uri);
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

  Future<List<Todo>> fetchTodosByUser(int userId) async {
    final uri = Uri.parse('$_baseUrl/todos?userId=$userId');

    try {
      final res = await http.get(uri);
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