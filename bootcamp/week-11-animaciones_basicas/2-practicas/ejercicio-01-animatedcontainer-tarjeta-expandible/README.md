# Ejercicio 01 — AnimatedContainer: Tarjeta Expandible

> Convertirás un `Container` estático en una tarjeta que se expande/colapsa al tocarla, animando
> altura, color y padding a la vez con `AnimatedContainer`, descomentando código paso a paso.

## 🎯 Objetivos

- Reemplazar un `Container` plano por un `AnimatedContainer`
- Animar `height`, `color` y `padding` simultáneamente con una sola `duration`/`curve`
- Extraer `duration`/`curve` a constantes reutilizables (`AppMotion`)

## 📋 Requisitos

- SDK de Flutter local configurado con emulador/simulador corriendo

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutter run
```

---

## Paso 1: constantes de motion

```dart
abstract final class AppMotion {
  static const Duration medium = Duration(milliseconds: 250);
  static const Curve standard = Curves.easeInOut;
}
```

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1` — agrega la clase `AppMotion`
antes de `MyApp`.

---

## Paso 2: AnimatedContainer con height, color y padding

```dart
AnimatedContainer(
  duration: AppMotion.medium,
  curve: AppMotion.standard,
  height: _expanded ? 220 : 96,
  padding: EdgeInsets.all(_expanded ? 24 : 12),
  decoration: BoxDecoration(
    color: _expanded ? Colors.indigo : Colors.indigo.shade200,
    borderRadius: BorderRadius.circular(12),
  ),
  child: const Text(
    'Toca para expandir',
    style: TextStyle(color: Colors.white),
  ),
)
```

**Descomenta la sección `PASO 2`** — reemplaza el `Container` estático dentro del
`GestureDetector`.

✅ **Verifica**: al tocar la tarjeta, `height`, `color` y `padding` cambian **a la vez**, en la
misma transición de 250ms — no necesitas tres animaciones separadas.

---

## Paso 3: texto que también anima su tamaño

```dart
AnimatedDefaultTextStyle(
  duration: AppMotion.medium,
  style: TextStyle(
    color: Colors.white,
    fontSize: _expanded ? 22 : 14,
    fontWeight: _expanded ? FontWeight.bold : FontWeight.normal,
  ),
  child: const Text('Toca para expandir'),
)
```

**Descomenta la sección `PASO 3`** — reemplaza el `Text` fijo dentro del `AnimatedContainer` por
este `AnimatedDefaultTextStyle`.

✅ **Verifica**: el texto crece y se pone en negrita junto con el resto de la tarjeta, sin un
segundo `setState` ni una segunda animación manual — cada widget `Animated*` interpola su propia
propiedad de forma independiente, todos disparados por el mismo cambio de `_expanded`.

---

## ✅ Resultado final

Una tarjeta que expande/colapsa con tres propiedades animadas a la vez (tamaño, color, padding) y
un texto que escala junto con ella — la base que reconocerás en el `ItemCard` del proyecto de esta
semana.
