import 'package:flutter/material.dart';
import 'package:recipes_food_share/feature/user/screens/recipe_detail_screen.dart';

class RecipeCardList extends StatelessWidget {
  final bool isNew;
  const RecipeCardList({super.key, required this.isNew});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> recipes = [
      {
        'title': 'Pasta Carbonara',
        'time': '25 min',
        'rating': '4.8',
        'image': 'images/steak-daging.jpg',
        'ingredients': [
          '200g pasta spaghetti',
          '100g daging asap',
          '2 butir telur',
          '50g keju parmesan',
          '2 siung bawang putih',
          'Garam dan merica secukupnya'
        ],
        'steps': [
          'Rebus spaghetti dalam air mendidih yang sudah diberi garam hingga al dente.',
          'Tumis bawang putih dengan sedikit minyak hingga harum.',
          'Tambahkan daging asap, masak hingga matang.',
          'Dalam mangkuk, kocok telur dan keju parmesan.',
          'Tiriskan pasta, campurkan dengan tumisan bawang dan daging.',
          'Angkat dari api, tuangkan campuran telur sambil diaduk cepat.',
          'Bumbui dengan garam dan merica secukupnya.',
          'Sajikan hangat dengan taburan keju parmesan di atasnya.'
        ]
      },
      {
        'title': 'Avocado Toast',
        'time': '10 min',
        'rating': '4.5',
        'image': 'images/steak.jpg',
        'ingredients': [
          '2 iris roti gandum',
          '1 buah alpukat matang',
          '1 butir telur',
          'Garam dan merica secukupnya',
          'Sedikit minyak zaitun',
          'Bubuk cabai (opsional)'
        ],
        'steps': [
          'Panggang roti hingga kecokelatan.',
          'Belah alpukat, keluarkan dagingnya dan haluskan dengan garpu.',
          'Bumbui alpukat dengan garam, merica, dan sedikit minyak zaitun.',
          'Goreng telur sesuai selera (sunny side up atau over easy).',
          'Oleskan alpukat pada roti panggang.',
          'Letakkan telur di atasnya.',
          'Taburi dengan bubuk cabai jika suka pedas.'
        ]
      },
    ];

    if (isNew) {
      recipes = [
        {
          'title': 'Chicken Curry',
          'time': '40 min',
          'rating': '4.9',
          'image': 'images/lalapan.jpg',
          'ingredients': [
            '500g dada ayam',
            '1 buah bawang bombay',
            '3 siung bawang putih',
            '2 sdm bumbu kari',
            '400ml santan',
            '2 sdm minyak goreng',
            'Garam dan gula secukupnya'
          ],
          'steps': [
            'Potong ayam menjadi bagian kecil-kecil.',
            'Iris bawang bombay dan cincang bawang putih.',
            'Panaskan minyak, tumis bawang hingga harum.',
            'Masukkan bumbu kari, aduk rata.',
            'Tambahkan ayam, masak hingga berubah warna.',
            'Tuangkan santan, aduk rata.',
            'Masak dengan api kecil hingga ayam empuk dan kuah mengental.',
            'Bumbui dengan garam dan gula secukupnya.'
          ]
        },
        {
          'title': 'Berry Smoothie',
          'time': '5 min',
          'rating': '4.7',
          'image': 'images/soto.jpg',
          'ingredients': [
            '1 cangkir mixed berry (stroberi, blueberry, raspberry)',
            '1 pisang',
            '1 cangkir yogurt plain',
            '1/2 cangkir susu almond',
            '1 sdm madu (opsional)',
            'Es batu secukupnya'
          ],
          'steps': [
            'Cuci bersih semua buah.',
            'Kupas pisang dan potong-potong.',
            'Masukkan semua bahan ke dalam blender.',
            'Blender hingga halus dan tercampur rata.',
            'Tuang ke dalam gelas dan sajikan segera.'
          ]
        },
      ];
    }

    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeDetailScreen(
                    recipe: recipes[index],
                  ),
                ),
              );
            },
            child: Container(
              width: 160,
              margin: EdgeInsets.only(right: index == recipes.length - 1 ? 0 : 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        recipes[index]['image'],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    recipes[index]['title'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 14, color: Colors.grey[500]),
                      const SizedBox(width: 5),
                      Text(
                        recipes[index]['time'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                      const Spacer(),
                      Icon(Icons.star, size: 14, color: Colors.orange[400]),
                      const SizedBox(width: 5),
                      Text(
                        recipes[index]['rating'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}