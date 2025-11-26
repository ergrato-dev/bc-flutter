# 📊 Rúbrica de Evaluación - Semana 10

## Proyecto Final y Deployment

**Puntuación Total: 100 puntos**

---

## 📋 Distribución General

| Componente               | Puntos  | Porcentaje |
| ------------------------ | ------- | ---------- |
| Prácticas (5 ejercicios) | 30      | 30%        |
| Proyecto Final           | 70      | 70%        |
| **TOTAL**                | **100** | 100%       |

---

## 1️⃣ Prácticas (30 puntos)

### Práctica 01: Configuración de Producción (6 pts)

| Criterio             | Puntos | Descripción                               |
| -------------------- | ------ | ----------------------------------------- |
| Variables de entorno | 2      | `dart-define` correctamente configurado   |
| Entry points         | 2      | `main_dev.dart`, `main_prod.dart` creados |
| Config classes       | 2      | `AppConfig` implementado correctamente    |

### Práctica 02: Optimización de Assets (6 pts)

| Criterio           | Puntos | Descripción                          |
| ------------------ | ------ | ------------------------------------ |
| App icon           | 2      | `flutter_launcher_icons` configurado |
| Splash screen      | 2      | `flutter_native_splash` funcionando  |
| Assets optimizados | 2      | Imágenes comprimidas                 |

### Práctica 03: Build y Firma (6 pts)

| Criterio         | Puntos | Descripción                   |
| ---------------- | ------ | ----------------------------- |
| Keystore creado  | 2      | `.jks` generado correctamente |
| `key.properties` | 2      | Configuración segura          |
| APK firmado      | 2      | Build release exitoso         |

### Práctica 04: CI/CD con GitHub Actions (6 pts)

| Criterio        | Puntos | Descripción                 |
| --------------- | ------ | --------------------------- |
| Workflow básico | 2      | `.github/workflows/ci.yml`  |
| Tests en CI     | 2      | `flutter test` ejecutándose |
| Build en CI     | 2      | APK generándose             |

### Práctica 05: Analytics y Monitoring (6 pts)

| Criterio       | Puntos | Descripción                   |
| -------------- | ------ | ----------------------------- |
| Firebase setup | 2      | Proyecto Firebase configurado |
| Analytics      | 2      | Eventos personalizados        |
| Crashlytics    | 2      | Error reporting funcionando   |

---

## 2️⃣ Proyecto Final: LifeTracker Pro (70 puntos)

### A. Funcionalidad (25 puntos)

#### Módulo Hábitos (7 pts)

| Criterio        | Puntos | Excelente             | Bueno            | Suficiente   |
| --------------- | ------ | --------------------- | ---------------- | ------------ |
| CRUD completo   | 3      | Todas las operaciones | 3/4 operaciones  | Solo lectura |
| Tracking diario | 2      | Múltiples tipos       | Binario          | No funciona  |
| Streaks         | 2      | Con visualización     | Cálculo correcto | Incorrecto   |

#### Módulo Tareas (6 pts)

| Criterio      | Puntos | Excelente             | Bueno           | Suficiente    |
| ------------- | ------ | --------------------- | --------------- | ------------- |
| CRUD completo | 2      | Todas las operaciones | 3/4 operaciones | Solo lectura  |
| Prioridades   | 2      | 4 niveles + filtro    | 3 niveles       | Sin filtro    |
| Subtareas     | 2      | Con progreso          | Sin progreso    | No implementa |

#### Módulo Diario (6 pts)

| Criterio      | Puntos | Excelente         | Bueno       | Suficiente   |
| ------------- | ------ | ----------------- | ----------- | ------------ |
| Registro mood | 2      | 5 estados + emoji | 3 estados   | Solo binario |
| Notas         | 2      | Rich text         | Texto plano | No guarda    |
| Historial     | 2      | Con búsqueda      | Solo lista  | No navega    |

#### Dashboard (6 pts)

| Criterio     | Puntos | Excelente         | Bueno        | Suficiente |
| ------------ | ------ | ----------------- | ------------ | ---------- |
| Resumen      | 2      | Todos los módulos | 2 módulos    | 1 módulo   |
| Estadísticas | 2      | Gráficos          | Solo números | Sin stats  |
| UX           | 2      | Excelente         | Aceptable    | Confuso    |

### B. Clean Architecture (15 puntos)

| Criterio            | Puntos | Excelente              | Bueno               | Suficiente         | Insuficiente   |
| ------------------- | ------ | ---------------------- | ------------------- | ------------------ | -------------- |
| Estructura de capas | 5      | 3 capas bien separadas | Algunas mezclas     | Separación parcial | Sin separación |
| Entities            | 3      | Todas las entidades    | 3/4 entidades       | 2 entidades        | No definidas   |
| Use Cases           | 4      | Todos implementados    | Principales         | Solo 2             | No implementa  |
| Repositories        | 3      | Interface + Impl       | Solo implementación | Parcial            | No usa         |

### C. Testing (10 puntos)

| Tipo de Test      | Cantidad | Puntos | Criterio           |
| ----------------- | -------- | ------ | ------------------ |
| Unit Tests        | 10+      | 4      | Lógica de negocio  |
| Widget Tests      | 5+       | 4      | Componentes clave  |
| Integration Tests | 2+       | 2      | Flujos principales |

**Escala:**

- 100% tests: Puntos completos
- 75% tests: 75% puntos
- 50% tests: 50% puntos
- <50% tests: 0 puntos

### D. CI/CD Pipeline (10 puntos)

| Criterio              | Puntos | Descripción            |
| --------------------- | ------ | ---------------------- |
| Workflow completo     | 4      | analyze + test + build |
| Secretos configurados | 2      | Keystore en secrets    |
| Artifacts             | 2      | APK descargable        |
| Triggers correctos    | 2      | push/PR configurados   |

### E. Build Firmado (5 puntos)

| Criterio     | Puntos | Descripción          |
| ------------ | ------ | -------------------- |
| APK release  | 2      | Generado sin errores |
| Firma válida | 2      | Keystore aplicado    |
| Obfuscation  | 1      | Código ofuscado      |

### F. Firebase Integration (5 puntos)

| Criterio        | Puntos | Descripción            |
| --------------- | ------ | ---------------------- |
| Analytics setup | 2      | Eventos básicos        |
| Custom events   | 1      | Eventos personalizados |
| Crashlytics     | 2      | Captura de errores     |

---

## 📈 Escala de Calificación

| Rango  | Calificación    | Descripción                   |
| ------ | --------------- | ----------------------------- |
| 90-100 | ⭐ Excelente    | Supera expectativas           |
| 80-89  | 🌟 Muy Bueno    | Cumple todos los requisitos   |
| 70-79  | ✅ Bueno        | Cumple requisitos principales |
| 60-69  | 📝 Suficiente   | Cumple mínimos                |
| 0-59   | ❌ Insuficiente | No cumple requisitos          |

---

## 📝 Criterios de Calidad de Código

### Nomenclatura (Implícito en todos los criterios)

- ✅ Código en **inglés**
- ✅ Comentarios en **español**
- ✅ Convenciones de Dart/Flutter

### Estructura

```
lib/
├── core/           # Constantes, temas, utils
├── data/           # Models, repositories impl, data sources
├── domain/         # Entities, use cases, repository interfaces
└── presentation/   # Screens, blocs, widgets
```

### Documentación

- README del proyecto completo
- Comentarios en código cuando sea necesario
- Instrucciones de setup

---

## 🎯 Bonificaciones (Hasta +10 puntos extra)

| Bonus          | Puntos | Descripción              |
| -------------- | ------ | ------------------------ |
| Dark mode      | +2     | Tema oscuro implementado |
| Localization   | +2     | i18n básico (2 idiomas)  |
| Notificaciones | +3     | Push notifications       |
| Cloud backup   | +3     | Sync con Firebase        |

---

## 📋 Checklist de Entrega

### Obligatorio

- [ ] Repositorio GitHub público
- [ ] README completo
- [ ] APK en releases
- [ ] Workflow CI/CD funcionando
- [ ] Firebase configurado

### Opcional (para bonus)

- [ ] Dark mode
- [ ] Localization
- [ ] Notificaciones
- [ ] Cloud backup

---

## 🔗 Navegación

| ⬅️ Anterior                        | 🏠 Índice                |
| ---------------------------------- | ------------------------ |
| [Glosario](./5-glosario/README.md) | [Semana 10](./README.md) |
