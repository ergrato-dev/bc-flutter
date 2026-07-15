/// Ejercicio 03 — POO y Programación Asíncrona
/// Qué: practicar clases, mixins y Future/async/await juntos.
/// Para qué: el proyecto de esta semana (modelador de dominio) combina ambos.
/// Impacto: es la base directa de Riverpod (semana 5), que usa AsyncNotifier
/// sobre exactamente este mismo patrón Future + try/catch.

Future<void> main() async {
  print('--- Ejercicio 03: POO y Async ---');

  // ============================================
  // PASO 1: Clase con constructor nombrado
  // ============================================
  // Descomenta las siguientes líneas:
  // const product = Product(name: 'Clean Code', price: 45.0);
  // print(product.name);
  // print(product.priceWithTax);

  // ============================================
  // PASO 2: Mixin compartido
  // ============================================
  // Descomenta las siguientes líneas:
  // final order = Order(id: 'ord_9f2a41', createdAt: DateTime.now());
  // print(order.shortId);

  // ============================================
  // PASO 3: Future y async/await
  // ============================================
  // Descomenta las siguientes líneas:
  // print('Pidiendo saludo...');
  // final greeting = await fetchGreeting();
  // print(greeting);

  // ============================================
  // PASO 4: Manejo de errores async
  // ============================================
  // Descomenta las siguientes líneas:
  // try {
  //   final user = await fetchUser('');
  //   print(user);
  // } catch (error) {
  //   print('Error al cargar usuario: $error');
  // }
}

// ============================================
// Declaraciones de apoyo para los pasos de arriba
// (no necesitas modificar nada aquí, solo úsalas)
// ============================================

class Product {
  final String name;
  final double price;

  const Product({required this.name, required this.price});

  double get priceWithTax => price * 1.19;
}

mixin Identifiable {
  String get id;
  String get shortId => id.substring(0, 6);
}

class Order with Identifiable {
  @override
  final String id;
  final DateTime createdAt;

  Order({required this.id, required this.createdAt});
}

Future<String> fetchGreeting() {
  return Future.delayed(const Duration(seconds: 1), () => 'Hola desde el servidor');
}

Future<String> fetchUser(String id) async {
  if (id.isEmpty) throw ArgumentError('id no puede estar vacío');
  return 'Usuario $id';
}
