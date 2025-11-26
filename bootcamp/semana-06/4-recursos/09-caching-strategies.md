# 📦 Estrategias de Caché para APIs

## 🎯 ¿Por Qué Cachear?

- ⚡ **Rendimiento** - Respuestas instantáneas
- 📱 **Offline** - Funciona sin internet
- 💰 **Costos** - Menos requests a APIs pagas
- 🔋 **Batería** - Menos uso de red

---

## 🔧 Estrategias de Caché

### 1. Cache-First (Stale-While-Revalidate)

Muestra datos del caché inmediatamente, actualiza en segundo plano.

```dart
class CacheFirstStrategy<T> {
  final Duration maxAge;
  final Future<T> Function() fetchFromNetwork;
  final Future<T?> Function() readFromCache;
  final Future<void> Function(T data) writeToCache;

  CacheFirstStrategy({
    required this.maxAge,
    required this.fetchFromNetwork,
    required this.readFromCache,
    required this.writeToCache,
  });

  Stream<T> get() async* {
    // 1. Intentar caché primero
    final cached = await readFromCache();
    if (cached != null) {
      yield cached;
    }

    // 2. Actualizar desde red
    try {
      final fresh = await fetchFromNetwork();
      await writeToCache(fresh);
      yield fresh;
    } catch (e) {
      // Si no hay caché y falla red, propagar error
      if (cached == null) rethrow;
    }
  }
}

// Uso
final strategy = CacheFirstStrategy<List<Article>>(
  maxAge: const Duration(minutes: 15),
  fetchFromNetwork: () => newsService.fetchArticles(),
  readFromCache: () => cacheService.getArticles(),
  writeToCache: (data) => cacheService.saveArticles(data),
);

// En Widget
StreamBuilder<List<Article>>(
  stream: strategy.get(),
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return ArticleList(articles: snapshot.data!);
    }
    return const LoadingIndicator();
  },
);
```

### 2. Network-First (Cache Fallback)

Intenta red primero, usa caché si falla.

```dart
class NetworkFirstStrategy<T> {
  final Future<T> Function() fetchFromNetwork;
  final Future<T?> Function() readFromCache;
  final Future<void> Function(T data) writeToCache;

  Future<T> get() async {
    try {
      // 1. Intentar red primero
      final data = await fetchFromNetwork();
      await writeToCache(data);
      return data;
    } catch (e) {
      // 2. Fallback a caché
      final cached = await readFromCache();
      if (cached != null) {
        return cached;
      }
      rethrow;
    }
  }
}
```

### 3. Cache-Only

Solo usar caché, útil para modo offline.

```dart
class CacheOnlyStrategy<T> {
  final Future<T?> Function() readFromCache;

  Future<T> get() async {
    final cached = await readFromCache();
    if (cached != null) {
      return cached;
    }
    throw CacheException('No cached data available');
  }
}
```

---

## 💾 Implementaciones de Caché

### SharedPreferences (Simple)

```dart
class SimpleCache {
  Future<void> saveJson(String key, Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheData = {
      'data': data,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };
    await prefs.setString(key, jsonEncode(cacheData));
  }

  Future<Map<String, dynamic>?> getJson(
    String key, {
    Duration maxAge = const Duration(hours: 1),
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString(key);

    if (cached == null) return null;

    final cacheData = jsonDecode(cached);
    final timestamp = DateTime.fromMillisecondsSinceEpoch(
      cacheData['timestamp'],
    );

    // Verificar si expiró
    if (DateTime.now().difference(timestamp) > maxAge) {
      await prefs.remove(key);
      return null;
    }

    return cacheData['data'];
  }

  Future<void> clear(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
```

### Hive (Más Robusto)

```yaml
dependencies:
  hive: ^2.2.3
  hive_flutter: ^1.1.0

dev_dependencies:
  hive_generator: ^2.0.1
  build_runner: ^2.4.8
```

```dart
// Modelo con Hive
@HiveType(typeId: 0)
class CachedArticle extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final DateTime cachedAt;

  CachedArticle({
    required this.id,
    required this.title,
    required this.cachedAt,
  });
}

// Cache Service con Hive
class HiveCacheService {
  late Box<CachedArticle> _articlesBox;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(CachedArticleAdapter());
    _articlesBox = await Hive.openBox<CachedArticle>('articles');
  }

  Future<void> saveArticles(List<Article> articles) async {
    final cached = articles.map((a) => CachedArticle(
      id: a.id,
      title: a.title,
      cachedAt: DateTime.now(),
    )).toList();

    await _articlesBox.clear();
    await _articlesBox.addAll(cached);
  }

  List<CachedArticle>? getArticles({Duration maxAge = const Duration(hours: 1)}) {
    if (_articlesBox.isEmpty) return null;

    final first = _articlesBox.getAt(0)!;
    if (DateTime.now().difference(first.cachedAt) > maxAge) {
      return null;
    }

    return _articlesBox.values.toList();
  }

  Future<void> clearCache() async {
    await _articlesBox.clear();
  }
}
```

### Dio Cache Interceptor

```yaml
dependencies:
  dio_cache_interceptor: ^3.4.4
```

```dart
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

final cacheOptions = CacheOptions(
  store: MemCacheStore(),  // O HiveCacheStore, FileCacheStore
  policy: CachePolicy.forceCache,
  maxStale: const Duration(days: 7),
  priority: CachePriority.high,
  hitCacheOnErrorExcept: [401, 403],
);

final dio = Dio()
  ..interceptors.add(DioCacheInterceptor(options: cacheOptions));

// Por request
final response = await dio.get(
  '/articles',
  options: cacheOptions.copyWith(
    policy: CachePolicy.refreshForceCache,
  ).toOptions(),
);
```

---

## 🔄 Invalidación de Caché

```dart
class CacheManager {
  final Map<String, DateTime> _timestamps = {};
  final Duration defaultMaxAge;

  CacheManager({this.defaultMaxAge = const Duration(minutes: 15)});

  bool isValid(String key, {Duration? maxAge}) {
    final timestamp = _timestamps[key];
    if (timestamp == null) return false;

    final age = maxAge ?? defaultMaxAge;
    return DateTime.now().difference(timestamp) < age;
  }

  void markAsUpdated(String key) {
    _timestamps[key] = DateTime.now();
  }

  void invalidate(String key) {
    _timestamps.remove(key);
  }

  void invalidateAll() {
    _timestamps.clear();
  }

  // Invalidar por patrón
  void invalidatePattern(String pattern) {
    _timestamps.removeWhere((key, _) => key.contains(pattern));
  }
}

// Uso
final cacheManager = CacheManager();

// Después de crear/actualizar/eliminar
await api.createArticle(article);
cacheManager.invalidate('articles');
cacheManager.invalidatePattern('article_');
```

---

## 📊 Tabla de Decisión

| Escenario       | Estrategia    | MaxAge   |
| --------------- | ------------- | -------- |
| Noticias        | Cache-First   | 15 min   |
| Perfil usuario  | Network-First | 1 hora   |
| Configuración   | Cache-First   | 1 día    |
| Búsqueda        | No cachear    | -        |
| Lista de países | Cache-First   | 1 semana |
| Precios cripto  | Network-First | 30 seg   |

---

## 💡 Best Practices

```dart
// ✅ Cachear por key única
final cacheKey = 'articles_${category}_${page}';

// ✅ Versionar caché
final cacheKey = 'v2_articles';

// ✅ Limpiar caché periódicamente
void cleanOldCache() async {
  final prefs = await SharedPreferences.getInstance();
  final keys = prefs.getKeys();
  for (final key in keys) {
    if (isCacheExpired(key)) {
      await prefs.remove(key);
    }
  }
}

// ✅ Mostrar indicador de datos cacheados
if (isFromCache) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Mostrando datos guardados'),
      duration: Duration(seconds: 2),
    ),
  );
}
```

---

📅 **Semana 06** | Consumo de APIs y HTTP
