# ⚙️ Configuración del Entorno

A diferencia de un bootcamp backend, aquí **necesitas ambos entornos**, no uno u otro:

| | 🐳 Docker | 📱 SDK local + emulador/simulador |
|---|---|---|
| **Para qué** | `flutter analyze` / `flutter test` / `flutter build` reproducibles | `flutter run` — ver tu app funcionando |
| **Obligatorio** | ✅ Sí, desde semana 1 | ✅ Sí, desde semana 2 (Flutter) |
| **Requisitos** | Docker 27+, Docker Compose 2.31+ | Flutter SDK (canal stable), Android Studio y/o Xcode |
| **Por qué no alcanza uno solo** | Docker no renderiza GUI (no hay emulador dentro de un contenedor Linux) | El SDK local por sí solo no garantiza versiones idénticas entre estudiantes ni paridad con CI |

## 🔀 Guías

- → [Configuración con Docker](con-docker.md) — analyze/test/build reproducibles
- → [Configuración del SDK local](sdk-local.md) — emulador/simulador para `flutter run`

## 📋 Checklist antes de la semana 1

```
¿Tienes Docker instalado?
        │
        ├── SÍ ──► continúa
        └── NO ──► instala Docker (ver con-docker.md)

¿Tienes Flutter SDK instalado y `flutter doctor` sin errores?
        │
        ├── SÍ ──► listo, ambos entornos configurados
        └── NO ──► instala Flutter (ver sdk-local.md)
```

> ⚠️ Ambos pasos son necesarios. No es una elección "cuál prefieres" — Docker cubre la
> validación reproducible del código, el SDK local cubre ver la app corriendo.

---

→ Volver a [docs/README.md](../README.md)
