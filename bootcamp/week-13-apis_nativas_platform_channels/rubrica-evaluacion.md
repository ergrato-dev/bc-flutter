# Rúbrica de Evaluación — Semana 13

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
| Estados de `PermissionStatus` y el patrón check → request → actuar | 20 |
| `image_picker` — orígenes, resultado nullable, qué permiso requiere cada uno | 15 |
| `geolocator` — su propia API de permisos y verificación del servicio de ubicación | 15 |
| `MethodChannel` — `invokeMethod`, `setMethodCallHandler`, coincidencia del nombre del canal | 20 |
| `PlatformException` vs. `MissingPluginException` | 15 |
| Por qué envolver una API nativa en un repository la hace testeable | 15 |

## 💪 Desempeño (40%)

| Ejercicio | Puntos | Criterio |
|---|---|---|
| Ejercicio 01 (permission_handler) | 30 | Los pasos descomentados, ciclo completo del permiso de cámara incluyendo `permanentlyDenied` → `openAppSettings()` |
| Ejercicio 02 (geolocator) | 30 | Los pasos descomentados, posición actual obtenida verificando permiso y servicio activo |
| Ejercicio 03 (platform channel) | 40 | Los pasos descomentados, nivel de batería real obtenido vía `MethodChannel`; `flutter build apk --debug` compila sin errores |

## 📦 Producto (30%)

Proyecto **APIs Nativas y Platform Channels**, adaptado al dominio asignado:

| Criterio | Puntos |
|---|---|
| `PhotoPickerField` — permiso de cámara verificado antes de `ImagePicker.pickImage` | 30 |
| Foto mostrada en `ItemCard` y `DetailScreen` cuando `photoPath != null`, con fallback a ícono | 25 |
| `photoPath` viaja por el cache local pero no se envía al API fake (`toJson()` sin ese campo) | 20 |
| Arquitectura y animaciones de semanas 10-12 sin romper | 10 |
| `flutter analyze` sin errores y `flutter test` pasando | 15 |

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

- Repositorio del estudiante, carpeta `week-13/` con la misma estructura de `3-proyecto/starter/`
- Commit final con mensaje `feat(week-13): complete native apis and platform channels project`
- Fecha límite: fin de la semana 13, antes de iniciar semana 14
