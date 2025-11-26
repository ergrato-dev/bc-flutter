# 🔨 Proyecto Semana 06: News Reader App

## 📱 Descripción

Desarrollarás una **aplicación de noticias** que consume la API de NewsAPI.org para mostrar titulares, permitir búsquedas y guardar favoritos.

**Tiempo estimado:** 4-5 horas

---

## 🎯 Objetivos del Proyecto

- ✅ Consumir una API REST real (NewsAPI)
- ✅ Implementar múltiples endpoints
- ✅ Manejar estados de carga/error/vacío
- ✅ Crear modelos de datos completos
- ✅ Implementar búsqueda con debounce
- ✅ Persistir favoritos localmente
- ✅ Aplicar arquitectura limpia

---

## 📋 Requisitos Funcionales

### RF01: Pantalla de Inicio (Home)
- [ ] Mostrar titulares principales de un país
- [ ] Primera noticia destacada (card grande)
- [ ] Lista de noticias con imagen, título y fuente
- [ ] Pull-to-refresh para actualizar
- [ ] Indicador de carga al inicio
- [ ] Mensaje de error con opción de reintentar

### RF02: Categorías
- [ ] Chips de categorías: General, Negocios, Tecnología, Deportes, Salud, Entretenimiento, Ciencia
- [ ] Al seleccionar una categoría, filtrar noticias
- [ ] Indicador visual de categoría seleccionada
- [ ] Scroll horizontal para categorías

### RF03: Búsqueda
- [ ] Campo de búsqueda en pantalla dedicada
- [ ] Búsqueda en tiempo real con debounce (500ms)
- [ ] Historial de búsquedas recientes
- [ ] Poder eliminar items del historial
- [ ] Cancelación de peticiones anteriores
- [ ] Mostrar cantidad de resultados

### RF04: Detalle de Noticia
- [ ] Imagen en hero/header
- [ ] Título completo
- [ ] Autor y fuente
- [ ] Fecha de publicación
- [ ] Descripción completa
- [ ] Botón "Leer artículo completo" (abre navegador)
- [ ] Botón de compartir
- [ ] Botón de favorito

### RF05: Favoritos
- [ ] Lista de noticias guardadas
- [ ] Persistencia local (SharedPreferences o Hive)
- [ ] Poder quitar de favoritos
- [ ] Estado vacío cuando no hay favoritos
- [ ] Ordenar por fecha de guardado

### RF06: Configuración (Opcional)
- [ ] Seleccionar país de noticias
- [ ] Tema claro/oscuro
- [ ] Limpiar cache de búsquedas

---

## 🏗️ Arquitectura Sugerida

```
lib/
├── main.dart
├── app.dart
├── core/
│   ├── config/
│   │   ├── api_keys.dart         # API key (no subir al repo)
│   │   └── constants.dart
│   ├── network/
│   │   ├── dio_client.dart       # Cliente HTTP configurado
│   │   └── interceptors/
│   │       ├── logging_interceptor.dart
│   │       └── error_interceptor.dart
│   ├── theme/
│   │   ├── app_theme.dart
│   │   └── app_colors.dart
│   └── utils/
│       ├── debouncer.dart
│       └── date_formatter.dart
├── models/
│   ├── article.dart
│   ├── source.dart
│   ├── news_response.dart
│   └── category.dart
├── services/
│   ├── news_service.dart         # Consumo de API
│   └── favorites_service.dart    # Persistencia local
├── providers/
│   ├── news_provider.dart
│   ├── search_provider.dart
│   └── favorites_provider.dart
├── screens/
│   ├── home/
│   │   ├── home_screen.dart
│   │   └── widgets/
│   │       ├── featured_card.dart
│   │       └── news_card.dart
│   ├── categories/
│   │   └── categories_screen.dart
│   ├── search/
│   │   └── search_screen.dart
│   ├── detail/
│   │   └── article_detail_screen.dart
│   ├── favorites/
│   │   └── favorites_screen.dart
│   └── settings/
│       └── settings_screen.dart
├── widgets/
│   ├── loading_widget.dart
│   ├── error_widget.dart
│   ├── empty_widget.dart
│   └── category_chip.dart
└── mocks/
    └── mock_articles.dart        # Para desarrollo sin API
```

---

## 🌐 API: NewsAPI.org

### Obtener API Key
1. Ir a [newsapi.org](https://newsapi.org/)
2. Registrarse (gratis)
3. Copiar la API key
4. **⚠️ NO subir la key al repositorio**

### Endpoints a Usar

#### Top Headlines
```
GET https://newsapi.org/v2/top-headlines
    ?country=us
    &category=technology
    &pageSize=20
    &apiKey=YOUR_KEY
```

#### Everything (Búsqueda)
```
GET https://newsapi.org/v2/everything
    ?q=flutter
    &sortBy=publishedAt
    &pageSize=20
    &apiKey=YOUR_KEY
```

### Parámetros

| Parámetro | Descripción | Valores |
|-----------|-------------|---------|
| country | País de noticias | us, mx, es, ar, co, etc. |
| category | Categoría | business, entertainment, health, science, sports, technology |
| q | Query de búsqueda | Texto libre |
| sortBy | Ordenar | relevancy, popularity, publishedAt |
| pageSize | Resultados por página | 1-100 (default 20) |
| page | Página | Número de página |

### Limitaciones (Plan Gratuito)
- 100 requests/día
- Solo noticias de últimos 30 días
- Sin acceso comercial

---

## 📱 Mockups de Referencia

Ver [GUIA-DISENO.md](./GUIA-DISENO.md) para wireframes y componentes.

---

## 🚀 Pasos de Desarrollo

### Fase 1: Setup (30 min)
1. Crear proyecto Flutter
2. Agregar dependencias
3. Configurar estructura de carpetas
4. Configurar API key de forma segura
5. Crear tema de la app

### Fase 2: Modelos y Servicios (45 min)
1. Crear modelos: Article, Source, NewsResponse
2. Crear NewsService con getTopHeadlines
3. Implementar manejo de errores
4. Crear datos mock para testing

### Fase 3: Home Screen (60 min)
1. Crear pantalla Home con FutureBuilder
2. Implementar FeaturedCard
3. Implementar NewsCard
4. Agregar pull-to-refresh
5. Estados: loading, error, vacío

### Fase 4: Categorías (45 min)
1. Crear CategoryChips
2. Implementar filtrado por categoría
3. Mantener selección visual

### Fase 5: Búsqueda (60 min)
1. Crear SearchScreen
2. Implementar Debouncer
3. Agregar historial con SharedPreferences
4. Cancelación de peticiones

### Fase 6: Detalle (30 min)
1. Crear ArticleDetailScreen
2. Hero animation con imagen
3. Botón abrir en navegador (url_launcher)
4. Botón compartir (share_plus)

### Fase 7: Favoritos (45 min)
1. Crear FavoritesProvider
2. Persistir con SharedPreferences
3. Crear FavoritesScreen
4. Agregar/quitar favoritos desde cualquier lugar

### Fase 8: Polish (30 min)
1. Navegación con BottomNavigationBar
2. Animaciones y transiciones
3. Responsive design
4. Testing básico

---

## 📦 Dependencias

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # HTTP y Networking
  dio: ^5.4.0
  
  # Estado
  provider: ^6.1.1
  
  # Persistencia
  shared_preferences: ^2.2.2
  
  # UI
  cached_network_image: ^3.3.1
  shimmer: ^3.0.0
  
  # Utilidades
  url_launcher: ^6.2.2
  share_plus: ^7.2.1
  intl: ^0.18.1
  
  # Opcional: Variables de entorno
  flutter_dotenv: ^5.1.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.1
```

---

## ✅ Criterios de Evaluación

### Funcionalidad (40%)
| Criterio | Puntos |
|----------|--------|
| Home con titulares | 8 |
| Categorías funcionales | 6 |
| Búsqueda con debounce | 8 |
| Detalle de noticia | 6 |
| Favoritos persistentes | 8 |
| Navegación | 4 |

### Calidad del Código (30%)
| Criterio | Puntos |
|----------|--------|
| Arquitectura clara | 8 |
| Modelos bien tipados | 6 |
| Manejo de errores | 8 |
| Código documentado | 4 |
| DRY (sin repetición) | 4 |

### UX/UI (20%)
| Criterio | Puntos |
|----------|--------|
| Estados de carga | 6 |
| Estados de error | 4 |
| Feedback al usuario | 4 |
| Diseño consistente | 6 |

### Extras (10%)
| Criterio | Puntos |
|----------|--------|
| Tema oscuro | 3 |
| Animaciones | 3 |
| Paginación | 4 |

---

## 🎯 Entregables

1. **Código fuente** en repositorio
2. **README** con instrucciones
3. **Capturas de pantalla** o video demo
4. **APK debug** (opcional)

---

## 🔗 Recursos

- [NewsAPI Documentation](https://newsapi.org/docs)
- [Dio Package](https://pub.dev/packages/dio)
- [cached_network_image](https://pub.dev/packages/cached_network_image)
- [Guía de Diseño](./GUIA-DISENO.md)
- [Ejemplos de Datos](./EJEMPLOS-DATOS.md)

---

## 💡 Tips

1. **Empieza con mocks** - Desarrolla la UI sin API key
2. **API key segura** - Usa .env o archivo ignorado
3. **Maneja el rate limit** - Cache respuestas
4. **Loading states** - Siempre dar feedback
5. **Imágenes broken** - Usar placeholder

---

📅 **Semana:** 06 | **Dedicación:** 4-5 horas
