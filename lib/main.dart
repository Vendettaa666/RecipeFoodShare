import 'package:flutter/material.dart';
import 'package:recipes_food_share/feature/auth/login_screen.dart';
import 'package:recipes_food_share/feature/user/screens/user_home.dart';
import 'package:recipes_food_share/models/user_model.dart';

void main() {
  runApp(RecipesFoodShare());
}

class RecipesFoodShare extends StatelessWidget {
  const RecipesFoodShare({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login Roles',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}