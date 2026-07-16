// ============================================
// ENTITY: Item
// Objeto de dominio puro — sin fromJson/toJson, sin saber que existe una
// API o una base de datos. Esa traducción vive en data/models/item_model.dart.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo. Adapta las propiedades a tu dominio igual
// que en semanas anteriores — este es el único lugar del proyecto donde
// "tu dominio" se define; todo lo demás (modelos, cubits, pantallas) solo
// referencia esta clase.
class Item {
  final String id;
  final String name;
  final String description;

  // TODO: Agrega aquí las propiedades específicas de tu dominio.

  const Item({
    required this.id,
    required this.name,
    required this.description,
  });
}
