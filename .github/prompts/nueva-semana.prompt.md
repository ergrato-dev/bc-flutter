---
description: "Crea la estructura completa de una semana del bootcamp: carpetas, README, rúbrica, teoría placeholder, prácticas placeholder, proyecto starter/solution y glosario. Usar cuando se vaya a comenzar una nueva semana."
name: "Nueva semana"
argument-hint: "Número de semana (ej: 05), nombre del tema (ej: riverpod), objetivos de aprendizaje y conceptos clave que se enseñan"
mode: "agent"
---

# Scaffold de nueva semana — Bootcamp Flutter

Crea la estructura completa de carpetas y archivos base para una semana del bootcamp,
siguiendo estrictamente las convenciones de `.github/copilot-instructions.md`.

## Estructura que debes crear

```
bootcamp/week-XX-tema_principal/
├── README.md
├── rubrica-evaluacion.md
├── 0-assets/                  ← carpeta vacía (crear .gitkeep)
├── 1-teoria/                  ← archivos .md de teoría
├── 2-practicas/               ← ejercicios guiados (uncomment pattern)
│   └── ejercicio-01/
│       ├── README.md
│       └── starter/
│           └── lib/main.dart
├── 3-proyecto/
│   ├── README.md
│   └── starter/
│       ├── pubspec.yaml
│       ├── Dockerfile
│       ├── docker-compose.yml
│       └── lib/
│           └── screens/
│               └── home_screen.dart
└── 5-glosario/
    └── README.md
```

> ⚠️ La carpeta `3-proyecto/solution/` está en `.gitignore`. NO la crees.
> Semana 19 (proyecto final) es la única excepción sin `1-teoria/`/`2-practicas/`/`0-assets/`/`4-recursos/`.

## Convenciones obligatorias

- **Idioma documentación**: español
- **Idioma código**: inglés (variables, funciones, tipos, nombres de archivo)
- **Dart**: null safety estricto, `const` siempre que se pueda, sin `dynamic`
- **Gestor de estado vigente**: Provider (semana 4), Riverpod (semana 5+), Bloc/Cubit (semana 10+) — no mezclar
- **flutter pub / dart pub**: SOLO estos, versiones exactas para paquetes core del curso
- **Docker**: `3-proyecto/starter/` incluye `Dockerfile` + `docker-compose.yml` (imagen `ghcr.io/cirruslabs/flutter:stable`)
- **Ejercicios**: patrón uncomment (código comentado para descomentar), SIN TODOs
- **Proyectos**: TODOs genéricos adaptables al dominio asignado al aprendiz
- **Teoría**: ~150 líneas por archivo, máx 200 — dividir si es necesario
- **SVGs**: dark theme (`#0d1117`), sin degradés, fuente sans-serif

## README.md de la semana

Debe seguir esta estructura:

```markdown
# Semana XX — [Título del Tema]

> Descripción breve de la semana en 1-2 líneas.

## 🎯 Objetivos de aprendizaje

Al finalizar esta semana, el estudiante será capaz de:

- ...

## 📚 Requisitos previos

- Semana anterior completada
- ...

## 🗂️ Estructura de la semana

| Carpeta        | Contenido           | Tiempo |
| -------------- | ------------------- | ------ |
| `1-teoria/`    | ...                 | 4h     |
| `2-practicas/` | ...                 | 6h     |
| `3-proyecto/`  | Proyecto integrador | 6h     |

## 📝 Contenidos

### Teoría

- [Tema 1](1-teoria/tema-1.md)
- ...

### Prácticas

- [Ejercicio 01](2-practicas/ejercicio-01/README.md)
- ...

## ⏱️ Distribución del tiempo (16 horas)

| Actividad | Tiempo | Descripción           |
| --------- | ------ | ---------------------- |
| Teoría    | 4h     | Lectura y ejemplos     |
| Prácticas | 6h     | Ejercicios guiados     |
| Proyecto  | 6h     | Implementación propia  |

## 📌 Entregables

- [ ] Ejercicios completados (prácticas descomentadas y funcionando)
- [ ] Proyecto adaptado al dominio asignado
- [ ] `flutter analyze` sin errores (verificable con Docker)
- [ ] App corriendo en emulador/simulador iOS y/o Android

## 🔗 Navegación

← [Semana XX-1](../week-XX-tema-anterior/README.md) | [Semana XX+1](../week-XX-tema-siguiente/README.md) →
```

## rubrica-evaluacion.md

Usar esta estructura base con el desglose 30/40/30:

```markdown
# Rúbrica de Evaluación — Semana XX

## Distribución de Puntaje

| Tipo de Evidencia | Peso | Instrumento          |
| ----------------- | ---- | -------------------- |
| Conocimiento 🧠   | 30%  | Cuestionario teórico |
| Desempeño 💪      | 40%  | Ejercicios en clase  |
| Producto 📦       | 30%  | Proyecto entregable  |

**Mínimo aprobatorio**: 70% en cada tipo de evidencia.

## 🧠 Conocimiento (30%)

...criterios específicos del tema...

## 💪 Desempeño (40%)

...criterios de ejercicios...

## 📦 Producto (30%)

...criterios del proyecto adaptado al dominio...

### Criterios transversales

- ✅ Implementación coherente con el dominio asignado
- ✅ Sin copia de implementaciones de otros aprendices
- ✅ App funcional en emulador/simulador iOS y/o Android
- ✅ `flutter analyze` sin errores
```

## 5-glosario/README.md

```markdown
# Glosario — Semana XX

Términos técnicos clave introducidos esta semana, ordenados alfabéticamente.

## A

## B

...

> 📚 Glosario global del bootcamp: [docs/glosario-global.md](../../docs/glosario-global.md)
```

## Instrucciones para el agente

1. Crear la estructura de carpetas completa según el árbol indicado
2. Generar el `README.md` de la semana con los objetivos y contenidos del input
3. Generar la `rubrica-evaluacion.md` adaptada al tema de la semana
4. Crear archivos placeholder en `1-teoria/` (un archivo .md por concepto principal)
5. Crear `2-practicas/ejercicio-01/` con README y `starter/lib/main.dart` usando patrón uncomment
6. Crear `3-proyecto/README.md` con instrucciones genéricas adaptables a dominios
7. Crear `3-proyecto/starter/` con estructura Flutter básica, `Dockerfile`/`docker-compose.yml` y TODOs genéricos
8. Crear `5-glosario/README.md` con los términos clave del tema
9. Crear `0-assets/.gitkeep` para que la carpeta quede trackeada por git
10. NO crear la carpeta `solution/` — está en `.gitignore`

## Datos de la semana a crear

$input
