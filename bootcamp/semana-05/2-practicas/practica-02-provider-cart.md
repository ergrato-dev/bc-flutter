# Práctica 02: Carrito con `Provider` (ChangeNotifier)

## Descripción

Implementar un catálogo de productos y un carrito global usando `Provider`:

- Lista de productos con botón "Agregar al carrito".
- `CartModel` como `ChangeNotifier`.
- Contador en `AppBar` que muestra la cantidad de items usando `Selector`.

## Requisitos mínimos

- `ChangeNotifier` con métodos `add`/`remove` y getter `items`.
- `ChangeNotifierProvider` en la raíz.
- Uso de `Selector` para optimizar reconstrucciones.

## Criterios de evaluación

- Funcionalidad (3 pts)
- Uso correcto de `Selector` (1.5 pts)
- Código y organización (1.5 pts)
