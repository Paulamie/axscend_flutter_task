import 'package:flutter_test/flutter_test.dart';
import 'package:axscend_flutter_task/models/user.dart';

void main() {
  test('User.fromJson parses expected fields', () {
    final json = {
      "id": 1,
      "name": "Leanne Graham",
      "email": "leanne@example.com",
      "company": {"name": "Romaguera-Crona"},
    };

    final user = User.fromJson(json);

    expect(user.id, 1);
    expect(user.name, "Leanne Graham");
    expect(user.email, "leanne@example.com");
    expect(user.companyName, "Romaguera-Crona");
  });

  test('User.fromJson handles missing company safely', () {
    final json = {
      "id": 2,
      "name": "Ervin Howell",
      "email": "ervin@example.com",
      // no company
    };

    final user = User.fromJson(json);

    expect(user.companyName, ""); // your model defaults to empty string
  });
}