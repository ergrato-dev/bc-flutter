# Ejercicio 01 — Dio Básico e Interceptors

> Configurarás una instancia de Dio, agregarás `LogInterceptor` y ejecutarás un GET real contra
> una API pública, descomentando código paso a paso.

## 🎯 Objetivos

- Configurar `BaseOptions` (baseUrl, timeouts)
- Agregar `LogInterceptor` y ver requests/responses en consola
- Ejecutar un GET real y mostrar el resultado en pantalla con `FutureBuilder`

## 📋 Requisitos

- SDK de Flutter local configurado con emulador/simulador corriendo
- Conexión a internet (usa la API pública `jsonplaceholder.typicode.com`)

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutter run
```

---

## Paso 1: Instancia de Dio con BaseOptions

```dart
final dio = Dio(
  BaseOptions(
    baseUrl: 'https://jsonplaceholder.typicode.com',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ),
);
```

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1`.

---

## Paso 2: LogInterceptor

```dart
dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
```

**Descomenta la sección `PASO 2`.**

✅ **Verifica**: al correr la app, en la consola de debug (`flutter run` o DevTools) debe verse
el request GET y el JSON completo de la respuesta.

---

## Paso 3: GET real con FutureBuilder

```dart
FutureBuilder<Response>(
  future: dio.get('/posts/1'),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }
    if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    }
    final data = snapshot.data!.data as Map<String, dynamic>;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(data['title'] as String),
    );
  },
)
```

**Descomenta la sección `PASO 3`** y reemplaza el `body:` de `HomeScreen` por
`body: const _PostTitle()`.

✅ **Verifica**: la pantalla muestra un spinner brevemente y luego el título de un post real
obtenido de `jsonplaceholder.typicode.com/posts/1`.

---

## ✅ Resultado final

Una app que configura Dio una sola vez, registra cada request/response en consola con
`LogInterceptor`, y muestra el resultado de un GET real — la base que usarás en el ejercicio 02
dentro de un `AsyncNotifier` de Riverpod.
