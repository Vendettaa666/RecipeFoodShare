import 'package:flutter/material.dart';
import 'package:recipes_food_share/feature/user/screens/search_screen.dart';
import 'package:recipes_food_share/feature/user/screens/profile_screen.dart';
import '../screens/user_home.dart';
import '../screens/add_recipe_screen.dart';


class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      elevation: 8,
      shape: const CircularNotchedRectangle(),
      notchMargin: 10.0,
      child: Container(
        height: 65,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon:
                  const Icon(Icons.home_filled, color: Colors.orange, size: 28),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.search,
                  color: Colors.orange.withOpacity(0.5), size: 28),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
            ),
            FloatingActionButton(
              backgroundColor: Colors.orange,
              child: const Icon(Icons.add, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddRecipeScreen()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.bookmark_border,
                  color: Colors.orange.withOpacity(0.5), size: 28),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const BookmarkPage()),
                // );
              },
            ),
            IconButton(
              icon: Icon(Icons.person_outline,
                  color: Colors.orange.withOpacity(0.5), size: 28),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}