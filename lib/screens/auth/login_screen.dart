import 'package:flutter/material.dart';
import '../../core/services/auth_service.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/custom_button.dart';
import '../admin/admin_home.dart';
import '../user/user_home.dart';
import '../auth/register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    
    final user = await _authService.login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
    
    setState(() => _isLoading = false);

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => user.role == 'admin' ? AdminHome() : UserHome(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed. Invalid credentials')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 32),
              CustomTextField(
                controller: _emailController,
                label: 'Email',
                validator: (value) =>
                    value!.isEmpty ? 'Please enter email' : null,
              ),
              SizedBox(height: 16),
              CustomTextField(
                controller: _passwordController,
                label: 'Password',
                obscureText: true,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter password' : null,
              ),
              SizedBox(height: 24),
              CustomButton(
                text: 'Login',
                onPressed: _isLoading ? null : _login,
                isLoading: _isLoading,
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => RegisterScreen()),
                  );
                },
                child: Text('Don\'t have an account? Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}