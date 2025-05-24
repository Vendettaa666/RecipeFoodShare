import 'package:flutter/material.dart';
import '../../core/services/auth_service.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/custom_button.dart';
import '../admin/dashboard.dart';
import '../user/screens/user_home.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;
  bool _obscurePassword = true;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Validasi email yang lebih sederhana
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    
    // Validasi dasar: harus ada @ atau minimal 3 karakter
    if (value.length < 3) {
      return 'Email too short';
    }
    
    return null;
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      setState(() => _isLoading = false);
      return;
    }
    
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    
    try {
      final user = await _authService.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      
      if (user != null) {
        if (!mounted) return;
        
        // Route based on user role
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => user.role == 'admin' 
                ? const DashboardPage() 
                : const HomeScreen(),
          ),
        );
      } else {
        setState(() {
          _errorMessage = 'Login failed. Please check your email and password.';
        });
      }
    } catch (e) {
      setState(() {
        if (e.toString().contains('Invalid login credentials')) {
          _errorMessage = 'Invalid email or password. Please try again.';
        } else if (e.toString().contains('Email not confirmed')) {
          _handleEmailNotConfirmed();
        } else if (e.toString().contains('invalid')) {
          _errorMessage = 'Please use a valid email address (e.g., user@gmail.com).';
        } else {
          _errorMessage = 'An error occurred: ${e.toString().split(']').last}';
        }
        print('Login error: $e');
      });
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
  
  // Handle "Email not confirmed" error by automatically confirming the email
  Future<void> _handleEmailNotConfirmed() async {
    setState(() {
      _errorMessage = 'Confirming your email...';
    });
    
    try {
      final email = _emailController.text.trim();
      final success = await _authService.confirmEmail(email);
      
      if (success) {
        // Try to login again after confirming email
        try {
          final user = await _authService.login(
            email,
            _passwordController.text.trim(),
          );
          
          if (user != null && mounted) {
            // Route based on user role
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => user.role == 'admin' 
                    ? const DashboardPage() 
                    : const HomeScreen(),
              ),
            );
          } else if (mounted) {
            setState(() {
              _errorMessage = 'Email confirmed, but login failed. Please try again.';
            });
          }
        } catch (loginError) {
          if (mounted) {
            setState(() {
              _errorMessage = 'Login failed after email confirmation: ${loginError.toString().split(']').last}';
            });
          }
        }
      } else {
        // Show a dialog with manual verification option
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
          _showManualVerificationDialog(email);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Error confirming email: ${e.toString().split(']').last}';
          _isLoading = false;
        });
      }
    }
  }
  
  // Show dialog with manual verification options
  void _showManualVerificationDialog(String email) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Email Verification Required'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('We couldn\'t automatically verify your email.'),
                const SizedBox(height: 10),
                const Text('Please try one of these options:'),
                const SizedBox(height: 10),
                const Text('1. Check your email inbox for a verification link'),
                const SizedBox(height: 5),
                const Text('2. Try again later'),
                const SizedBox(height: 5),
                const Text('3. Contact support if the problem persists'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Try Again'),
              onPressed: () {
                Navigator.of(context).pop();
                _login();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _errorMessage = 'Please verify your email before logging in.';
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.orange.shade50,
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.08,
                      vertical: screenSize.height * 0.04,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: screenSize.height * 0.04),
                          Text(
                            'Welcome Back',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  color: Colors.orange.shade800,
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenSize.width * 0.06,
                                ),
                          ),
                          SizedBox(height: screenSize.height * 0.01),
                          Text(
                            'Please sign in to continue',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Colors.grey.shade700,
                                  fontSize: screenSize.width * 0.035,
                                ),
                          ),
                          SizedBox(height: screenSize.height * 0.06),
                          Container(
                            constraints: const BoxConstraints(
                              maxWidth: 500,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(screenSize.width * 0.05),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.orange.withOpacity(0.1),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(screenSize.width * 0.06),
                              child: Column(
                                children: [
                                  if (_errorMessage != null)
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 16.0),
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.red.shade50,
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(color: Colors.red.shade200),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.error_outline, color: Colors.red),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                _errorMessage!,
                                                style: const TextStyle(color: Colors.red),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  CustomTextField(
                                    controller: _emailController,
                                    label: 'Email Address',
                                    hintText: 'Enter your email',
                                    prefixIcon: Icon(Icons.email_outlined, color: Colors.orange.shade800),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: _validateEmail,
                                  ),
                                  SizedBox(height: screenSize.height * 0.025),
                                  CustomTextField(
                                    controller: _passwordController,
                                    label: 'Password',
                                    hintText: 'Enter your password',
                                    prefixIcon: Icon(Icons.lock_outline, color: Colors.orange.shade800),
                                    obscureText: _obscurePassword,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscurePassword
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.orange.shade800,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscurePassword = !_obscurePassword;
                                        });
                                      },
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password';
                                      }
                                      if (value.length < 6) {
                                        return 'Password must be at least 6 characters';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: screenSize.height * 0.01),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () {
                                        // Add forgot password functionality
                                      },
                                      child: Text(
                                        'Forgot Password?',
                                        style: TextStyle(
                                          color: Colors.orange.shade800,
                                          fontSize: screenSize.width * 0.035,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: screenSize.height * 0.03),
                                  SizedBox(
                                    width: double.infinity,
                                    child: CustomButton(
                                      text: 'Sign In',
                                      onPressed: _isLoading ? null : _login,
                                      isLoading: _isLoading,
                                      backgroundColor: Colors.orange.shade800,
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.04),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account? ',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: screenSize.width * 0.035,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const RegisterScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Colors.orange.shade800,
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenSize.width * 0.035,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}