# 🎨 Semana 03: Widgets y Layouts en Flutter

<div align="center">

![Flutter Widgets](https://img.shields.io/badge/Flutter-Widgets-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Duración](https://img.shields.io/badge/Duración-8_horas-green?style=for-the-badge)
![Nivel](https://img.shields.io/badge/Nivel-Intermedio-yellow?style=for-the-badge)

**Domina el arte de construir interfaces de usuario en Flutter**

[← Semana 02](../semana-02/README.md) • [Semana 04 →](../semana-04/README.md)

</div>

---

## 📋 Descripción General

Esta semana nos sumergimos en el **corazón visual de Flutter**: los widgets y el sistema de layouts. Aprenderás a construir interfaces de usuario complejas, responsivas y profesionales utilizando los bloques de construcción fundamentales de Flutter.

> **"En Flutter, todo es un widget"** - Este mantra te acompañará durante toda tu carrera como desarrollador Flutter.

---

## 🎯 Objetivos de Aprendizaje

Al completar esta semana, serás capaz de:

- [ ] **Comprender** la arquitectura del árbol de widgets y su ciclo de renderizado
- [ ] **Dominar** los widgets fundamentales: Container, Text, Image, Button
- [ ] **Implementar** layouts complejos con Column, Row, Stack, ListView y GridView
- [ ] **Crear** interfaces responsivas que se adapten a cualquier tamaño de pantalla
- [ ] **Aplicar** el sistema de constraints y el modelo de caja de Flutter
- [ ] **Diseñar** componentes reutilizables siguiendo mejores prácticas

---

## ⏱️ Distribución del Tiempo (8 horas)

| Actividad    | Tiempo | Descripción                 |
| ------------ | ------ | --------------------------- |
| 📚 Teoría    | 2.5h   | Estudio de módulos teóricos |
| 💻 Prácticas | 2.5h   | 5 ejercicios progresivos    |
| 🔨 Proyecto  | 3h     | App de Recetas completa     |

---

## 📚 Contenido Teórico

### Módulos de Estudio

| #   | Módulo                                                        | Tiempo | Contenido Principal                                              |
| --- | ------------------------------------------------------------- | ------ | ---------------------------------------------------------------- |
| 01  | [Widgets Fundamentales](1-teoria/01-widgets-fundamentales.md) | 50 min | Árbol de widgets, StatelessWidget, StatefulWidget, ciclo de vida |
| 02  | [Sistema de Layouts](1-teoria/02-sistema-layouts.md)          | 60 min | Column, Row, Stack, ListView, GridView, constraints              |
| 03  | [Diseño Responsivo](1-teoria/03-diseno-responsivo.md)         | 40 min | MediaQuery, LayoutBuilder, breakpoints, adaptación               |

### Conceptos Clave

```
┌─────────────────────────────────────────────────────────────────┐
│                     SEMANA 03 - MAPA CONCEPTUAL                 │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   WIDGETS                  LAYOUTS                RESPONSIVE    │
│   ───────                  ───────                ──────────    │
│   • StatelessWidget        • Column/Row           • MediaQuery  │
│   • StatefulWidget         • Stack                • LayoutBuilder│
│   • Container              • ListView             • Breakpoints │
│   • Text/Image             • GridView             • Orientation │
│   • Buttons                • Expanded/Flexible    • Adaptive UI │
│                                                                 │
│   ──────────────────────────────────────────────────────────    │
│                    SISTEMA DE CONSTRAINTS                       │
│            (BoxConstraints, min/max Width/Height)               │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## 💻 Prácticas

### Ejercicios Progresivos

| #   | Práctica                                                            | Dificultad | Tiempo | Widgets Clave                    |
| --- | ------------------------------------------------------------------- | ---------- | ------ | -------------------------------- |
| 01  | [Tarjeta de Perfil](2-practicas/practica-01-tarjeta-perfil.md)      | ⭐         | 25 min | Container, Column, CircleAvatar  |
| 02  | [Lista de Productos](2-practicas/practica-02-lista-productos.md)    | ⭐⭐       | 30 min | ListView.builder, Card, ListTile |
| 03  | [Galería de Imágenes](2-practicas/practica-03-galeria-imagenes.md)  | ⭐⭐       | 30 min | GridView, Image.network, Hero    |
| 04  | [Layout Responsivo](2-practicas/practica-04-layout-responsivo.md)   | ⭐⭐⭐     | 35 min | MediaQuery, LayoutBuilder        |
| 05  | [Dashboard Completo](2-practicas/practica-05-dashboard-completo.md) | ⭐⭐⭐     | 30 min | Scaffold, integración completa   |

### Progresión de Aprendizaje

```
Práctica 01 ──► Práctica 02 ──► Práctica 03 ──► Práctica 04 ──► Práctica 05
     │              │               │               │               │
     ▼              ▼               ▼               ▼               ▼
  Widgets      ListView &      GridView &      Responsive      Integración
  Básicos        Cards          Imágenes         Design         Completa
```

---

## 🔨 Proyecto Integrador

### 🍳 App de Recetas

Una aplicación completa que integra todos los conceptos de la semana.

| Documento                                           | Descripción                             |
| --------------------------------------------------- | --------------------------------------- |
| [📋 README del Proyecto](3-proyecto/README.md)      | Requisitos y especificaciones completas |
| [🎨 Guía de Diseño](3-proyecto/GUIA-DISENO.md)      | Sistema de diseño y componentes         |
| [📊 Datos de Ejemplo](3-proyecto/EJEMPLOS-DATOS.md) | Modelos y datos de prueba               |

#### Características Principales

- ✅ **Pantalla Principal**: Lista de recetas con categorías
- ✅ **Detalle de Receta**: Vista completa con ingredientes y pasos
- ✅ **Favoritos**: Guardar recetas preferidas
- ✅ **Búsqueda**: Filtrar por nombre o ingrediente
- ✅ **Responsive**: Adaptable a móvil, tablet y desktop

#### Entregables

- [ ] Código fuente completo
- [ ] README con instrucciones de ejecución
- [ ] Screenshots de la aplicación
- [ ] Documentación de widgets personalizados

---

## 📖 Recursos

### Documentación y Referencias

| #   | Recurso                                                         | Descripción                         |
| --- | --------------------------------------------------------------- | ----------------------------------- |
| 01  | [Videos: Widgets](4-recursos/01-videos-widgets.md)              | Tutoriales en video sobre widgets   |
| 02  | [Videos: Layouts](4-recursos/02-videos-layouts.md)              | Tutoriales sobre sistema de layouts |
| 03  | [Videos: Responsive](4-recursos/03-videos-responsive.md)        | Diseño adaptativo en Flutter        |
| 04  | [eBooks: Widgets](4-recursos/04-ebooks-widgets.md)              | Libros gratuitos sobre widgets      |
| 05  | [eBooks: UI/UX](4-recursos/05-ebooks-ui-ux.md)                  | Diseño de interfaces                |
| 06  | [Artículos: Widgets](4-recursos/06-articulos-widgets.md)        | Artículos técnicos widgets          |
| 07  | [Artículos: Layouts](4-recursos/07-articulos-layouts.md)        | Artículos sistema layouts           |
| 08  | [Documentación Oficial](4-recursos/08-documentacion-oficial.md) | Flutter.dev y Dart.dev              |
| 09  | [Herramientas](4-recursos/09-herramientas-desarrollo.md)        | IDEs, plugins, utilidades           |
| 10  | [Playgrounds](4-recursos/10-playgrounds-online.md)              | Entornos de práctica                |
| 11  | [Comunidades](4-recursos/11-comunidades.md)                     | Discord, Reddit, foros              |
| 12  | [YouTube Channels](4-recursos/12-canales-youtube.md)            | Canales recomendados                |

### Acceso Rápido a Recursos

- 📁 [eBooks Gratuitos](4-recursos/ebooks-free/)
- 🎬 [Videografía](4-recursos/videografia/)
- 🌐 [Webgrafía](4-recursos/webgrafia/)

---

## 📖 Glosario

Consulta el [Glosario Técnico](5-glosario/README.md) con más de 40 términos esenciales:

- Widgets y sus tipos
- Sistema de layouts
- Propiedades de alineación
- Conceptos de responsive design
- Patrones comunes

---

## 🎨 Assets y Diagramas

La carpeta [0-assets](0-assets/README.md) contiene diagramas visuales para facilitar el aprendizaje:

| Diagrama          | Módulo    | Concepto                               |
| ----------------- | --------- | -------------------------------------- |
| Widget Tree       | Módulo 01 | Jerarquía de widgets                   |
| Column/Row Axis   | Módulo 02 | Ejes main y cross                      |
| Alignments        | Módulo 02 | MainAxisAlignment y CrossAxisAlignment |
| Expanded/Flexible | Módulo 02 | Distribución de espacio                |
| Stack/Positioned  | Módulo 02 | Superposición de widgets               |
| Breakpoints       | Módulo 03 | Puntos de quiebre responsivos          |

---

## 📊 Evaluación

### Criterios de Evaluación

| Componente          | Peso     | Puntos      |
| ------------------- | -------- | ----------- |
| Comprensión Teórica | 20%      | 20 pts      |
| Prácticas (5)       | 30%      | 30 pts      |
| Proyecto Integrador | 50%      | 50 pts      |
| **Total**           | **100%** | **100 pts** |

📋 Consulta la [Rúbrica de Evaluación Completa](RUBRICA-EVALUACION.md)

### Escala de Calificación

| Rango  | Nivel           | Descripción                                 |
| ------ | --------------- | ------------------------------------------- |
| 90-100 | ⭐ Excelente    | Dominio completo, código profesional        |
| 80-89  | 🟢 Muy Bueno    | Sólida comprensión, implementación correcta |
| 70-79  | 🟡 Bueno        | Comprende conceptos, áreas de mejora        |
| 60-69  | 🟠 Suficiente   | Cumple mínimos, necesita práctica           |
| 0-59   | 🔴 Insuficiente | No alcanza objetivos mínimos                |

---

## ✅ Checklist de Completitud

### Teoría

- [ ] Módulo 01: Widgets Fundamentales leído
- [ ] Módulo 02: Sistema de Layouts leído
- [ ] Módulo 03: Diseño Responsivo leído
- [ ] Glosario consultado

### Prácticas

- [ ] Práctica 01: Tarjeta de Perfil
- [ ] Práctica 02: Lista de Productos
- [ ] Práctica 03: Galería de Imágenes
- [ ] Práctica 04: Layout Responsivo
- [ ] Práctica 05: Dashboard Completo

### Proyecto

- [ ] App de Recetas funcional
- [ ] Diseño responsivo implementado
- [ ] Código documentado
- [ ] Screenshots incluidos

---

## 🧭 Navegación del Bootcamp

```
┌────────────────────────────────────────────────────────────────┐
│                    BOOTCAMP FLUTTER                            │
├────────────────────────────────────────────────────────────────┤
│  Semana 01: Fundamentos Dart          ────────────┐            │
│  Semana 02: POO + Intro Flutter       ────────────┤            │
│  ► Semana 03: Widgets y Layouts ◄     ◄───────────┤ ESTÁS AQUÍ │
│  Semana 04: Navegación y Rutas        ────────────┤            │
│  Semana 05: Gestión de Estado         ────────────┤            │
│  Semana 06: Consumo de APIs           ────────────┤            │
│  Semana 07: Persistencia de Datos     ────────────┤            │
│  Semana 08: Características Nativas   ────────────┤            │
│  Semana 09: Arquitectura y Testing    ────────────┤            │
│  Semana 10: Proyecto Final            ────────────┘            │
└────────────────────────────────────────────────────────────────┘
```

---

## 💡 Tips de la Semana

### 🎯 Para el Éxito

1. **Practica con el Widget Inspector** - Entiende la jerarquía visual
2. **Usa `const` constructors** - Optimiza el rendimiento
3. **Mantén widgets pequeños** - Divide en componentes reutilizables
4. **Experimenta con layouts** - No hay sustituto para la práctica
5. **Consulta la documentación** - Flutter tiene excelente documentación

### ⚠️ Errores Comunes

- ❌ Overflow por no usar `Expanded` o `Flexible`
- ❌ Olvidar `const` en widgets inmutables
- ❌ Widgets demasiado anidados (más de 5-6 niveles)
- ❌ No manejar diferentes tamaños de pantalla
- ❌ Hardcodear dimensiones en lugar de usar constraints

### 🚀 Buenas Prácticas

```dart
// ✅ BIEN: Widget pequeño y reutilizable
class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final Product product;
  // ...
}

// ❌ MAL: Todo en un solo widget gigante
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // ... 500 líneas de código
        ],
      ),
    );
  }
}
```

---

## 🔗 Enlaces Rápidos

| Recurso                | Enlace                                                                                         |
| ---------------------- | ---------------------------------------------------------------------------------------------- |
| Flutter Widget Catalog | [flutter.dev/widgets](https://docs.flutter.dev/ui/widgets)                                     |
| Layout Cheat Sheet     | [Medium Article](https://medium.com/flutter-community/flutter-layout-cheat-sheet-5363348d037e) |
| Material Design 3      | [m3.material.io](https://m3.material.io/)                                                      |
| Dart Pad               | [dartpad.dev](https://dartpad.dev/)                                                            |

---

<div align="center">

**⏱️ Dedicación:** 8 horas | **📊 Evaluación:** 100 puntos

[← Semana 02: POO + Intro Flutter](../semana-02/README.md) • [Semana 04: Navegación y Rutas →](../semana-04/README.md)

---

_Bootcamp Flutter - Formando desarrolladores móviles profesionales_

</div>
