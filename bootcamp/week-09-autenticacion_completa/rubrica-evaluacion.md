# Rúbrica de Evaluación — Semana 09

## Distribución de Puntaje

| Tipo de Evidencia    | Peso | Instrumento             |
| -------------------- | ---- | ------------------------ |
| Conocimiento 🧠      | 30%  | Cuestionario teórico     |
| Desempeño 💪         | 40%  | Ejercicios en clase      |
| Producto 📦          | 30%  | Proyecto entregable      |

**Mínimo aprobatorio**: 70% en cada tipo de evidencia.

## 🧠 Conocimiento (30%)

| Criterio | Puntos |
|---|---|
| Qué es un token de sesión (JWT) y diferencia con Firebase Auth | 15 |
| `AuthRepository` — mismo patrón que `ItemsRepository`, aplicado a login | 15 |
| Por qué un token va en `flutter_secure_storage` y no en `SharedPreferences`/Hive | 20 |
| Interceptor de Dio — `onRequest`, por qué lee el token en cada request | 20 |
| Guard de rutas — `redirect` y por qué `appRouter` pasó a ser un provider | 20 |
| Por qué `logout()` limpia el cache de semana 8, no solo el token | 10 |

## 💪 Desempeño (40%)

| Ejercicio | Puntos | Criterio |
|---|---|---|
| Ejercicio 01 (login con JWT) | 30 | Los 3 pasos descomentados, login exitoso muestra el token, credenciales inválidas muestran el mensaje traducido |
| Ejercicio 02 (flutter_secure_storage) | 30 | Los 3 pasos descomentados, el valor guardado sobrevive a un hot restart |
| Ejercicio 03 (interceptor y guard de rutas) | 40 | Los 3 pasos descomentados, el guard redirige solo tras login/logout, el header aparece en la respuesta de `httpbin.org/headers` |

## 📦 Producto (30%)

Proyecto **Autenticación Completa**, adaptado al dominio asignado:

| Criterio | Puntos |
|---|---|
| `AuthNotifier.login()` persiste el token en `flutter_secure_storage` | 25 |
| Interceptor de Dio agrega el header `Authorization` a cada request | 25 |
| `AuthNotifier.logout()` limpia token + cache de semana 8 (favoritos e items) | 25 |
| El guard de rutas redirige a `/login` sin sesión y a `/` tras login, sin navegación manual | 15 |
| `flutter analyze` sin errores y `flutter test` pasando | 10 |

### Criterios transversales

- ✅ Implementación coherente con el dominio asignado
- ✅ Sin copia de implementaciones de otros aprendices
- ✅ App funcional en emulador/simulador iOS y/o Android
- ✅ `flutter analyze` sin errores
- ✅ `flutter test` pasando (verificable con Docker:
  `docker compose run --rm flutter flutter test`)

## Escala de Calificación

| Rango | Nivel |
|---|---|
| 90-100% | Sobresaliente |
| 80-89% | Notable |
| 70-79% | Aprobado |
| < 70% | No aprobado (requiere recuperación) |

## Formato de Entrega

- Repositorio del estudiante, carpeta `week-09/` con la misma estructura de `3-proyecto/starter/`
- Commit final con mensaje `feat(week-09): complete authentication project`
- Fecha límite: fin de la semana 9, antes de iniciar semana 10
