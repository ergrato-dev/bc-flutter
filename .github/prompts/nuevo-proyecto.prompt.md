---
description: "Crea un proyecto semanal integrador completo: README con instrucciones genéricas adaptables a dominios, starter con TODOs, Docker y estructura Flutter. Usar cuando se necesite el proyecto de 3-proyecto/ de una semana."
name: "Nuevo proyecto semanal"
argument-hint: "Semana (ej: week-06), concepto principal que integra, pantallas requeridas, features obligatorias y paquetes del stack que debe usar"
mode: "agent"
---

# Nuevo proyecto semanal — Bootcamp Flutter

Crea el proyecto integrador de la semana en `3-proyecto/`, siguiendo la
**Política de Dominios Únicos** del bootcamp. El proyecto usa TODOs genéricos
que cada aprendiz adapta a su dominio asignado.

## Diferencia clave: ejercicios vs proyectos

| Ejercicios (2-practicas/)         | Proyectos (3-proyecto/)              |
| --------------------------------- | ------------------------------------ |
| Código comentado para descomentar | TODOs para implementar desde cero    |
| Sin `solution/`                   | Con `solution/` (oculta, .gitignore) |
| Instructor guía paso a paso       | Estudiante implementa autónomamente  |
| Concepto único y acotado          | Integración de múltiples conceptos   |

## Política de Dominios Únicos

Las instrucciones del proyecto deben ser **genéricas y adaptables** a cualquier dominio.
Incluir siempre ejemplos de adaptación:

- 📖 Biblioteca → libros, autores, préstamos
- 💊 Farmacia → medicamentos, ventas, inventario
- 🏋️ Gimnasio → miembros, rutinas, asistencias
- 🍽️ Restaurante → platillos, mesas, pedidos
- 🏥 Hospital → pacientes, citas, médicos
- ✈️ Agencia de viajes → destinos, reservas, clientes

## Estructura que debes crear

```
3-proyecto/
├── README.md          ← instrucciones genéricas + ejemplos por dominio
└── starter/
    ├── pubspec.yaml
    ├── Dockerfile
    ├── docker-compose.yml
    ├── .env.example
    └── lib/
        ├── main.dart
        ├── screens/
        │   └── home_screen.dart   ← 1 pantalla con TODOs
        ├── widgets/
        │   └── item_card.dart     ← widget genérico con TODOs
        ├── models/
        │   └── item.dart          ← clase con TODOs para el dominio
        └── services/
            └── api_client.dart    ← llamadas API (Dio) con TODOs
```

> ⚠️ NO crear la carpeta `solution/` — está en `.gitignore`.

## Convenciones obligatorias

- **Código en inglés**: variables, funciones, tipos, nombres de widgets
- **Documentación en español**: README, comentarios explicativos
- **Dart null safety estricto**: sin `dynamic`, tipos explícitos en API pública
- **Gestor de estado vigente de la semana**: respetar la progresión Provider/Riverpod/Bloc
- **flutter pub** exclusivamente, versiones exactas para paquetes core
- **TODOs genéricos**: usar `Item` / `Entity` como nombres genéricos
- **Comentarios NOTA PARA EL APRENDIZ**: guiar la adaptación al dominio
- **Docker**: incluir `Dockerfile`/`docker-compose.yml` (imagen `ghcr.io/cirruslabs/flutter:stable`) para `analyze`/`test`

## README.md del proyecto

```markdown
# Proyecto Semana XX — [Título Genérico]

> Descripción del proyecto: qué construirá el estudiante y qué conceptos integra.

## 🎯 Objetivo

Implementar [concepto] aplicado a tu dominio asignado, integrando
[lista de tecnologías del stack].

## 📋 Tu Dominio Asignado

**Dominio**: [El instructor te asignará tu dominio único al inicio del bootcamp]

> 📌 Recuerda: tu implementación debe ser coherente con tu dominio.
> No copies implementaciones de otros aprendices.

## ✅ Requisitos Funcionales (Adaptables a tu dominio)

1. Req 1
2. Req 2
3. Req 3

## 💡 Ejemplos de Adaptación por Dominio

| Dominio        | Entidad principal | Atributos ejemplo              |
| -------------- | ----------------- | ------------------------------- |
| 📖 Biblioteca  | Libro              | title, author, isbn, available  |
| 💊 Farmacia    | Medicamento        | name, price, stock, category    |
| 🏋️ Gimnasio    | Miembro            | name, plan, startDate, active   |
| 🍽️ Restaurante | Platillo           | name, price, category, image    |

## 🚀 Cómo ejecutar

\`\`\`bash
cd starter
flutter pub get
flutter run
\`\`\`

## 🐳 Validar con Docker

\`\`\`bash
docker compose run --rm flutter flutter analyze
docker compose run --rm flutter flutter test
\`\`\`

## 🛠️ Entregables

1. App funcional en emulador/simulador iOS y/o Android
2. Código adaptado a tu dominio (modelos, pantallas, datos)
3. README actualizado con descripción de tu implementación

## 📊 Criterios de Evaluación

Ver [../../rubrica-evaluacion.md](../rubrica-evaluacion.md)
```

## Pantalla genérica con TODOs (home_screen.dart)

```dart
// ============================================
// SCREEN: HomeScreen
// Lista de elementos del dominio con pull-to-refresh
// ============================================

// NOTA PARA EL APRENDIZ:
// Adapta esta pantalla a tu dominio asignado.
// Ejemplos de nombres para tu entidad principal:
// - Biblioteca: Book, books, fetchBooks
// - Farmacia: Medication, medications, fetchMedications
// - Gimnasio: Member, members, fetchMembers

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/item.dart';
import '../widgets/item_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Obtiene la lista de elementos desde la API.
    /// TODO: Implementar un provider Riverpod (FutureProvider/AsyncNotifier)
    /// que devuelva AsyncValue<List<Item>>.

    /// Renderiza cada elemento de la lista.
    /// TODO: Implementar el builder de ItemCard por elemento.

    return Scaffold(
      // TODO: Reemplazar por ListView.builder con los elementos del dominio
      body: const Center(child: Text('Implementa tu ListView aquí')),
    );
  }
}
```

## Instrucciones para el agente

1. Crear `3-proyecto/README.md` con instrucciones genéricas y tabla de adaptación por dominio
2. Crear `starter/pubspec.yaml` con dependencias exactas del stack de la semana (flutter pub, sin `^` en paquetes core)
3. Crear `starter/Dockerfile` y `starter/docker-compose.yml` (basados en la plantilla raíz del repo)
4. Crear `starter/.env.example` si el proyecto requiere variables de entorno
5. Crear pantallas en `starter/lib/screens/` con TODOs genéricos y comentarios de adaptación
6. Crear widgets en `starter/lib/widgets/` con TODOs y modelo `Item` genérico
7. Crear `starter/lib/models/item.dart` con clase genérica + TODO para atributos del dominio
8. Crear `starter/lib/services/api_client.dart` con funciones vacías + TODOs (Dio)
9. NO crear `solution/`

## Datos del proyecto a crear

$input
