// ============================================
// MODEL: Item
// Entidad genérica que representa un elemento de tu dominio asignado.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Adapta esta clase a tu dominio asignado (igual que en semanas 1-6).
// `fromJson`/`toJson` mapean contra la API pública usada en este proyecto
// (jsonplaceholder.typicode.com/posts: `id`, `title`, `body`) — si usas
// otra API, ajusta las claves.

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

  Map<String, dynamic> toJson() {
    return {
      'title': name,
      'body': description,
    };
  }
}
