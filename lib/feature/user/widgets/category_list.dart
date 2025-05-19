import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {'icon': Icons.breakfast_dining, 'name': 'Breakfast'},
      {'icon': Icons.lunch_dining, 'name': 'Lunch'},
      {'icon': Icons.dinner_dining, 'name': 'Dinner'},
      {'icon': Icons.cake, 'name': 'Dessert'},
      {'icon': Icons.local_drink, 'name': 'Drinks'},
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    categories[index]['icon'],
                    color: Colors.orange,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  categories[index]['name'],
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}