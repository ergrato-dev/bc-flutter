/// Pantalla principal de la aplicación de recetas
///
/// Muestra:
/// - Barra de búsqueda
/// - Categorías horizontales
/// - Grid responsivo de recetas

import 'package:flutter/material.dart';

// Importar modelos y datos
// import '../models/recipe.dart';
// import '../data/sample_recipes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar personalizado
            _buildSliverAppBar(),

            // Barra de búsqueda
            SliverToBoxAdapter(child: _buildSearchBar()),

            // Título de categorías
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 24, 16, 12),
                child: Text(
                  'Categorías',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // Lista horizontal de categorías
            SliverToBoxAdapter(child: _buildCategoryList()),

            // Título de recetas
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 24, 16, 12),
                child: Text(
                  'Recetas Populares',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // Grid de recetas
            _buildRecipeGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      floating: true,
      title: const Row(
        children: [
          Text('🍳', style: TextStyle(fontSize: 28)),
          SizedBox(width: 8),
          Text('Recetas Deliciosas'),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite_border),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Favoritos próximamente')),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar recetas...',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    // Datos de categorías
    final categories = [
      {'id': 'pasta', 'name': 'Pastas', 'emoji': '🍝'},
      {'id': 'salad', 'name': 'Ensaladas', 'emoji': '🥗'},
      {'id': 'dessert', 'name': 'Postres', 'emoji': '🍰'},
      {'id': 'soup', 'name': 'Sopas', 'emoji': '🍲'},
      {'id': 'drink', 'name': 'Bebidas', 'emoji': '🥤'},
      {'id': 'meat', 'name': 'Carnes', 'emoji': '🥩'},
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category['id'];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: CategoryChip(
              emoji: category['emoji']!,
              name: category['name']!,
              isSelected: isSelected,
              onTap: () {
                setState(() {
                  selectedCategory = isSelected ? null : category['id'];
                });
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildRecipeGrid() {
    // Datos de ejemplo simplificados
    final recipes = List.generate(
      6,
      (index) => {
        'id': '$index',
        'name': [
          'Pasta Carbonara',
          'Ensalada César',
          'Tiramisú',
          'Sopa de Tomate',
          'Risotto',
          'Smoothie',
        ][index],
        'chef':
            'Chef ${['María', 'Carlos', 'Ana', 'Luis', 'María', 'Ana'][index]}',
        'imageUrl': 'https://picsum.photos/400/300?random=$index',
        'time': [30, 15, 45, 40, 35, 5][index],
        'difficulty': [
          'Fácil',
          'Fácil',
          'Media',
          'Fácil',
          'Media',
          'Fácil',
        ][index],
        'calories': [450, 280, 380, 150, 420, 120][index],
        'rating': [4.8, 4.5, 4.9, 4.3, 4.7, 4.4][index],
      },
    );

    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverLayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.crossAxisExtent;
          final columns = width < 500 ? 1 : (width < 800 ? 2 : 3);

          return SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: columns == 1 ? 1.3 : 0.85,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              final recipe = recipes[index];
              return RecipeCard(
                name: recipe['name'] as String,
                chef: recipe['chef'] as String,
                imageUrl: recipe['imageUrl'] as String,
                cookingTime: recipe['time'] as int,
                difficulty: recipe['difficulty'] as String,
                calories: recipe['calories'] as int,
                rating: recipe['rating'] as double,
                onTap: () => _openRecipeDetail(recipe),
                onFavorite: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${recipe['name']} añadido a favoritos'),
                    ),
                  );
                },
              );
            }, childCount: recipes.length),
          );
        },
      ),
    );
  }

  void _openRecipeDetail(Map<String, dynamic> recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RecipeDetailScreen(
          name: recipe['name'] as String,
          chef: recipe['chef'] as String,
          imageUrl: recipe['imageUrl'] as String,
          cookingTime: recipe['time'] as int,
          difficulty: recipe['difficulty'] as String,
          calories: recipe['calories'] as int,
          rating: recipe['rating'] as double,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// WIDGET: CATEGORY CHIP
// ═══════════════════════════════════════════════════════

class CategoryChip extends StatelessWidget {
  final String emoji;
  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.emoji,
    required this.name,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 80,
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).primaryColor : Colors.grey[100],
          borderRadius: BorderRadius.circular(16),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 8),
            Text(
              name,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// WIDGET: RECIPE CARD
// ═══════════════════════════════════════════════════════

class RecipeCard extends StatelessWidget {
  final String name;
  final String chef;
  final String imageUrl;
  final int cookingTime;
  final String difficulty;
  final int calories;
  final double rating;
  final VoidCallback onTap;
  final VoidCallback onFavorite;

  const RecipeCard({
    super.key,
    required this.name,
    required this.chef,
    required this.imageUrl,
    required this.cookingTime,
    required this.difficulty,
    required this.calories,
    required this.rating,
    required this.onTap,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen con overlay
            Expanded(
              flex: 3,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        color: Colors.grey[200],
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stack) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.restaurant, size: 48),
                      );
                    },
                  ),
                  // Botón favorito
                  Positioned(
                    top: 8,
                    right: 8,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(Icons.favorite_border, size: 18),
                        color: Colors.red,
                        padding: EdgeInsets.zero,
                        onPressed: onFavorite,
                      ),
                    ),
                  ),
                  // Rating
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            rating.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Información
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      chef,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    const Spacer(),
                    // Info chips
                    Row(
                      children: [
                        _buildInfoChip(Icons.access_time, '$cookingTime min'),
                        const SizedBox(width: 8),
                        _buildInfoChip(Icons.restaurant, difficulty),
                        const SizedBox(width: 8),
                        _buildInfoChip(
                          Icons.local_fire_department,
                          '$calories',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.grey[600]),
        const SizedBox(width: 2),
        Text(text, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════
// PANTALLA DETALLE (placeholder - ver archivo separado)
// ═══════════════════════════════════════════════════════

class RecipeDetailScreen extends StatelessWidget {
  final String name;
  final String chef;
  final String imageUrl;
  final int cookingTime;
  final String difficulty;
  final int calories;
  final double rating;

  const RecipeDetailScreen({
    super.key,
    required this.name,
    required this.chef,
    required this.imageUrl,
    required this.cookingTime,
    required this.difficulty,
    required this.calories,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(imageUrl, fit: BoxFit.cover),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {},
              ),
              IconButton(icon: const Icon(Icons.share), onPressed: () {}),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título y rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text(
                            rating.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Por $chef',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 24),
                  // Info chips
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildDetailChip(
                        Icons.access_time,
                        '$cookingTime',
                        'minutos',
                      ),
                      _buildDetailChip(
                        Icons.restaurant,
                        difficulty,
                        'dificultad',
                      ),
                      _buildDetailChip(
                        Icons.local_fire_department,
                        '$calories',
                        'kcal',
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Descripción
                  const Text(
                    'Descripción',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Una deliciosa receta tradicional que te encantará. '
                    'Perfecta para compartir con familia y amigos.',
                    style: TextStyle(color: Colors.grey[700], height: 1.5),
                  ),
                  const SizedBox(height: 24),
                  // Ingredientes
                  const Text(
                    'Ingredientes',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ...[
                    'Ingrediente 1',
                    'Ingrediente 2',
                    'Ingrediente 3',
                    'Ingrediente 4',
                  ].map(
                    (ing) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(ing),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Preparación
                  const Text(
                    'Preparación',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ...List.generate(
                    4,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Paso ${index + 1}: Descripción del paso de preparación.',
                              style: const TextStyle(height: 1.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailChip(IconData icon, String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.orange),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ],
      ),
    );
  }
}
