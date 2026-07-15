// ============================================
// MODEL: Item
// Entidad genérica que representa un elemento de tu dominio asignado.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Adapta esta clase a tu dominio asignado (igual que en semanas 1-3).

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
