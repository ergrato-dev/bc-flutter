# Introducción a Dart y al Entorno de Trabajo

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Qué es Dart y por qué Flutter lo eligió como lenguaje del framework
- Cómo se ejecuta un programa Dart (compilación JIT vs AOT)
- Cómo configurar y validar tu entorno de trabajo (Docker + SDK local)
- La estructura mínima de un programa Dart

## 📋 Conceptos Clave

### 1. ¿Qué es Dart?

Dart es un lenguaje desarrollado por Google, con **tipado fuerte y null safety**, pensado para
construir interfaces de usuario rápidas en cualquier plataforma. Flutter lo usa porque Dart
permite:

- **Compilación AOT** (Ahead-Of-Time) a código nativo → apps rápidas en producción
- **Compilación JIT** (Just-In-Time) con **hot reload** → iteración rápida en desarrollo
- Un modelo de objetos único (todo es un objeto, incluso los números) que simplifica el diseño
  del framework de widgets que verás desde la semana 2

> 💡 **Diferencia con JavaScript/TypeScript**: Dart no necesita un transpilador para tener
> tipado fuerte — el análisis de tipos es parte del lenguaje desde el día uno, no una capa
> añadida encima (como TypeScript sobre JavaScript).

### 2. Cómo se ejecuta un programa Dart

```dart
// hello.dart
void main() {
  print('Hola, bootcamp de Flutter');
}
```

```bash
dart run hello.dart
```

`dart run` compila y ejecuta en un solo paso usando la VM de Dart (JIT). Cuando en semana 2
empieces a correr apps Flutter, `flutter run` hace algo similar pero además levanta el
emulador/simulador y activa hot reload.

### 3. Entorno de trabajo: Docker + SDK local

Este bootcamp usa **dos entornos complementarios**, no uno u otro (ver
[docs/docker-setup.md](../../../../docs/docker-setup.md)):

```dart
// Válido tanto corriendo con Docker como con el SDK local —
// el código Dart no cambia, cambia solo cómo lo ejecutas.
void main() {
  print('Este archivo corre igual en ambos entornos');
}
```

- **Docker** (`docker compose run --rm flutter dart test`): valida tu código de forma
  reproducible, igual que en CI. Úsalo para verificar antes de entregar.
- **SDK local** (`dart run`, y desde semana 2 `flutter run`): para iterar mientras programas.
  A partir de semana 2 necesitarás además un emulador/simulador — Docker no lo reemplaza.

### 4. Casos de Uso Móvil

Esta semana todavía no tocamos widgets ni pantallas — el objetivo es dominar el lenguaje base
antes de construir interfaces con él, igual que otros bootcamps de este catálogo dedican una
semana a TypeScript antes de arrancar React.

## ⚠️ Errores Comunes

- **Confundir `dart run` con `flutter run`**: `dart run` ejecuta programas Dart puros (como los
  de esta semana); `flutter run` ejecuta apps Flutter completas (desde semana 2).
- **Instalar Python/Node como referencia mental**: Dart no necesita gestor de versiones tipo
  nvm para este curso — Docker fija la versión del curso, y localmente basta con `flutter
  --version` (el SDK de Flutter incluye Dart).

## 📚 Recursos Adicionales

- [Dart — Get Started](https://dart.dev/get-started)
- [Dart language tour](https://dart.dev/language)
- [¿Por qué Dart? (Flutter docs)](https://docs.flutter.dev/resources/faq#why-does-flutter-use-dart)

## ✅ Checklist de Verificación

Antes de continuar a las prácticas, verifica que entiendes:

- [ ] Por qué Flutter usa Dart (AOT + JIT + hot reload)
- [ ] La diferencia entre `dart run` y `flutter run`
- [ ] Cuándo usar Docker y cuándo el SDK local en este curso
