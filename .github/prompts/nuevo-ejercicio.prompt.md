---
description: "Crea un ejercicio guiado completo con patrón uncomment: README con pasos explicados y starter con código comentado para descomentar. Usar cuando se necesite agregar un ejercicio a 2-practicas/."
name: "Nuevo ejercicio guiado"
argument-hint: "Número de ejercicio, semana (ej: week-05), concepto que enseña, pasos a cubrir y paquetes de Flutter que usa"
mode: "agent"
---

# Nuevo ejercicio guiado — Bootcamp Flutter

Crea un ejercicio de práctica guiada siguiendo el **patrón uncomment** del bootcamp.
Los ejercicios son tutoriales, NO tareas con TODOs.

## Patrón obligatorio: uncomment

El estudiante aprende **descomentando** código ya escrito:

**✅ CORRECTO — código comentado para descomentar:**

```dart
// ============================================
// PASO 1: Título del paso
// ============================================
debugPrint('--- Paso 1: Título ---');

// Explicación del concepto en español.
// Descomenta las siguientes líneas:
// int count = 0;
//
// void handlePress() {
//   setState(() => count++);
// }
```

**❌ INCORRECTO — no usar TODOs en ejercicios:**

```dart
// TODO: Implementar contador
int count = 0;
```

> ⚠️ Los ejercicios NO tienen carpeta `solution/`. El estudiante aprende
> descomentando y verificando que la app funcione en emulador/simulador.

## Estructura que debes crear

```
2-practicas/ejercicio-XX-nombre/
├── README.md       ← instrucciones paso a paso con ejemplos
└── starter/
    ├── lib/main.dart  ← código comentado por pasos
    └── pubspec.yaml   ← dependencias exactas con flutter pub
```

## Convenciones obligatorias

- **Idioma del README**: español (instrucciones, explicaciones)
- **Idioma del código**: inglés (variables, funciones, tipos, nombres)
- **Comentarios educativos**: español, explican conceptos para devs nuevos en Dart/Flutter
- **Dart**: null safety estricto, sin `dynamic`, `const` siempre que se pueda
- **flutter pub** exclusivamente, versiones exactas en el `pubspec.yaml` de referencia
- **Pasos numerados**: de simple a complejo, progresión didáctica clara
- **debugPrint** al inicio de cada paso para rastrear ejecución
- **Diferencias con otros frameworks**: señalar cuando aplique (React Native, web)

## README.md del ejercicio

```markdown
# Ejercicio XX — [Nombre del concepto]

> Descripción breve: qué aprenderá el estudiante.

## 🎯 Objetivos

- Objetivo 1
- Objetivo 2

## 📋 Requisitos

- Flutter SDK local configurado, emulador/simulador corriendo
- Semana XX completada

## 🚀 Cómo ejecutar

\`\`\`bash
cd starter
flutter pub get
flutter run
\`\`\`

---

## Paso 1: [Título]

Explicación del concepto en español.

\`\`\`dart
// Ejemplo explicativo completo (no el código del ejercicio)
\`\`\`

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1`.

✅ **Verifica**: [qué debe pasar en el emulador/simulador cuando funciona]

---

## Paso 2: [Título]

...

## ✅ Resultado final

[Descripción de qué debe mostrar la app al final del ejercicio]
```

## main.dart del starter

Estructura esperada:

```dart
/// Ejercicio XX — [Nombre]
/// Qué: ...
/// Para qué: ...
/// Impacto: ...

import 'package:flutter/material.dart';
// Imports adicionales comentados para descomentar en cada paso

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF0D1117),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Ejercicio XX',
                style: TextStyle(color: Color(0xFF54C5F8), fontSize: 24, fontWeight: FontWeight.bold),
              ),

              // ============================================
              // PASO 1: [Título]
              // Descomenta el widget de abajo:
              // ============================================
              // Text('Valor: $value', style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
```

## pubspec.yaml del starter

Siempre usar versiones exactas para paquetes core del curso:

```yaml
name: ejercicio_xx_nombre
publish_to: 'none'

environment:
  sdk: '>=3.5.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: 5.0.0
```

## Instrucciones para el agente

1. Crear `2-practicas/ejercicio-XX-nombre/README.md` con pasos numerados y ejemplos explicativos
2. Crear `starter/lib/main.dart` con código organizado por pasos, todo comentado listo para descomentar
3. Crear `starter/pubspec.yaml` con versiones exactas de los paquetes core usados en la semana
4. Verificar que el código descomentado sea Dart válido (null safety, sin `dynamic`)
5. Incluir `debugPrint` al inicio de cada paso para que el estudiante pueda verificar ejecución
6. Señalar diferencias con otros frameworks en los comentarios cuando sea relevante
7. NO crear carpeta `solution/`

## Datos del ejercicio a crear

$input
