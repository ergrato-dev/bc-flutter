# 🔨 Proyecto Integrador - Semana 06

## 📰 News Reader App

### 📋 Descripción General

Desarrolla una aplicación completa de noticias que consume una API REST real, implementando todas las técnicas de consumo de APIs aprendidas durante la semana.

### 🎯 Objetivos del Proyecto

| Objetivo | Descripción |
|----------|-------------|
| **Consumo de API** | Integrar NewsAPI para obtener noticias |
| **Serialización** | Crear modelos robustos con JSON |
| **Estados de carga** | Implementar loading, error, success |
| **Búsqueda** | Implementar búsqueda con debounce |
| **Persistencia** | Guardar favoritos localmente |

### 📁 Documentación del Proyecto

| Archivo | Contenido |
|---------|-----------|
| [GUIA-DISENO.md](./GUIA-DISENO.md) | Wireframes, paleta de colores, componentes UI |
| [EJEMPLOS-DATOS.md](./EJEMPLOS-DATOS.md) | Estructura JSON, modelos, mocks para testing |

### 🔧 Stack Tecnológico

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0              # Peticiones HTTP
  provider: ^6.1.1          # Gestión de estado
  shared_preferences: ^2.2.2 # Persistencia local
  cached_network_image: ^3.3.1 # Cache de imágenes
  url_launcher: ^6.2.2      # Abrir enlaces
  share_plus: ^7.2.1        # Compartir contenido
  intl: ^0.18.1             # Formateo de fechas
```

### 📱 Pantallas Requeridas

| # | Pantalla | Funcionalidad |
|---|----------|---------------|
| 1 | **Home** | Top headlines, categorías, pull-to-refresh |
| 2 | **Categorías** | Filtrado por Business, Tech, Sports, etc. |
| 3 | **Búsqueda** | Búsqueda en tiempo real con debounce |
| 4 | **Detalle** | Imagen, contenido, abrir/compartir |
| 5 | **Favoritos** | Lista de noticias guardadas |

### ⏱️ Distribución del Tiempo

```
Tiempo total: ~2.5 horas
├── Configuración y modelos: 30 min
├── Servicio API: 30 min
├── Provider y estados: 25 min
├── UI - Home y Lista: 25 min
├── UI - Detalle y Favoritos: 20 min
└── Búsqueda y pulido: 20 min
```

### 📊 Criterios de Evaluación

| Criterio | Peso | Descripción |
|----------|------|-------------|
| Funcionalidad | 40% | Features implementados correctamente |
| Manejo de errores | 20% | Loading, error states, offline |
| Código limpio | 20% | Estructura, nomenclatura, DRY |
| UI/UX | 10% | Diseño atractivo y usable |
| Extras | 10% | Paginación, cache, animaciones |

### 🎖️ Características Bonus

- [ ] Paginación infinita (load more)
- [ ] Skeleton loading
- [ ] Soporte offline (mostrar cache)
- [ ] Animaciones en transiciones
- [ ] Dark/Light mode
- [ ] Filtro por país

### 🔗 API Sugerida

**NewsAPI** - https://newsapi.org/

```
Endpoints:
- GET /top-headlines
- GET /everything

Parámetros:
- country: us, mx, es, ar
- category: business, technology, sports
- q: query de búsqueda
```

### ✅ Checklist de Entrega

- [ ] API key configurada (no en el repo)
- [ ] Modelos de datos completos
- [ ] Servicio API funcional
- [ ] Provider con estados
- [ ] 5 pantallas implementadas
- [ ] Manejo de errores
- [ ] Pull-to-refresh
- [ ] Favoritos persistentes
- [ ] Código documentado
- [ ] README del proyecto

---

📅 **Semana:** 06 | ⏱️ **Tiempo:** ~2.5 horas | 📊 **Peso:** 60%
