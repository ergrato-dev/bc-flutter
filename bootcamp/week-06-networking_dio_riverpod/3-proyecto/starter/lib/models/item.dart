// ============================================
// MODEL: Item
// Entidad genérica que representa un elemento de tu dominio asignado.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Adapta esta clase a tu dominio asignado (igual que en semanas 1-5).
// `fromJson` mapea la respuesta de la API pública usada en este proyecto
// (jsonplaceholder.typicode.com/posts: `id`, `title`, `body`) a los campos
// de Item — si usas otra API para tu dominio, ajusta las claves del `json`.

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

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'].toString(),
      name: json['title'] as String? ?? '',
      description: json['body'] as String? ?? '',
    );
  }
}
