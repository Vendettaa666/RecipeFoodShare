import 'package:flutter/material.dart';
import '../../../models/recipe.dart';
import '../../../core/services/recipe_service.dart';

class CategoryList extends StatelessWidget {
  final Function(List<Recipe>) onCategorySelected;

  const CategoryList({
    super.key,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {'icon': Icons.breakfast_dining, 'name': 'Breakfast', 'color': Colors.orange[300], 'category': 'Breakfast'},
      {'icon': Icons.lunch_dining, 'name': 'Lunch', 'color': Colors.orange[400], 'category': 'Lunch'},
      {'icon': Icons.dinner_dining, 'name': 'Dinner', 'color': Colors.orange[500], 'category': 'Dinner'},
      {'icon': Icons.cake, 'name': 'Dessert', 'color': Colors.orange[600], 'category': 'Dessert'},
      {'icon': Icons.local_drink, 'name': 'Drinks', 'color': Colors.orange[700], 'category': 'Drinks'},
      {'icon': Icons.flag, 'name': 'Indonesian', 'color': Colors.orange[800], 'category': 'Indonesian'},
      {'icon': Icons.public, 'name': 'Western', 'color': Colors.orange[900], 'category': 'Western'},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          return GestureDetector(
            onTap: () {
              final recipes = RecipeService.getRecipesByCategory(category['category']);
              onCategorySelected(recipes);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: category['color'],
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: category['color'].withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Icon(
                      category['icon'],
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    category['name'],
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}