/// Ejercicio 01 — Variables, Tipos y Null Safety
/// Qué: practicar var/final/const y los operadores de null safety.
/// Para qué: son la base de cualquier código Dart/Flutter que escribirás después.
/// Impacto: sin esto, el analyzer de Dart bloqueará casi todo el código de semana 2 en adelante.

void main() {
  print('--- Ejercicio 01: Variables y Null Safety ---');

  // ============================================
  // PASO 1: var, final y const
  // ============================================
  // Descomenta las siguientes líneas:
  // final city = 'Bogotá';
  // const pi = 3.1416;
  // print(city);
  // print(pi);

  // ============================================
  // PASO 2: Tipos nulables y el operador ?.
  // ============================================
  // Descomenta las siguientes líneas:
  // String? nickname;
  // print(nickname?.length);

  // ============================================
  // PASO 3: ?? y ??=
  // ============================================
  // Descomenta las siguientes líneas:
  // final displayName = nickname ?? 'Sin apodo';
  // print(displayName);
  // nickname ??= 'Anónimo';
  // print(nickname);

  // ============================================
  // PASO 4: El operador ! (úsalo solo si estás seguro)
  // ============================================
  // Descomenta las siguientes líneas:
  // String? maybeNull = 'seguro';
  // String definitelyNotNull = maybeNull!;
  // print(definitelyNotNull);
}
