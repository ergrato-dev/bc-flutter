# 📊 Ejemplos de Datos - News Reader App

## 📡 NewsAPI - Estructura de Respuesta

### Endpoint: Top Headlines

```
GET https://newsapi.org/v2/top-headlines
    ?country=us
    &category=technology
    &apiKey=YOUR_API_KEY
```

### Respuesta JSON

```json
{
  "status": "ok",
  "totalResults": 35,
  "articles": [
    {
      "source": {
        "id": "bbc-news",
        "name": "BBC News"
      },
      "author": "John Doe",
      "title": "Apple announces new iPhone 16 with AI features",
      "description": "Apple has unveiled its latest smartphone featuring advanced artificial intelligence capabilities...",
      "url": "https://www.bbc.com/news/technology-12345",
      "urlToImage": "https://ichef.bbci.co.uk/news/1024/branded_news/123.jpg",
      "publishedAt": "2024-01-15T10:30:00Z",
      "content": "Apple has unveiled its latest smartphone featuring advanced artificial intelligence capabilities that promise to transform how users interact with their devices..."
    },
    {
      "source": {
        "id": null,
        "name": "TechCrunch"
      },
      "author": "Jane Smith",
      "title": "SpaceX successfully launches Starship",
      "description": "SpaceX achieved a major milestone today with the successful launch of its Starship rocket...",
      "url": "https://techcrunch.com/2024/01/15/spacex-starship",
      "urlToImage": "https://techcrunch.com/wp-content/uploads/starship.jpg",
      "publishedAt": "2024-01-15T08:00:00Z",
      "content": "SpaceX achieved a major milestone today with the successful launch of its Starship rocket from its Boca Chica facility..."
    }
  ]
}
```

---

## 🏗️ Modelos de Datos

### Article Model

```dart
/**
 * lib/models/article.dart
 *
 * Article - Modelo de noticia
 *
 * Mapea la respuesta JSON de NewsAPI a objeto Dart
 */
import 'source.dart';

class Article {
  final Source source;
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final DateTime publishedAt;
  final String? content;

  // Campo local (no viene de la API)
  final bool isFavorite;

  const Article({
    required this.source,
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
    this.isFavorite = false,
  });

  /**
   * fromJson - Deserializar desde JSON
   *
   * Maneja casos donde campos pueden ser null
   */
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: Source.fromJson(json['source'] as Map<String, dynamic>),
      author: json['author'] as String?,
      title: json['title'] as String? ?? 'Sin título',
      description: json['description'] as String?,
      url: json['url'] as String? ?? '',
      urlToImage: json['urlToImage'] as String?,
      publishedAt: json['publishedAt'] != null
          ? DateTime.parse(json['publishedAt'] as String)
          : DateTime.now(),
      content: json['content'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'source': source.toJson(),
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt.toIso8601String(),
      'content': content,
    };
  }

  /// Crear copia con cambios
  Article copyWith({
    Source? source,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    DateTime? publishedAt,
    String? content,
    bool? isFavorite,
  }) {
    return Article(
      source: source ?? this.source,
      author: author ?? this.author,
      title: title ?? this.title,
      description: description ?? this.description,
      url: url ?? this.url,
      urlToImage: urlToImage ?? this.urlToImage,
      publishedAt: publishedAt ?? this.publishedAt,
      content: content ?? this.content,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Article && runtimeType == other.runtimeType && url == other.url;

  @override
  int get hashCode => url.hashCode;

  @override
  String toString() => 'Article(title: $title, source: ${source.name})';
}
```

### Source Model

```dart
/**
 * lib/models/source.dart
 *
 * Source - Fuente de la noticia
 */
class Source {
  final String? id;
  final String name;

  const Source({
    this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'] as String?,
      name: json['name'] as String? ?? 'Desconocido',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
```

### NewsResponse Model

```dart
/**
 * lib/models/news_response.dart
 *
 * NewsResponse - Wrapper de la respuesta de la API
 */
import 'article.dart';

class NewsResponse {
  final String status;
  final int totalResults;
  final List<Article> articles;
  final String? code;
  final String? message;

  const NewsResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
    this.code,
    this.message,
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    return NewsResponse(
      status: json['status'] as String,
      totalResults: json['totalResults'] as int? ?? 0,
      articles: (json['articles'] as List<dynamic>?)
              ?.map((article) => Article.fromJson(article as Map<String, dynamic>))
              .toList() ??
          [],
      code: json['code'] as String?,
      message: json['message'] as String?,
    );
  }

  /// ¿La respuesta fue exitosa?
  bool get isSuccess => status == 'ok';

  /// ¿Hay error?
  bool get hasError => status == 'error';
}
```

### Category Enum

```dart
/**
 * lib/models/category.dart
 *
 * NewsCategory - Categorías disponibles en NewsAPI
 */
import 'package:flutter/material.dart';

enum NewsCategory {
  general('General', Icons.public, Color(0xFF607D8B)),
  business('Negocios', Icons.business, Color(0xFF3F51B5)),
  entertainment('Entretenimiento', Icons.movie, Color(0xFFE91E63)),
  health('Salud', Icons.health_and_safety, Color(0xFF4CAF50)),
  science('Ciencia', Icons.science, Color(0xFF9C27B0)),
  sports('Deportes', Icons.sports_soccer, Color(0xFFFF5722)),
  technology('Tecnología', Icons.computer, Color(0xFF00BCD4));

  final String label;
  final IconData icon;
  final Color color;

  const NewsCategory(this.label, this.icon, this.color);

  /// Valor para la API
  String get apiValue => name;

  /// Obtener categoría desde string
  static NewsCategory? fromString(String value) {
    try {
      return NewsCategory.values.firstWhere(
        (cat) => cat.name.toLowerCase() == value.toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }
}
```

---

## 🔧 Servicio de API

```dart
/**
 * lib/services/news_service.dart
 *
 * NewsService - Servicio para consumir NewsAPI
 */
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';
import '../models/news_response.dart';
import '../models/category.dart';

class NewsService {
  // ⚠️ IMPORTANTE: No subir la API key al repositorio
  // Usar variables de entorno o archivo de configuración
  static const String _apiKey = 'YOUR_API_KEY_HERE';
  static const String _baseUrl = 'https://newsapi.org/v2';

  /**
   * getTopHeadlines - Obtener titulares principales
   *
   * @param country - Código de país (us, mx, es, etc.)
   * @param category - Categoría de noticias
   * @param pageSize - Cantidad de resultados
   * @param page - Número de página
   */
  Future<List<Article>> getTopHeadlines({
    String country = 'us',
    NewsCategory? category,
    int pageSize = 20,
    int page = 1,
  }) async {
    final queryParams = {
      'country': country,
      'pageSize': pageSize.toString(),
      'page': page.toString(),
      'apiKey': _apiKey,
      if (category != null) 'category': category.apiValue,
    };

    final uri = Uri.parse('$_baseUrl/top-headlines').replace(
      queryParameters: queryParams,
    );

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final newsResponse = NewsResponse.fromJson(jsonDecode(response.body));

        if (newsResponse.isSuccess) {
          return newsResponse.articles;
        } else {
          throw NewsApiException(
            code: newsResponse.code ?? 'unknown',
            message: newsResponse.message ?? 'Error desconocido',
          );
        }
      } else {
        throw NewsApiException(
          code: 'http_error',
          message: 'Error HTTP: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is NewsApiException) rethrow;
      throw NewsApiException(
        code: 'network_error',
        message: 'Error de conexión: $e',
      );
    }
  }

  /**
   * searchNews - Buscar noticias
   *
   * @param query - Término de búsqueda
   * @param sortBy - Ordenar por: relevancy, popularity, publishedAt
   */
  Future<List<Article>> searchNews({
    required String query,
    String sortBy = 'publishedAt',
    int pageSize = 20,
    int page = 1,
  }) async {
    final uri = Uri.parse('$_baseUrl/everything').replace(
      queryParameters: {
        'q': query,
        'sortBy': sortBy,
        'pageSize': pageSize.toString(),
        'page': page.toString(),
        'apiKey': _apiKey,
      },
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final newsResponse = NewsResponse.fromJson(jsonDecode(response.body));
      return newsResponse.articles;
    }

    throw NewsApiException(
      code: 'http_error',
      message: 'Error al buscar: ${response.statusCode}',
    );
  }
}

/// Excepción personalizada para errores de la API
class NewsApiException implements Exception {
  final String code;
  final String message;

  NewsApiException({required this.code, required this.message});

  @override
  String toString() => 'NewsApiException: [$code] $message';

  /// ¿Es error de API key?
  bool get isApiKeyError => code == 'apiKeyInvalid' || code == 'apiKeyDisabled';

  /// ¿Es rate limit?
  bool get isRateLimitError => code == 'rateLimited';
}
```

---

## 🧪 Datos Mock para Testing

```dart
/**
 * lib/mocks/mock_articles.dart
 *
 * Datos de prueba para desarrollo sin API key
 */
import '../models/article.dart';
import '../models/source.dart';

class MockArticles {
  static List<Article> get sampleArticles => [
    Article(
      source: const Source(id: 'bbc-news', name: 'BBC News'),
      author: 'John Reporter',
      title: 'Breaking: Major Technology Breakthrough Announced',
      description: 'Scientists have made a groundbreaking discovery that could revolutionize the tech industry...',
      url: 'https://example.com/article1',
      urlToImage: 'https://picsum.photos/seed/news1/800/400',
      publishedAt: DateTime.now().subtract(const Duration(hours: 2)),
      content: 'Full article content here...',
    ),
    Article(
      source: const Source(id: null, name: 'TechCrunch'),
      author: 'Jane Tech',
      title: 'Apple Reveals Next-Gen iPhone Features',
      description: 'Apple\'s latest announcement includes revolutionary AI features...',
      url: 'https://example.com/article2',
      urlToImage: 'https://picsum.photos/seed/news2/800/400',
      publishedAt: DateTime.now().subtract(const Duration(hours: 5)),
      content: 'Full article content here...',
    ),
    Article(
      source: const Source(id: 'cnn', name: 'CNN'),
      author: 'Mike Sports',
      title: 'World Cup Final Results: Historic Victory',
      description: 'In an incredible match, the underdog team emerged victorious...',
      url: 'https://example.com/article3',
      urlToImage: 'https://picsum.photos/seed/news3/800/400',
      publishedAt: DateTime.now().subtract(const Duration(hours: 8)),
      content: 'Full article content here...',
    ),
    Article(
      source: const Source(id: null, name: 'Health Daily'),
      author: 'Dr. Sarah Health',
      title: 'New Study Shows Benefits of Mediterranean Diet',
      description: 'Research confirms significant health improvements with this diet plan...',
      url: 'https://example.com/article4',
      urlToImage: 'https://picsum.photos/seed/news4/800/400',
      publishedAt: DateTime.now().subtract(const Duration(days: 1)),
      content: 'Full article content here...',
    ),
    Article(
      source: const Source(id: 'bloomberg', name: 'Bloomberg'),
      author: 'Market Analyst',
      title: 'Stock Markets Reach All-Time High',
      description: 'Global markets surge as investor confidence grows...',
      url: 'https://example.com/article5',
      urlToImage: 'https://picsum.photos/seed/news5/800/400',
      publishedAt: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
      content: 'Full article content here...',
    ),
  ];

  /// Artículos por categoría
  static List<Article> getByCategory(String category) {
    return sampleArticles.take(3).toList();
  }

  /// Simular búsqueda
  static List<Article> search(String query) {
    return sampleArticles.where((article) {
      final q = query.toLowerCase();
      return article.title.toLowerCase().contains(q) ||
             (article.description?.toLowerCase().contains(q) ?? false);
    }).toList();
  }
}
```

---

## 📦 Provider de Noticias

```dart
/**
 * lib/providers/news_provider.dart
 *
 * NewsProvider - Estado global de noticias
 */
import 'package:flutter/foundation.dart';
import '../models/article.dart';
import '../models/category.dart';
import '../services/news_service.dart';
import '../mocks/mock_articles.dart';

enum LoadingState { initial, loading, success, error }

class NewsProvider extends ChangeNotifier {
  final NewsService _newsService = NewsService();

  // Estados
  LoadingState _state = LoadingState.initial;
  List<Article> _articles = [];
  List<Article> _favorites = [];
  String? _errorMessage;
  NewsCategory? _selectedCategory;

  // Getters
  LoadingState get state => _state;
  List<Article> get articles => _articles;
  List<Article> get favorites => _favorites;
  String? get errorMessage => _errorMessage;
  NewsCategory? get selectedCategory => _selectedCategory;

  bool get isLoading => _state == LoadingState.loading;
  bool get hasError => _state == LoadingState.error;

  /**
   * loadTopHeadlines - Cargar titulares
   */
  Future<void> loadTopHeadlines({NewsCategory? category}) async {
    _state = LoadingState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      // Para desarrollo sin API key, usar mocks
      // _articles = MockArticles.sampleArticles;

      _articles = await _newsService.getTopHeadlines(
        category: category,
      );
      _selectedCategory = category;
      _state = LoadingState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _state = LoadingState.error;
    }

    notifyListeners();
  }

  /**
   * searchArticles - Buscar noticias
   */
  Future<void> searchArticles(String query) async {
    if (query.trim().isEmpty) {
      _articles = [];
      notifyListeners();
      return;
    }

    _state = LoadingState.loading;
    notifyListeners();

    try {
      _articles = await _newsService.searchNews(query: query);
      _state = LoadingState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _state = LoadingState.error;
    }

    notifyListeners();
  }

  /**
   * toggleFavorite - Agregar/quitar de favoritos
   */
  void toggleFavorite(Article article) {
    final index = _favorites.indexWhere((a) => a.url == article.url);

    if (index != -1) {
      _favorites.removeAt(index);
    } else {
      _favorites.add(article);
    }

    notifyListeners();
  }

  /// ¿Es favorito?
  bool isFavorite(Article article) {
    return _favorites.any((a) => a.url == article.url);
  }

  /// Limpiar favoritos
  void clearFavorites() {
    _favorites.clear();
    notifyListeners();
  }
}
```

---

## 🔐 Configuración de API Key

### Opción 1: Archivo .env (Recomendado)

```bash
# .env (agregar a .gitignore)
NEWS_API_KEY=your_api_key_here
```

```dart
// lib/core/config/env.dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get newsApiKey => dotenv.env['NEWS_API_KEY'] ?? '';
}

// En main.dart
Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}
```

### Opción 2: Archivo de configuración local

```dart
// lib/core/config/api_keys.dart (agregar a .gitignore)
class ApiKeys {
  static const String newsApiKey = 'your_api_key_here';
}

// lib/core/config/api_keys.example.dart (subir al repo)
class ApiKeys {
  static const String newsApiKey = 'YOUR_API_KEY_HERE';
}
```

---

## ✅ Checklist de Datos

- [ ] Modelos creados: Article, Source, NewsResponse
- [ ] Enum de categorías implementado
- [ ] Servicio de API funcional
- [ ] Datos mock para testing
- [ ] Provider de estado configurado
- [ ] API key segura (no en el repo)

---

📅 **Semana:** 06 | 📱 **Proyecto:** News Reader App
