import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:axscend_flutter_task/services/api_services.dart';

void main() {
  test('fetchUsers returns parsed users when status is 200', () async {
    final client = MockClient((http.Request request) async {
      if (request.url.toString().endsWith('/users')) {
        return http.Response(
          '''
          [
            {"id":1,"name":"Leanne","email":"l@example.com","company":{"name":"A Co"}},
            {"id":2,"name":"Ervin","email":"e@example.com","company":{"name":"B Co"}}
          ]
          ''',
          200,
          headers: {'content-type': 'application/json'},
        );
      }
      return http.Response('Not Found', 404);
    });

    final api = ApiService(client: client);
    final users = await api.fetchUsers();

    expect(users.length, 2);
    expect(users.first.name, 'Leanne');
    expect(users.first.companyName, 'A Co');
  });

  test('fetchTodosByUser returns parsed todos for user when status is 200', () async {
    final client = MockClient((http.Request request) async {
      if (request.url.toString().contains('/todos?userId=1')) {
        return http.Response(
          '''
          [
            {"userId":1,"id":1,"title":"T1","completed":false},
            {"userId":1,"id":2,"title":"T2","completed":true}
          ]
          ''',
          200,
          headers: {'content-type': 'application/json'},
        );
      }
      return http.Response('Not Found', 404);
    });

    final api = ApiService(client: client);
    final todos = await api.fetchTodosByUser(1);

    expect(todos.length, 2);
    expect(todos.where((t) => t.completed).length, 1);
  });

  test('fetchUsers throws a readable error on non-200', () async {
    final client = MockClient((_) async => http.Response('Server error', 500));
    final api = ApiService(client: client);

    expect(
      () async => api.fetchUsers(),
      throwsA(isA<Exception>()),
    );
  });
}