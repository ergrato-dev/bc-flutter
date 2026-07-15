# Deep Links

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Qué es un deep link y por qué `go_router` los soporta de forma nativa
- Los pasos generales de configuración en Android e iOS
- Cómo probar un deep link localmente

## 📋 Conceptos Clave

### 1. Qué es un deep link

Un deep link es una URL que, al abrirse (desde un navegador, un mensaje, otra app), lleva
directamente a una pantalla **específica** de tu app — no solo la abre, sino que navega al
contenido correcto. Por ejemplo: `midominio://items/42` o `https://midominio.com/items/42`
debería abrir directamente el detalle del elemento 42.

> 💡 **Por qué "gratis" con go_router**: como cada pantalla ya tiene un `path` declarado
> (`/items/:id`), `go_router` puede mapear una URL entrante directamente a esa ruta sin código
> adicional de tu parte — es la misma razón por la que este bootcamp adoptó `go_router` desde
> el día 1 (archivo 1 de esta semana).

### 2. Tipos de deep link

| Tipo | Ejemplo | Notas |
|---|---|---|
| Custom scheme | `midominio://items/42` | Más simple de configurar, pero cualquier app puede registrar el mismo esquema |
| App Links (Android) / Universal Links (iOS) | `https://midominio.com/items/42` | Requiere verificación de dominio, pero es más seguro y funciona como fallback web |

### 3. Configuración general (resumen — cada plataforma tiene su propia guía detallada)

**Android** (`android/app/src/main/AndroidManifest.xml`): agregar un `intent-filter` dentro de
la actividad principal, declarando el esquema o dominio.

**iOS** (`ios/Runner/Info.plist` + Apple Developer portal): declarar `CFBundleURLTypes` para
custom schemes, o configurar Associated Domains para Universal Links (requiere un archivo
`apple-app-site-association` alojado en tu dominio).

> ⚠️ Esta configuración es **específica de cada proyecto real** (paquete de la app, dominio
> propio) y no se puede probar de forma genérica en Docker — es la única parte de la semana
> que requiere configuración manual en el proyecto final del estudiante, fuera del alcance de
> lo verificable automáticamente en este curso.

### 4. Probar deep links localmente

```bash
# Android (con un emulador/dispositivo corriendo)
adb shell am start -a android.intent.action.VIEW -d "midominio://items/42"

# iOS (con el simulador corriendo)
xcrun simctl openurl booted "midominio://items/42"
```

Ambos comandos simulan que el usuario tocó un link externo, sin necesidad de publicar la app ni
verificar un dominio real — suficiente para desarrollo y para la demo del proyecto final.

## ⚠️ Errores Comunes

- Probar deep links solo desde dentro de la app (con `context.push`) y asumir que funcionan
  igual desde afuera — siempre probar con `adb`/`xcrun simctl` para simular el caso real.
- Olvidar que `extra` (archivo 3 de esta semana) **no** sobrevive un deep link — la pantalla de
  destino debe poder reconstruirse solo con los parámetros de la URL.
- No declarar el `intent-filter`/`CFBundleURLTypes` y asumir que `go_router` lo hace "solo" —
  `go_router` mapea la URL a una ruta, pero el sistema operativo necesita saber que tu app debe
  abrirse para esa URL.

## 📚 Recursos Adicionales

- [go_router — Deep linking](https://pub.dev/documentation/go_router/latest/topics/Deep%20linking-topic.html)
- [Flutter — Set up universal links (iOS)](https://docs.flutter.dev/cookbook/navigation/set-up-universal-links)
- [Flutter — Set up app links (Android)](https://docs.flutter.dev/cookbook/navigation/set-up-app-links)

## ✅ Checklist de Verificación

- [ ] Entiendo qué es un deep link y por qué go_router los soporta sin código extra
- [ ] Conozco la diferencia entre custom scheme y App/Universal Links
- [ ] Sé cómo probar un deep link con adb o xcrun simctl
