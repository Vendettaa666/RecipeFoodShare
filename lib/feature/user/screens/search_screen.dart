import 'package:flutter/material.dart';
import '../../../core/services/recipe_service.dart';
import '../../../models/recipe.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/search_bar.dart' as custom_search;
import '../widgets/recipe_card.dart';
import '../screens/recipe_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchQuery = '';
  List<Recipe> _filteredRecipes = [];
  List<String> _categories = ['All', 'Indonesian', 'Western', 'Breakfast'];

  @override
  void initState() {
    super.initState();
    _filteredRecipes = RecipeService.getAllRecipes();
  }

  void _searchRecipes(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
      if (query.isEmpty) {
        _filteredRecipes = RecipeService.getAllRecipes();
      } else {
        _filteredRecipes = RecipeService.getAllRecipes().where((recipe) {
          return recipe.title.toLowerCase().contains(_searchQuery) ||
              recipe.username.toLowerCase().contains(_searchQuery) ||
              recipe.category.toLowerCase().contains(_searchQuery);
        }).toList();
      }
    });
  }

  void _filterByCategory(String category) {
    setState(() {
      if (category == 'All') {
        _filteredRecipes = RecipeService.getAllRecipes();
      } else {
        _filteredRecipes = RecipeService.getRecipesByCategory(category);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'Search Recipes',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              custom_search.SearchBar(
                onChanged: _searchRecipes,
                hintText: 'Search recipes, chefs, or categories...',
              ),
              const SizedBox(height: 25),
              // Category Chips
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: FilterChip(
                        label: Text(_categories[index]),
                        selected: false,
                        onSelected: (_) => _filterByCategory(_categories[index]),
                        backgroundColor: Colors.white,
                        selectedColor: Colors.orange.withOpacity(0.2),
                        labelStyle: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w500,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: Colors.grey[300]!,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 25),
              if (_filteredRecipes.isEmpty)
                const Center(
                  child: Column(
                    children: [
                      Icon(Icons.search_off, size: 60, color: Colors.grey),
                      SizedBox(height: 15),
                      Text(
                        'No recipes found',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )
              else
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: _filteredRecipes.length,
                  itemBuilder: (context, index) {
                    final recipe = _filteredRecipes[index];
                    return RecipeCard(
                      recipe: recipe,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeDetailScreen(recipe: recipe),
                          ),
                        );
                      },
                    );
                  },
                ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}