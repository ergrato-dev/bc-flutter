# 🌐 APIs Gratuitas para Practicar

## 🎯 Sin Autenticación (Ideales para Empezar)

### JSONPlaceholder
**URL:** https://jsonplaceholder.typicode.com

Fake REST API perfecta para prototipos.

```
GET /posts        → 100 posts
GET /users        → 10 usuarios
GET /comments     → 500 comentarios
GET /albums       → 100 álbumes
GET /photos       → 5000 fotos
GET /todos        → 200 todos
```

```dart
// Ejemplo
final response = await http.get(
  Uri.parse('https://jsonplaceholder.typicode.com/posts'),
);
```

---

### ReqRes
**URL:** https://reqres.in

API para testing con respuestas realistas.

```
GET  /api/users?page=1      → Lista paginada
GET  /api/users/1           → Usuario específico
POST /api/users             → Crear usuario
PUT  /api/users/1           → Actualizar
DELETE /api/users/1         → Eliminar
POST /api/login             → Simular login
```

---

### Dog CEO
**URL:** https://dog.ceo/dog-api

API de imágenes de perros aleatorias.

```
GET /breeds/list/all                → Todas las razas
GET /breed/hound/images             → Imágenes de una raza
GET /breed/hound/list               → Sub-razas
GET /breeds/image/random            → Imagen aleatoria
GET /breeds/image/random/3          → 3 imágenes aleatorias
```

---

### The Cat API
**URL:** https://thecatapi.com

Similar a Dog CEO pero con gatos.

```
GET /v1/images/search?limit=10      → Imágenes aleatorias
GET /v1/breeds                      → Lista de razas
GET /v1/images/search?breed_id=beng → Por raza
```

---

### PokéAPI
**URL:** https://pokeapi.co

Datos de Pokémon completos.

```
GET /api/v2/pokemon?limit=20        → Lista de pokémon
GET /api/v2/pokemon/pikachu         → Pokémon específico
GET /api/v2/type/electric           → Por tipo
GET /api/v2/ability/static          → Habilidades
```

---

### Open Trivia Database
**URL:** https://opentdb.com

API de preguntas trivia.

```
GET /api.php?amount=10              → 10 preguntas aleatorias
GET /api.php?amount=10&category=18  → Por categoría (Computers)
GET /api.php?amount=10&difficulty=easy → Por dificultad
GET /api_category.php               → Lista de categorías
```

---

### REST Countries
**URL:** https://restcountries.com

Información de países.

```
GET /v3.1/all                       → Todos los países
GET /v3.1/name/spain                → Por nombre
GET /v3.1/alpha/ESP                 → Por código
GET /v3.1/region/europe             → Por región
```

---

## 🔑 Requieren API Key (Gratuitas)

### NewsAPI
**URL:** https://newsapi.org

Noticias de todo el mundo.

```
GET /v2/top-headlines?country=us&apiKey=KEY
GET /v2/everything?q=flutter&apiKey=KEY
```

**Límite gratuito:** 100 requests/día

---

### OpenWeatherMap
**URL:** https://openweathermap.org/api

Datos del clima.

```
GET /data/2.5/weather?q=Madrid&appid=KEY
GET /data/2.5/forecast?q=Madrid&appid=KEY
```

**Límite gratuito:** 1000 requests/día

---

### The Movie Database (TMDB)
**URL:** https://www.themoviedb.org

Películas y series.

```
GET /3/movie/popular?api_key=KEY
GET /3/movie/550?api_key=KEY
GET /3/search/movie?query=batman&api_key=KEY
```

**Límite gratuito:** Ilimitado (rate limited)

---

### Unsplash
**URL:** https://unsplash.com/developers

Fotos de alta calidad.

```
GET /photos?client_id=KEY
GET /photos/random?client_id=KEY
GET /search/photos?query=nature&client_id=KEY
```

**Límite gratuito:** 50 requests/hora

---

### CoinGecko
**URL:** https://www.coingecko.com/api

Criptomonedas (sin API key).

```
GET /api/v3/coins/list
GET /api/v3/coins/bitcoin
GET /api/v3/coins/markets?vs_currency=usd
GET /api/v3/simple/price?ids=bitcoin&vs_currencies=usd
```

---

### NASA APIs
**URL:** https://api.nasa.gov

Datos espaciales.

```
GET /planetary/apod?api_key=KEY     → Foto del día
GET /mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=KEY
```

**Límite gratuito:** 1000 requests/hora (DEMO_KEY disponible)

---

## 📊 Comparativa

| API | Auth | Rate Limit | Ideal Para |
|-----|------|------------|------------|
| JSONPlaceholder | ❌ | Ilimitado | CRUD básico |
| ReqRes | ❌ | Ilimitado | Testing auth |
| Dog/Cat API | ❌ | Alto | Imágenes |
| PokéAPI | ❌ | Alto | Datos complejos |
| NewsAPI | ✅ Key | 100/día | Proyecto real |
| TMDB | ✅ Key | Ilimitado | Películas |
| OpenWeather | ✅ Key | 1000/día | Clima |

---

## 🎯 Recomendación por Nivel

### Principiante
1. JSONPlaceholder - CRUD básico
2. Dog CEO - Imágenes simples
3. REST Countries - Sin auth

### Intermedio
1. PokéAPI - Datos anidados
2. ReqRes - Autenticación
3. Open Trivia - Filtros y paginación

### Avanzado
1. NewsAPI - Proyecto real
2. TMDB - Búsqueda avanzada
3. OpenWeatherMap - Caché y geolocalización

---

## 💡 Tips

```dart
// Para desarrollo, usar mocks si alcanzas el límite
const useMocks = bool.fromEnvironment('USE_MOCKS', defaultValue: false);

Future<List<Article>> getArticles() async {
  if (useMocks) {
    return MockData.articles;
  }
  // Llamada real a la API
}
```

---

📅 **Semana 06** | Consumo de APIs y HTTP
