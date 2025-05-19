import '../../models/user_model.dart';

class AuthService {
  // Daftar user dengan satu admin default dan satu user contoh
  final List<User> _users = [
    User(
      id: '1',
      name: 'Admin',
      email: 'admin@example.com',
      role: 'admin',
    ),
    User(
      id: '2',
      name: 'John Doe',
      email: 'user@example.com',
      role: 'user',
    ),
  ];

  User? _currentUser;

  User? get currentUser => _currentUser;

  Future<User?> login(String email, String password) async {
    // Simulasi delay network
    await Future.delayed(const Duration(seconds: 1));
    
    try {
      // Cari user dengan email yang sesuai
      final user = _users.firstWhere(
        (user) => user.email == email,
      );
      
      // Password sederhana untuk demo (dalam real app, gunakan hashing)
      String correctPassword = user.role == 'admin' ? 'admin123' : 'user123';
      if (password == correctPassword) {
        _currentUser = user;
        return user;
      }
      return null;
    } catch (e) {
      // Jika email tidak ditemukan
      return null;
    }
  }

  Future<User?> register(String name, String email, String password) async {
    // Simulasi delay network
    await Future.delayed(const Duration(seconds: 1));
    
    // Cek jika email sudah terdaftar
    final emailExists = _users.any((user) => user.email == email);
    if (emailExists) {
      return null;
    }
    
    // Buat user baru
    final newUser = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      role: 'user', // Default role adalah user
    );
    
    // Tambahkan user baru dan set sebagai current user
    _users.add(newUser);
    _currentUser = newUser;
    return newUser;
  }

  void logout() {
    _currentUser = null;
  }
  
  // Method untuk mendapatkan semua users (berguna untuk admin)
  List<User> getAllUsers() {
    return List.from(_users);
  }
  
  // Method untuk mengecek apakah user adalah admin
  bool isAdmin() {
    return _currentUser?.role == 'admin';
  }
  
  // Method untuk mengecek apakah user adalah user biasa
  bool isUser() {
    return _currentUser?.role == 'user';
  }
}