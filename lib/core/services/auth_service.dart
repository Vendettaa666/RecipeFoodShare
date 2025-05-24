import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/user_model.dart' as app_models;

class AuthService {
  final supabase = Supabase.instance.client;
  app_models.User? _currentUser;

  app_models.User? get currentUser => _currentUser;

  // Helper method to parse DateTime
  DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    
    if (value is DateTime) return value;
    
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (e) {
        print('Error parsing date: $e');
        return null;
      }
    }
    
    return null;
  }

  // Login with email and password
  Future<app_models.User?> login(String email, String password) async {
    try {
      // Pastikan email menggunakan domain yang valid
      String validatedEmail = _ensureValidEmailDomain(email);
      
      // Authenticate with Supabase
      final response = await supabase.auth.signInWithPassword(
        email: validatedEmail,
        password: password,
      );
      
      if (response.user == null) {
        return null;
      }
      
      try {
        // Get user profile with role information
        final userData = await supabase
            .from('profiles')
            .select('id, name, email, role')
            .eq('id', response.user!.id)
            .maybeSingle();
        
        if (userData == null) {
          // Create profile if it doesn't exist
          await supabase.from('profiles').insert({
            'id': response.user!.id,
            'name': response.user!.userMetadata?['name'] ?? 'User',
            'email': validatedEmail,
            'role': 'user',
            'created_at': DateTime.now().toIso8601String(),
            'updated_at': DateTime.now().toIso8601String(),
          });
          
          // Fetch the newly created profile
          final newUserData = await supabase
              .from('profiles')
              .select('id, name, email, role')
              .eq('id', response.user!.id)
              .single();
              
          // Create user model from the data
          _currentUser = app_models.User(
            id: response.user!.id,
            name: newUserData['name'] ?? '',
            email: newUserData['email'] ?? validatedEmail,
            role: newUserData['role'] ?? 'user',
            registeredAt: _parseDateTime(response.user!.createdAt),
          );
        } else {
          // Create user model from the data
          _currentUser = app_models.User(
            id: response.user!.id,
            name: userData['name'] ?? '',
            email: userData['email'] ?? validatedEmail,
            role: userData['role'] ?? 'user',
            registeredAt: _parseDateTime(response.user!.createdAt),
          );
        }
        
        return _currentUser;
      } catch (e) {
        print('Error getting/creating profile: $e');
        
        // Return a basic user model if profile access fails
        _currentUser = app_models.User(
          id: response.user!.id,
          name: response.user!.userMetadata?['name'] ?? 'User',
          email: validatedEmail,
          role: 'user',
          registeredAt: _parseDateTime(response.user!.createdAt),
        );
        
        return _currentUser;
      }
    } catch (e) {
      print('Login error: $e');
      rethrow; // Rethrow to handle specific errors in the UI
    }
  }

  // Register new user
  Future<app_models.User?> register(String name, String email, String password) async {
    try {
      // Pastikan email menggunakan domain yang valid
      String validatedEmail = _ensureValidEmailDomain(email);
      
      // Register with Supabase with emailRedirectTo parameter to disable email confirmation
      final response = await supabase.auth.signUp(
        email: validatedEmail,
        password: password,
        emailRedirectTo: null, // Disable email redirect to prevent confirmation email
        data: {
          'name': name,
          'confirmed': true, // Indicate the email is confirmed
        },
      );
      
      if (response.user == null) {
      return null;
      }
      
      // Automatically confirm the email in the database
      try {
        // Directly update the auth.users table to confirm the email
        await supabase.rpc('confirm_user_email_manually', params: {
          'user_email': validatedEmail,
        });
      } catch (e) {
        print('Auto confirm email failed: $e');
        // Continue anyway
      }
      
      // Manually create profile in case the trigger doesn't work
      try {
        // Check if profile already exists
        final existingProfile = await supabase
            .from('profiles')
            .select('id')
            .eq('id', response.user!.id)
            .maybeSingle();
            
        if (existingProfile == null) {
          // Create profile if it doesn't exist
          await supabase.from('profiles').insert({
            'id': response.user!.id,
            'name': name,
            'email': validatedEmail,
            'role': 'user',
            'created_at': DateTime.now().toIso8601String(),
            'updated_at': DateTime.now().toIso8601String(),
          });
        }
      } catch (e) {
        print('Error creating profile: $e');
        // Continue anyway, as the trigger might have created the profile
      }
      
      // Langsung login setelah register untuk mendapatkan session
      try {
        await supabase.auth.signInWithPassword(
          email: validatedEmail,
          password: password,
        );
      } catch (e) {
        print('Auto login after register failed: $e');
        // Continue anyway
      }
      
      // Create user model
      _currentUser = app_models.User(
        id: response.user!.id,
        name: name,
        email: validatedEmail,
        role: 'user',
        registeredAt: _parseDateTime(response.user!.createdAt),
      );
      
      return _currentUser;
    } catch (e) {
      print('Registration error: $e');
      rethrow; // Rethrow the error to handle it in the UI
    }
  }
  
  // Public method to confirm email that can be called from UI
  Future<bool> confirmEmail(String email) async {
    try {
      // Try multiple methods to confirm the email
      
      // Method 1: Try using the RPC function
      try {
        await supabase.rpc('confirm_user_email_manually', params: {
          'user_email': email,
        });
        print('Email confirmed successfully using RPC');
        return true;
      } catch (rpcError) {
        print('RPC method failed: $rpcError');
      }
      
      // Method 2: Try using OTP
      try {
        await supabase.auth.signInWithOtp(
          email: email,
          shouldCreateUser: false,
        );
        print('OTP sent to email for verification');
        // We'll consider this a success since the user will receive an email
        return true;
      } catch (otpError) {
        print('OTP method failed: $otpError');
      }
      
      // If we reach here, all methods failed
      return false;
    } catch (e) {
      print('Error in confirmEmail: $e');
      return false;
    }
  }

  // Memastikan email menggunakan domain yang valid
  String _ensureValidEmailDomain(String email) {
    if (!email.contains('@')) {
      // Jika tidak ada @, tambahkan domain default
      return '$email@gmail.com';
    }
    
    final parts = email.split('@');
    if (parts.length != 2) {
      // Format email tidak valid, tambahkan domain default
      return '$email@gmail.com';
    }
    
    final domain = parts[1];
    // Daftar domain yang diketahui valid
    final validDomains = [
      'gmail.com', 'yahoo.com', 'hotmail.com', 'outlook.com',
      'icloud.com', 'mail.com', 'protonmail.com', 'zoho.com',
      'aol.com', 'yandex.com', 'gmx.com', 'live.com',
      'example.com' // Untuk testing
    ];
    
    if (validDomains.contains(domain.toLowerCase())) {
      return email; // Domain sudah valid
    }
    
    // Jika domain tidak dikenal, ganti dengan gmail.com
    return '${parts[0]}@gmail.com';
  }

  // Logout user
  Future<void> logout() async {
    await supabase.auth.signOut();
    _currentUser = null;
  }
  
  // Check if user is admin
  bool isAdmin() {
    return _currentUser?.role == 'admin';
  }
  
  // Check if user is regular user
  bool isUser() {
    return _currentUser?.role == 'user';
  }
  
  // Get current session
  Future<app_models.User?> getCurrentUser() async {
    try {
      final session = supabase.auth.currentSession;
      if (session == null) return null;
      
      // Get user profile with role information
      final userData = await supabase
          .from('profiles')
          .select('id, name, email, role')
          .eq('id', session.user.id)
          .maybeSingle(); // Use maybeSingle instead of single to handle case when profile doesn't exist yet
      
      if (userData == null) {
        print('No profile found for user ${session.user.id}');
        
        // Try to create a profile for the user
        try {
          final userEmail = session.user.email;
          final userName = session.user.userMetadata?['name'] ?? 'User';
          
          await supabase.from('profiles').insert({
            'id': session.user.id,
            'name': userName,
            'email': userEmail ?? '',
            'role': 'user',
            'created_at': DateTime.now().toIso8601String(),
            'updated_at': DateTime.now().toIso8601String(),
          });
          
          // Create user model with default values
          _currentUser = app_models.User(
            id: session.user.id,
            name: userName,
            email: userEmail ?? '',
            role: 'user',
            registeredAt: _parseDateTime(session.user.createdAt),
          );
          
          return _currentUser;
        } catch (e) {
          print('Error creating profile in getCurrentUser: $e');
          return null;
        }
      }
      
      // Create user model
      _currentUser = app_models.User(
        id: session.user.id,
        name: userData['name'] ?? '',
        email: userData['email'] ?? session.user.email ?? '',
        role: userData['role'] ?? 'user',
        registeredAt: _parseDateTime(session.user.createdAt),
      );
      
      return _currentUser;
    } catch (e) {
      print('Get current user error: $e');
      return null;
    }
  }
}