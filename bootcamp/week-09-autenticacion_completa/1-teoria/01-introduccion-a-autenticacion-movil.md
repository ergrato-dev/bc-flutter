# Introducción a Autenticación Móvil

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Qué problema resuelve la autenticación y qué es un token de sesión (JWT)
- Panorama: autenticación con JWT contra tu propio backend vs Firebase Auth
- Qué paquetes usa esta semana y por qué

## 📋 Conceptos Clave

### 1. El problema: identificar al usuario en cada request

Hasta semana 8, cada request a la API (`fetchItems()`, `createItem()`) era anónimo — cualquiera
podía llamarla. Autenticación es el proceso de que el usuario demuestre quién es (login), y que
la app **recuerde** esa identidad en cada request siguiente sin pedir la contraseña de nuevo.

La forma estándar de "recordar" es un **token**: una cadena que el servidor emite al hacer login
y que el cliente reenvía en cada request (típicamente en el header `Authorization`). Un **JWT**
(JSON Web Token) es el formato de token más común — una cadena firmada que codifica quién es el
usuario y hasta cuándo es válida, sin que el servidor tenga que guardar sesiones en memoria.

### 2. Dos caminos: JWT contra tu backend vs Firebase Auth

| | JWT contra tu backend | Firebase Auth |
|---|---|---|
| Quién emite el token | Tu propio servidor | El servicio de Firebase |
| Qué necesitas | Un backend con endpoint de login | Un proyecto de Firebase configurado |
| Dónde vive la sesión | La guardas tú (`flutter_secure_storage`) | El SDK de Firebase la persiste solo |
| Cuándo usarlo | Ya tienes (o vas a construir) tu propio backend | Quieres delegar auth completa a un servicio gestionado |

Esta semana practica el primer camino — login con JWT — porque es el que aplica directo sobre el
proyecto que vienes construyendo desde semana 5 (una API REST propia, sin backend gestionado). El
archivo 6 cubre Firebase Auth como alternativa y cuándo preferirla.

### 3. Instalación

```yaml
# pubspec.yaml
dependencies:
  flutter_secure_storage: 10.3.1
```

```bash
flutter pub add flutter_secure_storage
```

`flutter_secure_storage` es el único paquete nuevo esta semana — el login en sí es un `POST` más
con Dio (ya lo sabes hacer desde semana 6-7); lo nuevo es **dónde guardas el resultado** y
**cómo lo reenvías** en cada request.

### 4. La API de práctica: dummyjson.com

Igual que `jsonplaceholder.typicode.com` para datos de dominio, esta semana usa
`https://dummyjson.com` para login — es una API pública gratuita, sin necesidad de registro, con
usuarios de prueba fijos (`emilys` / `emilyspass`) y un endpoint `/auth/login` que retorna un JWT
real.

## ✅ Checklist de Verificación

- [ ] Sé explicar qué es un token de sesión y qué problema resuelve
- [ ] Sé qué es un JWT a nivel conceptual (cadena firmada, no un dato guardado en el servidor)
- [ ] Sé la diferencia entre JWT contra tu backend y Firebase Auth
- [ ] Sé por qué esta semana usa dummyjson.com para practicar login

## 📚 Próximo paso

[Login y Registro con JWT →](02-login-y-registro-con-jwt.md)
