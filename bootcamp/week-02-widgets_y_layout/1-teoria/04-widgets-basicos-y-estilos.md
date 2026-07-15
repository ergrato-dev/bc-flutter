# Widgets Básicos y Estilos

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Los widgets de presentación más usados: `Text`, `Icon`, `Image`
- Cómo aplicar estilos con `TextStyle` y `ThemeData`
- La diferencia entre `Padding`, `SizedBox` y `Container` para espaciado

## 📋 Conceptos Clave

### 1. Text y TextStyle

```dart
const Text(
  'Precio: \$45.000',
  style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  ),
)
```

Para estilos consistentes en toda la app, prefiere el tema en vez de repetir `TextStyle`:

```dart
Text('Título', style: Theme.of(context).textTheme.headlineSmall)
```

### 2. Icon e Image

```dart
const Icon(Icons.favorite, color: Colors.red, size: 28)

Image.network(
  'https://picsum.photos/200',
  fit: BoxFit.cover,
  loadingBuilder: (context, child, progress) =>
      progress == null ? child : const CircularProgressIndicator(),
)

Image.asset('assets/images/logo.png')
```

> 💡 **Casos de uso móvil**: `Image.network` sin caché redescarga la imagen en cada rebuild —
> en apps reales se usa el paquete `cached_network_image` (lo verás mencionado en semana 16,
> performance).

### 3. Padding, SizedBox y espaciado

```dart
// Padding: agrega espacio ALREDEDOR de su hijo
Padding(
  padding: const EdgeInsets.all(16),
  child: const Text('Con espacio alrededor'),
)

// SizedBox: espacio VACÍO de tamaño fijo (o fuerza el tamaño de su hijo)
const SizedBox(height: 12) // espaciador vertical entre widgets en una Column

// Container: combina padding, margin, decoración Y tamaño en un solo widget
```

> 💡 **Regla práctica**: usa `SizedBox` para espacios vacíos simples, `Padding` cuando envuelves
> contenido, y `Container` solo cuando necesitas decoración (color, bordes, sombra) además de
> espaciado — usar `Container` para todo es más pesado de lo necesario.

### 4. Botones comunes

```dart
ElevatedButton(onPressed: () {}, child: const Text('Elevado'));
TextButton(onPressed: () {}, child: const Text('Texto'));
OutlinedButton(onPressed: () {}, child: const Text('Contorno'));
IconButton(icon: const Icon(Icons.delete), onPressed: () {});
```

Todos aceptan `onPressed: null` para deshabilitarse automáticamente (Flutter los muestra en
gris sin lógica adicional).

## ⚠️ Errores Comunes

- Repetir el mismo `TextStyle` en decenas de lugares en vez de definirlo una vez en el tema.
- Usar `Container` con solo `padding` cuando `Padding` es más simple y ligero.
- Olvidar `key` (heredado del constructor `super.key`) en widgets personalizados reutilizables —
  importa para que Flutter identifique correctamente cada instancia al reconstruir listas.

## 📚 Recursos Adicionales

- [Flutter — Text class](https://api.flutter.dev/flutter/widgets/Text-class.html)
- [Flutter — Using themes](https://docs.flutter.dev/cookbook/design/themes)

## ✅ Checklist de Verificación

- [ ] Puedo aplicar estilos de texto directamente y vía tema
- [ ] Sé cuándo usar Padding vs SizedBox vs Container
- [ ] Conozco los botones básicos de Material
