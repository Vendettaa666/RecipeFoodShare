import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'View All',
            style: TextStyle(
              fontSize: 16,
              color: Colors.orange,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}