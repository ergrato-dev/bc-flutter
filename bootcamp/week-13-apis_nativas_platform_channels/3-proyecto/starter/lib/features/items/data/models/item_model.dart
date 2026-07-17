import '../../domain/entities/item.dart';

// ============================================
// MODEL: ItemModel
// Extiende la entidad de dominio y le agrega la traducción hacia/desde JSON
// (API) y hacia/desde el cache local — la entidad Item nunca conoce estos
// formatos. Ver teoría 02.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo. Si agregaste propiedades a Item (entidad),
// agrégalas también aquí en fromJson/toJson/fromCacheMap/toCacheMap.
// `photoPath` solo viaja por el cache local — `jsonplaceholder` no tiene
// ese campo, por eso `toJson()` no lo incluye.
class ItemModel extends Item {
  const ItemModel({
    required super.id,
    required super.name,
    required super.description,
    super.photoPath,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'].toString(),
      name: json['title'] as String? ?? '',
      description: json['body'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': name, 'body': description};
  }

  factory ItemModel.fromCacheMap(dynamic map) {
    final m = map as Map;
    return ItemModel(
      id: m['id'] as String,
      name: m['name'] as String,
      description: m['description'] as String,
      photoPath: m['photoPath'] as String?,
    );
  }

  Map<String, dynamic> toCacheMap() {
    return {'id': id, 'name': name, 'description': description, 'photoPath': photoPath};
  }
}
