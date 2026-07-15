# Ejercicio 02 — Layout con Row, Column y Expanded

> Construirás una tarjeta de producto/elemento combinando `Row`, `Column`, `Expanded` y
> `Container`, descomentando código paso a paso.

## 🎯 Objetivos

- Combinar `Row` y `Column` para armar un layout de tarjeta
- Usar `Expanded` para que el texto ocupe el espacio disponible sin desbordar
- Usar `Spacer` para alinear contenido a los extremos

## 📋 Requisitos

- Ejercicio 01 completado

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutter run
```

---

## Paso 1: Container como base de la tarjeta

```dart
Container(
  padding: const EdgeInsets.all(16),
  margin: const EdgeInsets.all(12),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
  ),
  child: const Text('Tarjeta base'),
)
```

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1`.

✅ **Verifica**: debe verse una tarjeta blanca con sombra y bordes redondeados.

---

## Paso 2: Row + Column + Expanded

```dart
Row(
  children: [
    const Icon(Icons.inventory_2, size: 40),
    const SizedBox(width: 12),
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Nombre del elemento', style: TextStyle(fontWeight: FontWeight.bold)),
          const Text('Descripción breve', overflow: TextOverflow.ellipsis),
        ],
      ),
    ),
  ],
)
```

**Descomenta la sección `PASO 2`** y reemplaza el contenido de la tarjeta del Paso 1 por este
`Row`.

✅ **Verifica**: el texto largo NO debe desbordar la pantalla — debe cortarse con `...` si no cabe.

---

## Paso 3: Spacer para alinear un precio a la derecha

```dart
Row(
  children: [
    const Text('Nombre'),
    const Spacer(),
    const Text('\$45.000', style: TextStyle(fontWeight: FontWeight.bold)),
  ],
)
```

**Descomenta la sección `PASO 3`** y agrégalo dentro de la `Column` del Paso 2.

✅ **Verifica**: el precio debe quedar pegado al borde derecho de la tarjeta, sin importar el
ancho del nombre.

---

## ✅ Resultado final

Una tarjeta con ícono, nombre, descripción (truncada si es larga) y un precio alineado a la
derecha — el layout base que reutilizarás en el proyecto de esta semana.
