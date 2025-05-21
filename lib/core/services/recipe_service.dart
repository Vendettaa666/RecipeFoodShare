import '../../models/recipe.dart';

class RecipeService {
  static List<Recipe> getAllRecipes() {
    return [
      Recipe(
        title: 'Lalapan Ayam Goreng',
        username: 'Leo Satria',
        time: '30 min',
        rating: '4.8',
        image: 'images/lalapan.jpg',
        category: 'Indonesian',
        like: 150,
        comment: 25,
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
        like: 120,
        comment: 18,
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
        like: 200,
        comment: 45,
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
        image: 'images/pancake.jpg',
        category: 'Breakfast',
        like: 180,
        comment: 32,
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
      Recipe(
        title: 'Es Jeruk',
        username: 'Diana',
        time: '5 min',
        rating: '4.6',
        image: 'images/esjeruk.jpg',
        category: 'Beverages',
        like: 90,
        comment: 15,
        ingredients: [
          '3 buah jeruk',
          'Es batu',
          'Gula pasir',
          'Air mineral'
        ],
        steps: [
          'Peras jeruk dan saring',
          'Tambahkan gula sesuai selera',
          'Tambahkan air mineral',
          'Masukkan es batu',
          'Aduk rata dan sajikan'
        ],
      ),
      Recipe(
        title: 'Es Cincau',
        username: 'Rara',
        time: '15 min',
        rating: '4.5',
        image: 'images/escincau.jpg',
        category: 'Beverages',
        like: 85,
        comment: 12,
        ingredients: [
          'Cincau hitam',
          'Santan',
          'Gula merah',
          'Es batu',
          'Sirup cocopandan'
        ],
        steps: [
          'Potong cincau sesuai selera',
          'Siapkan santan encer',
          'Larutkan gula merah',
          'Susun cincau dalam gelas',
          'Tambahkan santan dan sirup',
          'Tambahkan es batu'
        ],
      ),
      Recipe(
        title: 'Bolu',
        username: 'Sarah',
        time: '45 min',
        rating: '4.8',
        image: 'images/bolu.jpeg',
        category: 'Cake',
        like: 165,
        comment: 28,
        ingredients: [
          '4 butir telur',
          '150g tepung terigu',
          '150g gula pasir',
          '100g mentega',
          'Vanili',
          'SP'
        ],
        steps: [
          'Kocok telur, gula, dan SP sampai mengembang',
          'Tambahkan tepung terigu',
          'Masukkan mentega cair',
          'Tuang ke loyang',
          'Panggang selama 35 menit',
          'Dinginkan dan sajikan'
        ],
      ),
      Recipe(
        title: 'Mie Pedas',
        username: 'Kevin',
        time: '15 min',
        rating: '4.7',
        image: 'images/miepedas.jpg',
        category: 'Indonesian',
        like: 175,
        comment: 30,
        ingredients: [
          'Mie instant',
          'Cabe rawit',
          'Telur',
          'Sawi',
          'Bawang goreng'
        ],
        steps: [
          'Rebus mie hingga matang',
          'Tumis bumbu dan cabe',
          'Masak telur setengah matang',
          'Campurkan mie dengan bumbu',
          'Tambahkan sayuran dan telur',
          'Taburi bawang goreng'
        ],
      ),
      Recipe(
        title: 'Pisang Coklat',
        username: 'Linda',
        time: '20 min',
        rating: '4.6',
        image: 'images/pisangcoklat.jpeg',
        category: 'Snacks',
        like: 145,
        comment: 22,
        ingredients: [
          'Pisang kepok',
          'Coklat batang',
          'Tepung terigu',
          'Gula',
          'Minyak goreng'
        ],
        steps: [
          'Kupas dan potong pisang',
          'Buat adonan tepung',
          'Balut pisang dengan adonan',
          'Goreng hingga keemasan',
          'Lelehkan coklat',
          'Siram pisang dengan coklat'
        ],
      ),
      Recipe(
        title: 'Es Matcha',
        username: 'Yuki',
        time: '10 min',
        rating: '4.8',
        image: 'images/esmatcha.jpeg',
        category: 'Beverages',
        like: 160,
        comment: 27,
        ingredients: [
          'Bubuk matcha',
          'Susu',
          'Es batu',
          'Gula',
          'Air panas'
        ],
        steps: [
          'Seduh matcha dengan air panas',
          'Tambahkan gula',
          'Tuang susu',
          'Tambahkan es batu',
          'Aduk rata dan sajikan'
        ],
      ),
      Recipe(
        title: 'Cireng',
        username: 'Asep',
        time: '30 min',
        rating: '4.5',
        image: 'images/cireng.jpeg',
        category: 'Snacks',
        like: 130,
        comment: 20,
        ingredients: [
          'Tepung kanji',
          'Tepung terigu',
          'Bawang putih',
          'Daun bawang',
          'Garam',
          'Air panas'
        ],
        steps: [
          'Campur semua bahan kering',
          'Tambahkan air panas sedikit demi sedikit',
          'Bentuk adonan',
          'Goreng hingga crispy',
          'Sajikan dengan sambal'
        ],
      ),
      Recipe(
        title: 'Daging Rendang',
        username: 'Minang Chef',
        time: '180 min',
        rating: '4.9',
        image: 'images/daging.jpg',
        category: 'Indonesian',
        like: 250,
        comment: 55,
        ingredients: [
          'Daging sapi',
          'Santan',
          'Bumbu rendang',
          'Daun jeruk',
          'Serai',
          'Lengkuas'
        ],
        steps: [
          'Tumis bumbu hingga harum',
          'Masukkan daging',
          'Tambahkan santan',
          'Masak dengan api kecil',
          'Aduk sesekali hingga mengering',
          'Sajikan'
        ],
      ),
    ];
  }

    static List<Recipe> getRecipesByCategory(String category) {
      return getAllRecipes().where((recipe) => recipe.category == category).toList();
    }
  }