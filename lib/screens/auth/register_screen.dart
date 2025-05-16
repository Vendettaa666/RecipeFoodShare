import 'package:flutter/material.dart';
import '../../core/services/auth_service.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/custom_button.dart';
import '../user/user_home.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    setState(() => _isLoading = true);
    
    final user = await _authService.register(
      _nameController.text.trim(),
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
    
    setState(() => _isLoading = false);

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => UserHome()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed. Email may already exist')),
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
                'Register',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 32),
              CustomTextField(
                controller: _nameController,
                label: 'Name',
                validator: (value) =>
                    value!.isEmpty ? 'Please enter name' : null,
              ),
              SizedBox(height: 16),
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
              SizedBox(height: 16),
              CustomTextField(
                controller: _confirmPasswordController,
                label: 'Confirm Password',
                obscureText: true,
                validator: (value) =>
                    value!.isEmpty ? 'Please confirm password' : null,
              ),
              SizedBox(height: 24),
              CustomButton(
                text: 'Register',
                onPressed: _isLoading ? null : _register,
                isLoading: _isLoading,
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}