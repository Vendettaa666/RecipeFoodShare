class User {
  final String id;
  final String name;
  final String email;
  final String role; // 'admin' or 'user'
  final DateTime? registeredAt;
  final int? points; // Contoh field khusus user

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.registeredAt,
    this.points = 0,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? 'user',
      registeredAt: map['registeredAt'] != null 
          ? DateTime.parse(map['registeredAt']) 
          : null,
      points: map['points'] ?? 0,
    );
  }
}