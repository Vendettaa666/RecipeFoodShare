import 'package:flutter/material.dart';
import '../../../models/recipe.dart';
import '../../../core/services/recipe_service.dart';
import '../widgets/user_greeting.dart';

import '../widgets/search_bar.dart' as custom_search;
import '../widgets/category_list.dart';
import '../widgets/section_header.dart';
import '../widgets/recipe_card.dart';
import '../widgets/bottom_navbar.dart';
import 'recipe_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Recipe> _displayedRecipes = [];
  String _currentCategory = 'All';

  @override
  void initState() {
    super.initState();
    _displayedRecipes = RecipeService.getAllRecipes();
  }

  void _navigateToRecipeDetail(Recipe recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeDetailScreen(recipe: recipe),
      ),
    );
  }

  void _filterByCategory(List<Recipe> recipes) {
    setState(() {
      _displayedRecipes = recipes;
      _currentCategory = recipes.isNotEmpty ? recipes.first.category : 'All';
    });
  }

  void _showAllRecipes() {
    setState(() {
      _displayedRecipes = RecipeService.getAllRecipes();
      _currentCategory = 'All';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Food Share',
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.orange)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
        scrolledUnderElevation: 2,
        shadowColor: Colors.black12,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const UserGreeting(),
              const SizedBox(height: 25),

              custom_search.SearchBar(
                hintText: 'Search recipes...',
                onChanged: (value) {
                  // Handle Asearch
                },
              ),
              const SizedBox(height: 35),
              CategoryList(
                onCategorySelected: _filterByCategory,
              ),
              const SizedBox(height: 10),
              if (_currentCategory != 'All')
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Text(
                        'Showing: $_currentCategory',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      TextButton(
                        onPressed: _showAllRecipes,
                        child: const Text(
                          'Clear filter',
                          style: TextStyle(
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 25),
              const SectionHeader(title: 'Recipes'),
              const SizedBox(height: 20),
              ..._buildRecipeSections(),
              const SizedBox(height: 35),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
  List<Widget> _buildRecipeSections() {
    if (_displayedRecipes.isEmpty) {
      return [
        const Center(
          child: Text('No recipes found in this category'),
        ),
      ];
    }

    return [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: _displayedRecipes.map((recipe) {
            return RecipeCard(
              recipe: recipe,
              onTap: () => _navigateToRecipeDetail(recipe),
            );
          }).toList(),
        ),
      ),
    ];
  }
}