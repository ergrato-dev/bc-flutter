/// Ejercicio 02 — Colecciones y Funciones
/// Qué: practicar List/Set/Map, métodos funcionales y parámetros nombrados.
/// Para qué: ListView.builder (semana 2) y los constructores de widgets usan
/// exactamente estos patrones.
/// Impacto: sin esto, leer código Flutter real será mucho más difícil.

void main() {
  print('--- Ejercicio 02: Colecciones y Funciones ---');

  // ============================================
  // PASO 1: List y métodos funcionales
  // ============================================
  // Descomenta las siguientes líneas:
  // final prices = [10, 25, 8, 40];
  // final expensive = prices.where((p) => p > 15).toList();
  // final total = prices.fold<int>(0, (sum, p) => sum + p);
  // print(expensive);
  // print(total);

  // ============================================
  // PASO 2: Set — sin duplicados
  // ============================================
  // Descomenta las siguientes líneas:
  // final tags = <String>{'dart', 'flutter', 'dart'};
  // print(tags);
  // print(tags.length);

  // ============================================
  // PASO 3: Map y operadores de colección
  // ============================================
  // Descomenta las siguientes líneas:
  // final stock = <String, int>{'manzana': 50, 'pera': 30};
  // final extended = {...stock, 'mango': 10};
  // print(extended);

  // ============================================
  // PASO 4: Función con parámetros nombrados
  // ============================================
  // Descomenta las siguientes líneas:
  // String greet({required String name, String greeting = 'Hola'}) {
  //   return '$greeting, $name';
  // }
  // print(greet(name: 'Ada'));
  // print(greet(name: 'Grace', greeting: 'Bienvenida'));
}
