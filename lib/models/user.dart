class User {
  final int id;
  final String name;
  final String email;
  final String companyName;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.companyName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final company = json['company'] as Map<String, dynamic>?;
    return User(
      id: json['id'] as int,
      name: (json['name'] ?? '') as String,
      email: (json['email'] ?? '') as String,
      companyName: (company?['name'] ?? '') as String,
    );
  }
}