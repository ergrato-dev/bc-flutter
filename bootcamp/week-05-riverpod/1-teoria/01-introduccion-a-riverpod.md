# Introducción a Riverpod

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Qué es Riverpod y por qué se convierte en el estándar del resto del bootcamp
- Cómo instalar Riverpod con generación de código
- El rol de `ProviderScope` y por qué reemplaza el patrón de semana 4

## 📋 Conceptos Clave

### 1. Riverpod, en una frase

Riverpod resuelve los mismos problemas que Provider (semana 4) — compartir y observar estado —
pero **sin depender de `BuildContext`** ni del árbol de widgets para funcionar. Fue creado por
el mismo autor de Provider, como su sucesor.

> 💡 **Anagrama**: "Riverpod" es un anagrama de "Provider" — no es casualidad, es una
> declaración de intención del propio autor.

### 2. Por qué Riverpod desde aquí en adelante

Repasando los límites de Provider (semana 4, archivo 6):

| Limitación de Provider | Cómo lo resuelve Riverpod |
|---|---|
| Necesita `BuildContext` para leer estado | `ref` funciona en cualquier parte, incluso fuera de widgets |
| Errores de tipo solo en runtime ("no provider found") | Verificados en **tiempo de compilación** |
| Combinar/derivar estado de varios providers es verboso (`ProxyProvider`) | Composición de providers simple y directa |
| Testing requiere montar widgets para overrides | Overrides diseñados para testing desde el inicio |

Desde esta semana, **todo el estado nuevo del bootcamp usa Riverpod** — Provider no vuelve a
aparecer como tema (aunque seguirás viéndolo en apps reales de la industria).

### 3. Instalación con generación de código

Este curso usa el enfoque **recomendado oficialmente**: generación de código con
`riverpod_generator`, en vez de declarar providers a mano.

```yaml
# pubspec.yaml
dependencies:
  flutter_riverpod: 3.3.2
  riverpod_annotation: 4.0.3

dev_dependencies:
  build_runner: 2.15.1
  riverpod_generator: 4.0.4
```

```bash
flutter pub get
dart run build_runner build
```

`build_runner` lee tus anotaciones `@riverpod` y genera un archivo `*.g.dart` junto a cada
archivo que las use — verás el resultado en el archivo 2 de esta semana.

> ⚠️ **Cada vez que modifiques un provider** (agregar un campo, cambiar una firma), debes
> volver a correr `build_runner build`. Usa `dart run build_runner watch -d` durante desarrollo
> activo para que regenere automáticamente al guardar.

### 4. ProviderScope: el nuevo punto de entrada

```dart
void main() {
  runApp(const ProviderScope(child: MyApp()));
}
```

`ProviderScope` reemplaza al `ChangeNotifierProvider`/`MultiProvider` de semana 4 — es un solo
widget en la raíz que almacena **todos** los providers de la app, sin importar cuántos declares.
A diferencia de Provider, no necesitas envolver cada notifier individualmente.

## ⚠️ Errores Comunes

- Olvidar `part 'archivo.g.dart';` al inicio del archivo que usa `@riverpod` — sin eso,
  `build_runner` no sabe dónde escribir el código generado.
- Olvidar volver a correr `build_runner build` tras modificar un provider — el analyzer marcará
  errores confusos sobre símbolos que "no existen" (en realidad existen, pero en la versión
  vieja del `.g.dart`).
- Olvidar `ProviderScope` en la raíz — cualquier `ref.watch` lanza una excepción en runtime.

## 📚 Recursos Adicionales

- [riverpod.dev — Getting started](https://riverpod.dev/docs/introduction/getting_started)
- [riverpod.dev — What's new in Riverpod 3.0](https://riverpod.dev/docs/whats_new)
- [flutter_riverpod — pub.dev](https://pub.dev/packages/flutter_riverpod)

## ✅ Checklist de Verificación

- [ ] Entiendo por qué Riverpod no depende de BuildContext
- [ ] Puedo instalar Riverpod con generación de código y correr build_runner
- [ ] Sé que ProviderScope reemplaza a ChangeNotifierProvider/MultiProvider de semana 4
