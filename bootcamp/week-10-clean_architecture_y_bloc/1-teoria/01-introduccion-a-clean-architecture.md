# Introducción a Clean Architecture

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Qué problema resuelve Clean Architecture frente a la estructura por capas de semanas 1-9
- La regla de dependencia: las capas internas nunca conocen las externas
- Panorama de las tres capas de este proyecto: domain, data, presentation

## 📋 Conceptos Clave

### 1. El problema: todo mezclado en una carpeta por tipo

Hasta semana 9, el proyecto organizaba archivos por **tipo técnico**:
`screens/`, `providers/`, `repositories/`, `models/`. Funciona bien con una sola feature, pero no
escala: al agregar una segunda feature grande, no hay un límite claro de qué archivos pertenecen
a cuál, y un cambio en la API (Dio) puede terminar filtrándose hasta un widget si nadie es
disciplinado con las capas.

Clean Architecture (Robert C. Martin, "Uncle Bob") propone organizar por **feature primero, capa
después** — y dentro de cada feature, tres capas con una regla estricta de quién puede depender
de quién.

### 2. Las tres capas

| Capa | Contiene | Depende de |
|---|---|---|
| **domain** | Entidades, contratos de repository, use cases | Nada — ni Flutter, ni Dio, ni Hive |
| **data** | Modelos (DTOs), datasources, implementación de los repositories | domain |
| **presentation** | Widgets, pantallas, Cubits/Blocs | domain (nunca data directamente) |

### 3. La regla de dependencia

> Las dependencias de código fuente solo pueden apuntar hacia adentro.

`domain` es el centro — no importa `package:dio`, no importa `package:hive_ce_flutter`, no
importa `package:flutter/material.dart`. Es Dart puro. `data` implementa lo que `domain` exige
(`ItemsRepository`), pero `domain` nunca importa nada de `data`. `presentation` solo conoce
`domain` (entidades y use cases) — nunca instancia un `Dio` ni abre un `Box` directamente.

```
presentation  →  domain  ←  data
   (Cubits)      (centro)   (Dio, Hive, SharedPreferences...)
```

Esto es lo que ya practicaste sin nombrarlo así: `ItemsRepository` (contrato) vive separado de
`DioItemsRepository`/`CachedItemsRepository` (implementación) desde semana 6 — Clean Architecture
solo formaliza esa separación y la extiende a **todas** las piezas del proyecto, no solo al
repository.

### 4. Por qué esto importa en la práctica

- **Testear domain no requiere Flutter ni red** — un use case es una clase Dart pura, se testea
  con un repository falso en memoria (ya lo hiciste con `FakeItemsRepository` desde semana 6).
- **Cambiar de Dio a otro cliente HTTP** solo toca `data/datasources/` — ni domain ni
  presentation se enteran.
- **Cambiar de Riverpod a Bloc** (exactamente lo que hace este proyecto esta semana) solo toca
  `presentation/cubit/` — domain y data no cambian en absoluto.

## ✅ Checklist de Verificación

- [ ] Sé explicar el problema de organizar por tipo técnico en vez de por feature
- [ ] Sé las tres capas de Clean Architecture y qué contiene cada una
- [ ] Sé explicar la regla de dependencia ("las flechas apuntan hacia adentro")
- [ ] Sé un ejemplo concreto de por qué esta separación facilita un cambio futuro

## 📚 Próximo paso

[Estructura de Capas: Domain, Data, Presentation →](02-estructura-de-capas-domain-data-presentation.md)
