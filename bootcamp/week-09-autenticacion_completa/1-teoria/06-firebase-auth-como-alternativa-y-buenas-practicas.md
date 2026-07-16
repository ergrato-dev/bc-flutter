# Firebase Auth como Alternativa y Buenas Prácticas

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Qué cambiaría en la arquitectura de esta semana si usaras Firebase Auth en vez de JWT propio
- Por qué el logout debe limpiar también el cache de semana 8
- Qué otras buenas prácticas de seguridad aplican a la autenticación móvil

## 📋 Conceptos Clave

### 1. Qué reemplazaría Firebase Auth

Si en vez de tu propio backend usaras Firebase Auth, la arquitectura de esta semana cambia en
tres puntos concretos:

| Este proyecto (JWT propio) | Con Firebase Auth |
|---|---|
| `AuthRepository` con `DioAuthRepository` | `FirebaseAuth.instance.signInWithEmailAndPassword()` |
| `flutter_secure_storage` guarda el token a mano | El SDK de Firebase persiste la sesión solo — no necesitas guardar nada tú |
| `AuthNotifier.build()` lee el token guardado | `FirebaseAuth.instance.authStateChanges()` — un `Stream` que ya te avisa de login/logout |
| Interceptor de Dio agrega `Authorization: Bearer` | `await FirebaseAuth.instance.currentUser?.getIdToken()` en cada request que lo necesite |

El patrón de "guard de rutas con `appRouterProvider`" (archivo 5) se mantiene casi igual — solo
cambiarías de dónde viene `isLoggedIn`: en vez de `ref.watch(authProvider).value != null`, sería
un provider que envuelve `authStateChanges()`.

### 2. Cuándo preferir cada uno

- **JWT contra tu backend**: ya tienes (o vas a construir) un backend propio — es tu caso en
  este bootcamp, y el de la mayoría de apps con lógica de negocio compleja del lado del
  servidor.
- **Firebase Auth**: quieres delegar login/registro/recuperación de contraseña/verificación de
  email a un servicio gestionado, sin escribir ese backend tú mismo — común en MVPs y apps sin
  equipo de backend dedicado.

### 3. El logout debe limpiar todo, no solo el token

Semana 8 (archivo 6) ya lo mencionó: un cache que sobrevive al logout deja rastro de la sesión
anterior en un dispositivo compartido. `AuthNotifier.logout()` de este proyecto limpia las tres
cosas persistidas hasta ahora:

```dart
Future<void> logout() async {
  await ref.read(secureStorageProvider).delete(key: _tokenKey);
  await ref.read(sharedPreferencesProvider).clear();   // favoritos (semana 8)
  await ref.read(itemsCacheBoxProvider).clear();        // cache de items (semana 8)
  state = const AsyncData(null);
}
```

Sin esto, un segundo usuario que inicie sesión en el mismo dispositivo vería los favoritos y el
cache del usuario anterior hasta la primera sincronización.

### 4. Otras buenas prácticas de seguridad

- **Nunca loguees el token completo** — ni con `LogInterceptor`, ni con `debugPrint`. Si
  necesitas verificar que existe, loguea solo si es `null` o no.
- **No hardcodees credenciales de prueba en el código de producción** — los usuarios fijos de
  `dummyjson.com` son solo para practicar; en tu proyecto real, nunca commitees contraseñas ni
  API keys (`--dart-define` o `.env`, ya mencionado en semanas anteriores).
- **Valida el formulario de login igual que cualquier otro** (`FormBuilderValidators.required()`
  en usuario y contraseña) — un campo vacío no debería siquiera intentar el `POST`.
- **Un token expirado no es un error de red** — si tu backend responde `401` por token vencido,
  trátalo como "sesión cerrada" (dispara `logout()`), no como un error genérico de conexión.

## ✅ Checklist de Verificación

- [ ] Sé qué tres piezas de este proyecto cambiarían si usaras Firebase Auth
- [ ] Sé cuándo preferir JWT propio y cuándo Firebase Auth
- [ ] Sé por qué `logout()` limpia el cache de semana 8, no solo el token
- [ ] Repasé las buenas prácticas de seguridad de autenticación móvil

## 📚 Siguiente paso

Continúa con los [ejercicios prácticos](../2-practicas/) de esta semana.
