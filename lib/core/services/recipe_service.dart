import '../../models/recipe.dart';

class RecipeService {
  static List<Recipe> getAllRecipes() {
    return [
      Recipe(
        title: 'Lalapan Ayam Goreng',
        username: 'Mr. Smith',
        time: '30 min',
        rating: '4.8',
        image: 'images/lalapan.jpg',
        category: 'Indonesian',
        ingredients: [
          '1 ekor ayam potong',
          'Kubis',
          'Mentimun',
          'Kemangi',
          'Terong',
          'Sambal terasi',
          'Bumbu marinasi ayam',
          'Minyak goreng'
        ],
        steps: [
          'Marinasi ayam dengan bumbu selama 30 menit',
          'Goreng ayam hingga kecokelatan dan matang',
          'Cuci semua sayuran dengan bersih',
          'Potong kubis dan mentimun sesuai selera',
          'Goreng terong hingga matang',
          'Siapkan sambal terasi',
          'Tata ayam goreng, lalapan, dan sambal di piring',
          'Sajikan selagi hangat'
        ],
      ),
      Recipe(
        title: 'Soto Ayam',
        username: 'Ciyara',
        time: '45 min',
        rating: '4.5',
        image: 'images/soto.jpg',
        category: 'Indonesian',
        ingredients: [
          '1 ekor ayam',
          'Bihun',
          'Kol',
          'Tauge',
          'Daun bawang',
          'Bawang goreng',
          'Bumbu soto',
          'Jeruk nipis'
        ],
        steps: [
          'Rebus ayam untuk membuat kaldu',
          'Tumis bumbu soto hingga harum',
          'Masukkan bumbu ke dalam kaldu',
          'Suwir-suwir daging ayam',
          'Rebus bihun, tauge, dan kol',
          'Tata bihun, sayuran, dan ayam suwir dalam mangkok',
          'Siram dengan kuah soto panas',
          'Taburi bawang goreng dan beri perasan jeruk nipis'
        ],
      ),
      Recipe(
        title: 'Steak Daging Sapi',
        username: 'Leo Satria',
        time: '25 min',
        rating: '4.9',
        image: 'images/steak.jpg',
        category: 'Western',
        ingredients: [
          '200g daging sapi has dalam',
          'Kentang',
          'Brokoli',
          'Wortel',
          'Butter',
          'Saus mushroom',
          'Garam dan lada hitam',
          'Rosemary'
        ],
        steps: [
          'Marinasi daging dengan garam dan lada hitam',
          'Panaskan pan dengan butter',
          'Masak steak sesuai tingkat kematangan yang diinginkan',
          'Rebus sayuran sebagai pendamping',
          'Goreng kentang hingga keemasan',
          'Buat saus mushroom',
          'Tata steak, sayuran, dan kentang di piring',
          'Siram dengan saus mushroom dan sajikan'
        ],
      ),
      Recipe(
        title: 'Pancakes',
        username: 'Vinn Arnold',
        time: '20 min',
        rating: '4.7',
        image: 'images/steak.jpg',
        category: 'Breakfast',
        ingredients: [
          '200g tepung terigu',
          '2 butir telur',
          '300ml susu',
          '1 sdm gula',
          '1 sdt baking powder',
          'Madu',
          'Buah-buahan'
        ],
        steps: [
          'Campur semua bahan kering',
          'Tambahkan telur dan susu sedikit demi sedikit',
          'Panaskan wajan anti lengket',
          'Tuang adonan dan masak hingga muncul gelembung',
          'Balik dan masak sisi lainnya',
          'Sajikan dengan madu dan buah-buahan'
        ],
      ),
    ];
  }

  static List<Recipe> getRecipesByCategory(String category) {
    return getAllRecipes().where((recipe) => recipe.category == category).toList();
  }
}