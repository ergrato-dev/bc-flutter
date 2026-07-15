---
description: "Crea un archivo de teoría completo para 1-teoria/ siguiendo la estructura estándar del bootcamp: ~150 líneas, en español, con ejemplos de código en inglés y referencias a docs oficiales."
name: "Nuevo archivo de teoría"
argument-hint: "Semana (ej: week-05), nombre del tema (ej: riverpod-estado-global), conceptos clave a cubrir y nivel de dificultad relativo a la semana anterior"
mode: "agent"
---

# Nuevo archivo de teoría — Bootcamp Flutter

Crea un archivo de teoría para `1-teoria/` siguiendo los estándares del bootcamp.

## Reglas de extensión

- **Objetivo**: ~150 líneas por archivo
- **Máximo**: 200 líneas — si se supera, dividir en archivos temáticos
- **Mínimo**: 80 líneas para que el contenido sea completo
- Dividir por sub-temas: `01-introduccion.md`, `02-providers.md`, `03-avanzado.md`

## Convenciones obligatorias

- **Idioma**: español (explicaciones, títulos, comentarios pedagógicos)
- **Código**: inglés (variables, funciones, tipos, clases/widgets)
- **Comentarios de código**: español cuando explican conceptos de aprendizaje
- **Gestor de estado vigente**: respetar la progresión Provider (S4) → Riverpod (S5+) → Bloc/Cubit (S10+)
- **Contexto mobile**: señalar diferencias iOS/Android cuando aplique
- **Sin ASCII art**: usar SVG para diagramas (referenciar desde `../0-assets/`)
- **Fuentes oficiales**: enlazar siempre a docs de Dart/Flutter/paquete usado

## Estructura requerida del archivo

```markdown
# [Título del Tema]

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Concepto 1
- Concepto 2
- Concepto 3

## 📋 Conceptos Clave

### 1. [Primer concepto]

Explicación en español...

> 💡 **Diferencia con otros frameworks**: [Si aplica]

\`\`\`dart
// Explicación del concepto en comentario
// Código con nombres en inglés
class ExampleWidget extends StatelessWidget {
  const ExampleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
\`\`\`

### 2. [Segundo concepto]

...

### 3. Ejemplos Prácticos

Caso de uso real de app móvil conocida (Instagram, Uber, Spotify):

\`\`\`dart
// Ejemplo del mundo real
\`\`\`

### 4. Casos de Uso Móvil

Cuándo usar [concepto] en una app real...

## ⚠️ Errores Comunes

- Error 1: [descripción + cómo evitarlo]
- Error 2: ...

## 📚 Recursos Adicionales

- [Documentación oficial](https://dart.dev/...)
- [Guía de Flutter](https://docs.flutter.dev/...)

## ✅ Checklist de Verificación

Antes de continuar a las prácticas, verifica que entiendes:

- [ ] Concepto 1
- [ ] Concepto 2
- [ ] Concepto 3
```

## Estilo de los ejemplos de código

Los ejemplos deben ser **educativos**, no solo descriptivos:

```dart
// ✅ CORRECTO — comenta para enseñar
class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

// En Flutter, el estado local vive en un objeto State separado del Widget.
// El Widget es inmutable; solo State puede cambiar y disparar rebuilds.
class _CounterState extends State<Counter> {
  int _count = 0;

  void _increment() {
    // setState notifica al framework que debe reconstruir este widget
    setState(() => _count++);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$_count'),
        // ElevatedButton reemplaza al <button> web — más feedback táctil
        ElevatedButton(onPressed: _increment, child: const Text('Incrementar')),
      ],
    );
  }
}
```

```dart
// ❌ INCORRECTO — sin comentarios educativos
class Counter extends StatefulWidget {
  const Counter({super.key});
  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0;
  @override
  Widget build(BuildContext context) => Text('$count');
}
```

## Cómo referenciar assets SVG

Si el tema necesita un diagrama, referenciar el SVG de `0-assets/`:

```markdown
![Diagrama del widget tree](../0-assets/widget-tree-flow.svg)
```

Si el SVG no existe, indicar que debe crearse con el prompt `svg-diagrama`.

## Convenciones de Dart en teoría

```dart
// clases inmutables para datos (sufijo Data o nombre de dominio)
class CardData {
  final String title;
  final VoidCallback onPressed;

  const CardData({required this.title, required this.onPressed});
}

// widgets con constructor const y super.key
class Card extends StatelessWidget {
  const Card({super.key, required this.data});

  final CardData data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: data.onPressed, child: Text(data.title));
  }
}

// null safety explícito
User? currentUser;
```

## Instrucciones para el agente

1. Crear el archivo en `bootcamp/week-XX/1-teoria/nombre-tema.md`
2. Respetar el límite de ~150 líneas — dividir en múltiples archivos si el tema lo requiere
3. Incluir obligatoriamente: Objetivos, Conceptos Clave, Ejemplos Prácticos, Errores Comunes, Recursos, Checklist
4. Todos los ejemplos de código en Dart con null safety y tipos explícitos
5. Respetar el gestor de estado vigente de la semana (no introducir Riverpod antes de semana 5, ni Bloc antes de semana 10)
6. Referenciar documentación oficial de Dart y/o Flutter y/o el paquete usado
7. Si el tema requiere diagrama, indicar nombre del SVG a generar con el prompt `svg-diagrama`

## Datos del archivo de teoría a crear

$input
