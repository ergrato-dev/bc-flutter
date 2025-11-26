# Proyecto Integrador - Semana 05: ShopApp (Gestión de Estado)

## Descripción

Crear una pequeña tienda (ShopApp) que demuestre gestión de estado aplicada:

- Catálogo de productos
- Carrito de compras global
- Perfil de usuario simple (persistencia local opcional)
- Favoritos

La idea es aplicar `Provider` o `Riverpod` y demostrar el uso correcto de patterns aprendidos.

---

## Requerimientos mínimos (50 pts)

### Funcionalidad (20 pts)

- Listado de productos (Mock data) (3 pts)
- Ver detalle de producto (3 pts)
- Agregar/Eliminar al carrito (5 pts)
- Contador en AppBar (3 pts)
- Favoritos (opcional) (2 pts)
- Persistencia local simple (SharedPreferences/Hive) (opcional) (4 pts)

### Calidad del Código (15 pts)

- Estructura de carpetas clara (4 pts)
- Documentación de widgets principales (4 pts)
- Nombres en inglés y consistencia (3 pts)
- Tests básicos para la lógica (4 pts)

### UX y Performance (10 pts)

- UI limpia y responsiva (4 pts)
- Uso de `Selector`/`select` donde aplique (3 pts)
- No rebuilds innecesarios (3 pts)

### Presentación (5 pts)

- README con instrucciones para correr (2 pts)
- GIF o screenshots (3 pts)

---

## Estructura sugerida

```
lib/
├── main.dart
├── models/
│   └── product.dart
├── providers/ (or state/)
│   └── cart_model.dart
├── screens/
│   ├── home_screen.dart
│   ├── product_detail.dart
│   └── cart_screen.dart
└── widgets/
    └── product_card.dart
```

---

## Entregables

- Código en `semana-05/3-proyecto/` (o `lib/` con instrucciones)
- README con pasos para ejecutar y pruebas
- Screenshot(s) o GIF que muestren flujo principal

---

## Recomendaciones

- Empezar con Provider para la versión mínima, luego reescribir con Riverpod como extra.
- Mantener la lógica del carrito separada de la UI para facilitar tests.

---

_Buen trabajo: prioriza completar la funcionalidad antes de optimizar._
