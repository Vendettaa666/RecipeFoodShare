import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            spreadRadius: 5,
            blurRadius: 15,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'What would you like to cook today?',
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 16),
          prefixIcon: const Icon(Icons.search, color: Colors.orange, size: 26),
          suffixIcon: const Icon(Icons.tune, color: Colors.orange, size: 26),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        ),
      ),
    );
  }
}