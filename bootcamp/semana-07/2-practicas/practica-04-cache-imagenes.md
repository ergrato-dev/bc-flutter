# 💻 Práctica 04: Caché de Imágenes

## 🎯 Objetivo

Implementar un sistema de **caché de imágenes** que descargue, almacene y sirva imágenes localmente usando **path_provider** y el file system.

---

## 📋 Requisitos

### Funcionales

1. **Galería de Imágenes**

   - Grid de imágenes de una API pública
   - Placeholder mientras carga
   - Indicador de progreso

2. **Sistema de Caché**

   - Descargar imagen si no existe en caché
   - Servir desde caché si existe
   - Mostrar indicador "cached" vs "downloaded"

3. **Gestión de Caché**

   - Ver tamaño total del caché
   - Limpiar caché manualmente
   - Límite máximo de caché (configurable)

4. **Precarga**
   - Opción para precargar imágenes
   - Barra de progreso de precarga

### No Funcionales

- Caché en directorio temporal
- Hash MD5 de URL como nombre de archivo
- Manejo de errores de red

---

## 🏗️ Estructura del Proyecto

```
lib/
├── main.dart
├── services/
│   ├── image_cache_service.dart
│   └── api_service.dart
├── models/
│   └── photo.dart
├── providers/
│   └── gallery_provider.dart
├── screens/
│   ├── gallery_screen.dart
│   └── cache_settings_screen.dart
└── widgets/
    ├── cached_image.dart
    └── cache_stats_card.dart
```

---

## 📝 Código Base

### 1. Modelo Photo

```dart
// lib/models/photo.dart

/**
 * Photo: Modelo de foto de la API.
 *
 * Usamos Picsum Photos API que genera URLs de imágenes aleatorias.
 */
class Photo {
  final String id;
  final String author;
  final int width;
  final int height;
  final String url;
  final String downloadUrl;

  Photo({
    required this.id,
    required this.author,
    required this.width,
    required this.height,
    required this.url,
    required this.downloadUrl,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      author: json['author'],
      width: json['width'],
      height: json['height'],
      url: json['url'],
      downloadUrl: json['download_url'],
    );
  }

  /// URL de thumbnail (300x300)
  String get thumbnailUrl => 'https://picsum.photos/id/$id/300/300';

  /// URL de imagen mediana (600x600)
  String get mediumUrl => 'https://picsum.photos/id/$id/600/600';

  /// URL de imagen grande
  String get largeUrl => 'https://picsum.photos/id/$id/1200/1200';
}
```

### 2. API Service

```dart
// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/photo.dart';

/**
 * ApiService: Obtiene fotos de Picsum Photos API.
 *
 * API: https://picsum.photos/
 * Documentación: https://picsum.photos/
 */
class ApiService {
  static const String _baseUrl = 'https://picsum.photos/v2';

  /// Obtener lista de fotos
  Future<List<Photo>> getPhotos({int page = 1, int limit = 30}) async {
    final url = '$_baseUrl/list?page=$page&limit=$limit';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Photo.fromJson(json)).toList();
      } else {
        throw Exception('Error ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al obtener fotos: $e');
    }
  }

  /// Obtener foto por ID
  Future<Photo> getPhotoById(String id) async {
    final url = '$_baseUrl/id/$id/info';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Photo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Foto no encontrada');
    }
  }
}
```

### 3. Image Cache Service

```dart
// lib/services/image_cache_service.dart
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

/**
 * CacheResult: Resultado de obtener una imagen.
 */
class CacheResult {
  final Uint8List bytes;
  final bool fromCache;
  final String path;

  CacheResult({
    required this.bytes,
    required this.fromCache,
    required this.path,
  });
}

/**
 * CacheStats: Estadísticas del caché.
 */
class CacheStats {
  final int fileCount;
  final int totalSizeBytes;
  final DateTime? oldestFile;
  final DateTime? newestFile;

  CacheStats({
    required this.fileCount,
    required this.totalSizeBytes,
    this.oldestFile,
    this.newestFile,
  });

  /// Tamaño formateado
  String get formattedSize {
    if (totalSizeBytes < 1024) {
      return '$totalSizeBytes B';
    } else if (totalSizeBytes < 1024 * 1024) {
      return '${(totalSizeBytes / 1024).toStringAsFixed(1)} KB';
    } else {
      return '${(totalSizeBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
  }
}

/**
 * ImageCacheService: Servicio de caché de imágenes.
 *
 * ¿Qué hace?
 * Descarga imágenes y las almacena localmente para uso offline.
 *
 * ¿Cómo funciona?
 * 1. Genera un hash MD5 de la URL como nombre de archivo
 * 2. Busca en el directorio de caché
 * 3. Si existe, retorna desde disco
 * 4. Si no existe, descarga, guarda y retorna
 */
class ImageCacheService {
  static ImageCacheService? _instance;
  late Directory _cacheDir;
  bool _isInitialized = false;

  // Configuración
  int maxCacheSizeMB = 100; // Máximo 100 MB de caché

  ImageCacheService._();

  static Future<ImageCacheService> getInstance() async {
    if (_instance == null) {
      _instance = ImageCacheService._();
      await _instance!._init();
    }
    return _instance!;
  }

  Future<void> _init() async {
    if (_isInitialized) return;

    // Usar directorio de caché del sistema
    final tempDir = await getTemporaryDirectory();
    _cacheDir = Directory('${tempDir.path}/image_cache');

    // Crear si no existe
    if (!await _cacheDir.exists()) {
      await _cacheDir.create(recursive: true);
    }

    _isInitialized = true;
  }

  /// Generar nombre de archivo desde URL (hash MD5)
  String _getCacheKey(String url) {
    final bytes = utf8.encode(url);
    final digest = md5.convert(bytes);
    return '${digest.toString()}.cache';
  }

  /// Obtener ruta completa del archivo
  String _getCachePath(String url) {
    return '${_cacheDir.path}/${_getCacheKey(url)}';
  }

  /// Verificar si imagen está en caché
  Future<bool> isCached(String url) async {
    final file = File(_getCachePath(url));
    return await file.exists();
  }

  /// Obtener imagen (de caché o descargar)
  Future<CacheResult?> getImage(String url) async {
    await _init();

    final cachePath = _getCachePath(url);
    final file = File(cachePath);

    // Intentar desde caché
    if (await file.exists()) {
      try {
        final bytes = await file.readAsBytes();
        return CacheResult(
          bytes: bytes,
          fromCache: true,
          path: cachePath,
        );
      } catch (e) {
        // Archivo corrupto, eliminar
        await file.delete();
      }
    }

    // Descargar
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;

        // Guardar en caché
        await file.writeAsBytes(bytes);

        // Verificar límite de caché
        await _enforceLimit();

        return CacheResult(
          bytes: bytes,
          fromCache: false,
          path: cachePath,
        );
      }
    } catch (e) {
      print('Error descargando imagen: $e');
    }

    return null;
  }

  /// Precargar múltiples imágenes
  Future<int> preloadImages(
    List<String> urls, {
    void Function(int loaded, int total)? onProgress,
  }) async {
    int loaded = 0;

    for (int i = 0; i < urls.length; i++) {
      final result = await getImage(urls[i]);
      if (result != null) loaded++;
      onProgress?.call(i + 1, urls.length);
    }

    return loaded;
  }

  /// Obtener estadísticas del caché
  Future<CacheStats> getStats() async {
    await _init();

    int totalSize = 0;
    int fileCount = 0;
    DateTime? oldest;
    DateTime? newest;

    await for (final entity in _cacheDir.list()) {
      if (entity is File) {
        fileCount++;

        final stat = await entity.stat();
        totalSize += stat.size;

        if (oldest == null || stat.modified.isBefore(oldest)) {
          oldest = stat.modified;
        }
        if (newest == null || stat.modified.isAfter(newest)) {
          newest = stat.modified;
        }
      }
    }

    return CacheStats(
      fileCount: fileCount,
      totalSizeBytes: totalSize,
      oldestFile: oldest,
      newestFile: newest,
    );
  }

  /// Aplicar límite de tamaño de caché (eliminar archivos antiguos)
  Future<void> _enforceLimit() async {
    final stats = await getStats();
    final maxBytes = maxCacheSizeMB * 1024 * 1024;

    if (stats.totalSizeBytes <= maxBytes) return;

    // Obtener archivos ordenados por fecha
    final files = <File>[];
    await for (final entity in _cacheDir.list()) {
      if (entity is File) {
        files.add(entity);
      }
    }

    // Ordenar por fecha de modificación (antiguos primero)
    files.sort((a, b) {
      final aStat = a.statSync();
      final bStat = b.statSync();
      return aStat.modified.compareTo(bStat.modified);
    });

    // Eliminar archivos hasta estar bajo el límite
    int currentSize = stats.totalSizeBytes;
    for (final file in files) {
      if (currentSize <= maxBytes * 0.8) break; // Dejar 20% de margen

      final size = (await file.stat()).size;
      await file.delete();
      currentSize -= size;
    }
  }

  /// Limpiar todo el caché
  Future<void> clearCache() async {
    await _init();

    await for (final entity in _cacheDir.list()) {
      await entity.delete();
    }
  }

  /// Eliminar una imagen específica del caché
  Future<void> removeFromCache(String url) async {
    final file = File(_getCachePath(url));
    if (await file.exists()) {
      await file.delete();
    }
  }
}
```

### 4. Widget CachedImage

```dart
// lib/widgets/cached_image.dart
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../services/image_cache_service.dart';

/**
 * CachedImage: Widget que muestra imagen con caché.
 *
 * Muestra:
 * - Placeholder mientras carga
 * - Indicador de "from cache" o "downloaded"
 * - Error widget si falla
 */
class CachedImage extends StatefulWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;
  final bool showCacheIndicator;

  const CachedImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.showCacheIndicator = false,
  });

  @override
  State<CachedImage> createState() => _CachedImageState();
}

class _CachedImageState extends State<CachedImage> {
  Uint8List? _imageBytes;
  bool _loading = true;
  bool _error = false;
  bool _fromCache = false;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  @override
  void didUpdateWidget(CachedImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) {
      _loadImage();
    }
  }

  Future<void> _loadImage() async {
    setState(() {
      _loading = true;
      _error = false;
    });

    try {
      final cacheService = await ImageCacheService.getInstance();
      final result = await cacheService.getImage(widget.url);

      if (mounted) {
        setState(() {
          if (result != null) {
            _imageBytes = result.bytes;
            _fromCache = result.fromCache;
          } else {
            _error = true;
          }
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = true;
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return _buildPlaceholder();
    }

    if (_error || _imageBytes == null) {
      return _buildError();
    }

    return Stack(
      children: [
        Image.memory(
          _imageBytes!,
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
        ),
        if (widget.showCacheIndicator)
          Positioned(
            top: 4,
            right: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: _fromCache
                    ? Colors.green.withOpacity(0.8)
                    : Colors.blue.withOpacity(0.8),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                _fromCache ? 'CACHED' : 'DOWNLOADED',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return widget.placeholder ?? Container(
      width: widget.width,
      height: widget.height,
      color: Colors.grey[300],
      child: const Center(
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }

  Widget _buildError() {
    return widget.errorWidget ?? Container(
      width: widget.width,
      height: widget.height,
      color: Colors.grey[300],
      child: const Center(
        child: Icon(Icons.error_outline, color: Colors.grey),
      ),
    );
  }
}
```

### 5. Provider (A completar)

```dart
// lib/providers/gallery_provider.dart
import 'package:flutter/foundation.dart';
import '../models/photo.dart';
import '../services/api_service.dart';
import '../services/image_cache_service.dart';

/**
 * GalleryProvider: Estado de la galería de imágenes.
 *
 * TODO: Completar implementación
 */
class GalleryProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Photo> _photos = [];
  bool _isLoading = false;
  String? _error;
  int _currentPage = 1;
  bool _hasMore = true;

  // Estado de precarga
  bool _isPreloading = false;
  int _preloadProgress = 0;
  int _preloadTotal = 0;

  // Estadísticas de caché
  CacheStats? _cacheStats;

  // Getters
  List<Photo> get photos => _photos;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasMore => _hasMore;
  bool get isPreloading => _isPreloading;
  int get preloadProgress => _preloadProgress;
  int get preloadTotal => _preloadTotal;
  CacheStats? get cacheStats => _cacheStats;

  /// Cargar fotos (inicial)
  Future<void> loadPhotos() async {
    if (_isLoading) return;

    _isLoading = true;
    _error = null;
    _currentPage = 1;
    notifyListeners();

    try {
      _photos = await _apiService.getPhotos(page: 1);
      _hasMore = _photos.length == 30;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Cargar más fotos (paginación)
  Future<void> loadMore() async {
    // TODO: Implementar paginación
    // 1. Verificar que no esté cargando y que haya más
    // 2. Incrementar página
    // 3. Obtener más fotos
    // 4. Agregar a la lista existente
  }

  /// Refrescar (pull to refresh)
  Future<void> refresh() async {
    _currentPage = 1;
    await loadPhotos();
  }

  /// Precargar todas las imágenes actuales
  Future<void> preloadCurrentImages() async {
    if (_isPreloading) return;

    _isPreloading = true;
    _preloadProgress = 0;
    _preloadTotal = _photos.length;
    notifyListeners();

    // TODO: Implementar
    // 1. Obtener ImageCacheService
    // 2. Precargar thumbnails de todas las fotos
    // 3. Actualizar progreso

    _isPreloading = false;
    notifyListeners();
  }

  /// Actualizar estadísticas de caché
  Future<void> updateCacheStats() async {
    // TODO: Implementar
  }

  /// Limpiar caché
  Future<void> clearCache() async {
    // TODO: Implementar
  }
}
```

### 6. Widget CacheStatsCard

```dart
// lib/widgets/cache_stats_card.dart
import 'package:flutter/material.dart';
import '../services/image_cache_service.dart';

class CacheStatsCard extends StatelessWidget {
  final CacheStats stats;
  final VoidCallback? onClear;

  const CacheStatsCard({
    super.key,
    required this.stats,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.storage),
                const SizedBox(width: 8),
                const Text(
                  'Caché de Imágenes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                if (onClear != null)
                  TextButton.icon(
                    onPressed: onClear,
                    icon: const Icon(Icons.delete, size: 18),
                    label: const Text('Limpiar'),
                  ),
              ],
            ),
            const Divider(),
            _buildStatRow('Archivos:', '${stats.fileCount}'),
            _buildStatRow('Tamaño:', stats.formattedSize),
            if (stats.oldestFile != null)
              _buildStatRow(
                'Más antiguo:',
                _formatDate(stats.oldestFile!),
              ),
            if (stats.newestFile != null)
              _buildStatRow(
                'Más reciente:',
                _formatDate(stats.newestFile!),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
```

---

## ✅ Tareas a Completar

### Nivel 1: Básico

- [ ] Implementar `GalleryScreen` con grid de imágenes
- [ ] Mostrar indicador de caché en cada imagen
- [ ] Pull to refresh

### Nivel 2: Intermedio

- [ ] Implementar paginación infinita
- [ ] Completar `GalleryProvider` (loadMore, preload)
- [ ] Pantalla de configuración de caché

### Nivel 3: Avanzado

- [ ] Vista de detalle con imagen grande
- [ ] Zoom y gestos en imagen
- [ ] Exportar/compartir imagen
- [ ] Límite de caché configurable

---

## 🎨 UI Esperada

```
┌─────────────────────────────────────┐
│ Galería                       ⚙️   │
├─────────────────────────────────────┤
│ ┌─────────┬─────────┬─────────┐    │
│ │ [img]   │ [img]   │ [img]   │    │
│ │ CACHED  │DOWNLOAD │ CACHED  │    │
│ └─────────┴─────────┴─────────┘    │
│ ┌─────────┬─────────┬─────────┐    │
│ │ [img]   │ [img]   │ [img]   │    │
│ │ CACHED  │ CACHED  │DOWNLOAD │    │
│ └─────────┴─────────┴─────────┘    │
│ ┌─────────┬─────────┬─────────┐    │
│ │ [img]   │ [img]   │ [img]   │    │
│ │DOWNLOAD │ CACHED  │ CACHED  │    │
│ └─────────┴─────────┴─────────┘    │
│                                     │
│ ┌─────────────────────────────────┐ │
│ │ 📦 Caché: 15 archivos · 4.2 MB  │ │
│ │ [Precargar todo]  [Limpiar]     │ │
│ └─────────────────────────────────┘ │
└─────────────────────────────────────┘
```

---

## 📊 Criterios de Evaluación

| Criterio                   | Puntos  |
| -------------------------- | ------- |
| Sistema de caché funcional | 30      |
| UI de galería completa     | 25      |
| Estadísticas y gestión     | 20      |
| Paginación                 | 15      |
| Código limpio              | 10      |
| **Total**                  | **100** |

---

## 🔗 Recursos

- [Picsum Photos API](https://picsum.photos/)
- [path_provider docs](https://pub.dev/packages/path_provider)
- [crypto package](https://pub.dev/packages/crypto)

---

## ➡️ Siguiente Práctica

[Práctica 05: Sincronización Offline](./practica-05-sync-offline.md)
