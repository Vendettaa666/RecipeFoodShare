class Recipe {
  final String title;
  final String username;
  final String time;
  final String rating;
  final String image;
  final String category;
  final List<String> ingredients;
  final List<String> steps;

  Recipe({
    required this.title,
    required this.username,
    required this.time,
    required this.rating,
    required this.image,
    required this.category,
    required this.ingredients,
    required this.steps,
  });
}