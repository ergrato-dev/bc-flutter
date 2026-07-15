# Funciones y Control de Flujo

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Cómo declarar funciones con parámetros posicionales, nombrados y opcionales
- Funciones flecha (arrow functions)
- `if`/`else`, `switch`, `for` y `while` en Dart

## 📋 Conceptos Clave

### 1. Funciones con tipo explícito

```dart
// Tipo de retorno explícito + parámetros tipados
int add(int a, int b) {
  return a + b;
}

// Arrow function — para cuerpos de una sola expresión
int square(int n) => n * n;
```

### 2. Parámetros nombrados y opcionales

```dart
// Parámetros nombrados (entre {}), obligatorios con `required`
String greet({required String name, String greeting = 'Hola'}) {
  return '$greeting, $name';
}

greet(name: 'Ada'); // "Hola, Ada"
greet(name: 'Ada', greeting: 'Bienvenida'); // "Bienvenida, Ada"

// Parámetros posicionales opcionales (entre [])
String buildPath(String base, [String? sub]) {
  return sub == null ? base : '$base/$sub';
}
```

> 💡 **Por qué importa para Flutter**: los constructores de widgets usan casi siempre
> parámetros nombrados (`Text('Hola', style: ...)`, `Container(width: 100, height: 100)`).
> Dominar esta sintaxis ahora te ahorra confusión en semana 2.

### 3. Control de flujo

```dart
// if / else if / else
int classify(int score) {
  if (score >= 90) {
    return 3; // excelente
  } else if (score >= 70) {
    return 2; // aprobado
  } else {
    return 1; // insuficiente
  }
}

// switch con patrones (Dart 3+)
String describe(int level) => switch (level) {
      3 => 'Excelente',
      2 => 'Aprobado',
      1 => 'Insuficiente',
      _ => 'Desconocido',
    };

// for clásico y for-in
for (var i = 0; i < 3; i++) {
  print(i);
}

final names = ['Ada', 'Grace', 'Linus'];
for (final name in names) {
  print(name);
}

// while
var attempts = 0;
while (attempts < 3) {
  attempts++;
}
```

### 4. Funciones como valores (first-class functions)

```dart
// Dart trata las funciones como objetos: se pueden asignar a variables
// y pasar como argumentos — la base de callbacks en Flutter (onPressed, onChanged...)
void Function(String) onTap = (name) => print('Tocaste a $name');

void runCallback(void Function(String) callback) {
  callback('botón');
}
```

## ⚠️ Errores Comunes

- Olvidar `required` en parámetros nombrados que no tienen valor por defecto — el analyzer lo
  marca como error, no como warning, gracias a null safety.
- Mezclar parámetros posicionales opcionales `[]` con nombrados `{}` en la misma función (Dart
  no lo permite: se elige uno de los dos estilos).

## 📚 Recursos Adicionales

- [Dart — Functions](https://dart.dev/language/functions)
- [Dart — Branches (if/switch)](https://dart.dev/language/branches)
- [Dart — Loops](https://dart.dev/language/loops)

## ✅ Checklist de Verificación

- [ ] Puedo escribir funciones con parámetros nombrados y `required`
- [ ] Sé cuándo usar arrow functions
- [ ] Puedo usar `switch` con la sintaxis de expresión de Dart 3
- [ ] Entiendo que las funciones son valores que se pueden pasar como callbacks
