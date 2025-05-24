import 'package:flutter/material.dart';
import 'package:recipes_food_share/feature/user/screens/user_home.dart';
import 'package:recipes_food_share/feature/admin/dashboard.dart';
import 'package:recipes_food_share/feature/auth/login_screen.dart';
import 'package:recipes_food_share/core/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: 'https://hloxiccaoidufqzalyld.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imhsb3hpY2Nhb2lkdWZxemFseWxkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc1NTQyNjksImV4cCI6MjA2MzEzMDI2OX0.IaiG5R-qbzBz6FQ3yyHBuyjXKxGXnO3_wpnBdZ296jM',
  );
  
  runApp(const RecipesFoodShare());
}

class RecipesFoodShare extends StatefulWidget {
  const RecipesFoodShare({super.key});

  @override
  State<RecipesFoodShare> createState() => _RecipesFoodShareState();
}

class _RecipesFoodShareState extends State<RecipesFoodShare> {
  final _authService = AuthService();
  bool _isLoading = true;
  bool _isAuthenticated = false;
  String _userRole = 'user';

  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }

  Future<void> _checkCurrentUser() async {
    final user = await _authService.getCurrentUser();
    setState(() {
      _isAuthenticated = user != null;
      _userRole = user?.role ?? 'user';
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Food Share',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Define named routes
      routes: {
        '/': (context) => _isLoading
            ? const _LoadingScreen()
            : _isAuthenticated
                ? _userRole == 'admin'
                    ? const DashboardPage()
                    : const HomeScreen()
                : const LoginScreen(),
        '/login': (context) => const LoginScreen(),
        '/admin': (context) => const DashboardPage(),
        '/home': (context) => const HomeScreen(),
      },
      initialRoute: '/',
    );
  }
}

class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}