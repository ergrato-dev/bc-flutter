# Ejercicio 02 — Hero Entre Pantallas

> Conectarás una lista de tarjetas de color con su pantalla de detalle usando `Hero`, para que la
> tarjeta tocada "vuele" hasta su posición final en vez de aparecer de golpe, descomentando código
> paso a paso.

## 🎯 Objetivos

- Envolver el elemento visual central de una tarjeta en `Hero` con un `tag` único
- Emparejar ese `Hero` con otro de mismo `tag` en la pantalla de detalle
- Reconocer por qué el `tag` debe incluir el identificador del ítem, no un string fijo

## 📋 Requisitos

- SDK de Flutter local configurado con emulador/simulador corriendo

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutter run
```

---

## Paso 1: Hero en la tarjeta de la lista

```dart
Hero(
  tag: 'color-square-${color.index}',
  child: Container(
    width: 56,
    height: 56,
    color: color.value,
    margin: const EdgeInsets.all(12),
  ),
)
```

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1` — envuelve el cuadro de color
dentro de cada `ListTile.leading`.

---

## Paso 2: Hero (mismo tag) en el detalle

```dart
Hero(
  tag: 'color-square-${color.index}',
  child: Container(width: 200, height: 200, color: color.value),
)
```

**Descomenta la sección `PASO 2`** en `DetailScreen` — el `tag` debe coincidir **exactamente**
con el de la lista (mismo `color.index`).

✅ **Verifica**: al tocar una tarjeta, el cuadro de color viaja desde su posición en la lista
hasta el centro de la pantalla de detalle, cambiando de tamaño en el camino. Si ves un fundido sin
movimiento, revisa que ambos `tag` sean idénticos.

---

## Paso 3: tag único por instancia, no un string fijo

Cambia temporalmente ambos `tag` a un string fijo (`'color-square'`, sin `${color.index}`) y
vuelve a correr la app.

✅ **Verifica**: al abrir cualquier tarjeta, la app funciona igual porque solo hay un `Hero`
visible por pantalla a la vez — pero si esta lista tuviera más de una tarjeta visible con el mismo
`tag` en la **misma** pantalla, Flutter lanzaría `There are multiple heroes that share the same
tag`. **Revierte el cambio** dejando `${color.index}` en ambos — es lo que garantiza que cada
instancia tenga un identificador único, igual que harás con `item.id` en el proyecto.

---

## ✅ Resultado final

Una transición `Hero` funcional entre lista y detalle, con la razón concreta (más de una
instancia por pantalla) de por qué el `tag` siempre debe incluir un identificador único.
