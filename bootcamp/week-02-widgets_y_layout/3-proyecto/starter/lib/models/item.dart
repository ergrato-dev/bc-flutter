// ============================================
// MODEL: Item
// Entidad genérica que representa un elemento de tu dominio asignado.
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Adapta esta clase a tu dominio asignado (igual que en semana 1). Ejemplos:
// - Biblioteca: Book (title, author, isbn, available)
// - Farmacia: Medication (name, price, stock, category)
// - Gimnasio: Member (name, plan, startDate, active)

class Item {
  final String id;
  final String name;
  final String description;

  // TODO: Agrega aquí las propiedades específicas de tu dominio.
  // Ejemplo (Biblioteca): final String author;
  // Ejemplo (Farmacia): final double price;

  const Item({
    required this.id,
    required this.name,
    required this.description,
  });
}
