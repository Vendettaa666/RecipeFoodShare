class RecipeData {
  static List<Map<String, dynamic>> allRecipes = [
    {
      'title': 'Creamy Pasta Carbonara',
      'chef': 'Gordon Ramsay',
      'time': '25 min',
      'rating': '4.8',
      'image': 'https://images.unsplash.com/photo-1555949258-eb67b1ef0ceb?w=500&auto=format&fit=crop',
      'isNew': false,
    },
    {
      'title': 'Gourmet Avocado Toast',
      'chef': 'Jamie Oliver',
      'time': '10 min',
      'rating': '4.5',
      'image': 'https://images.unsplash.com/photo-1515443961218-0a9d5f8b8abd?w=500&auto=format&fit=crop',
      'isNew': false,
    },
    {
      'title': 'Spicy Chicken Curry',
      'chef': 'Martha Stewart',
      'time': '40 min',
      'rating': '4.9',
      'image': 'https://images.unsplash.com/photo-1631515243349-e0cb75fb8d3a?w=500&auto=format&fit=crop',
      'isNew': true,
    },
    {
      'title': 'Mixed Berry Smoothie',
      'chef': 'Wolfgang Puck',
      'time': '5 min',
      'rating': '4.7',
      'image': 'https://images.unsplash.com/photo-1505576399279-565b52d4ac71?w=500&auto=format&fit=crop',
      'isNew': true,
    },
  ];

  static List<Map<String, dynamic>> getTrendingRecipes() {
    return allRecipes.where((recipe) => !recipe['isNew']).toList();
  }

  static List<Map<String, dynamic>> getNewRecipes() {
    return allRecipes.where((recipe) => recipe['isNew']).toList();
  }

  static getAllRecipes() {}
}