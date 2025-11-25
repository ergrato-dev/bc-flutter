# 🎬 Videos: Rutas Nombradas en Flutter

## 📋 Contenido

Videos sobre named routes, argumentos y gestión centralizada de rutas.

---

## 🎥 Videos Recomendados

### 1. Named Routes in Flutter

| Campo        | Valor                                                                                                 |
| ------------ | ----------------------------------------------------------------------------------------------------- |
| **Canal**    | Flutter                                                                                               |
| **Duración** | 10:15                                                                                                 |
| **Idioma**   | Inglés (subtítulos)                                                                                   |
| **Nivel**    | 🟡 Intermedio                                                                                         |
| **URL**      | [youtube.com/watch?v=...](https://www.youtube.com/results?search_query=flutter+named+routes+official) |

**Contenido:**

- Definir rutas en MaterialApp
- pushNamed y popNamed
- Organización de rutas
- Ventajas vs navegación directa

---

### 2. Rutas Nombradas Flutter - Tutorial Completo

| Campo        | Valor                                                                                                            |
| ------------ | ---------------------------------------------------------------------------------------------------------------- |
| **Canal**    | Fernando Herrera                                                                                                 |
| **Duración** | 28:30                                                                                                            |
| **Idioma**   | Español                                                                                                          |
| **Nivel**    | 🟡 Intermedio                                                                                                    |
| **URL**      | [youtube.com/watch?v=...](https://www.youtube.com/results?search_query=flutter+rutas+nombradas+fernando+herrera) |

**Contenido:**

- Configuración de routes map
- Clase AppRoutes centralizada
- Pasar argumentos con pushNamed
- onGenerateRoute explicado

---

### 3. Pass Arguments to Named Routes

| Campo        | Valor                                                                                                       |
| ------------ | ----------------------------------------------------------------------------------------------------------- |
| **Canal**    | The Net Ninja                                                                                               |
| **Duración** | 14:20                                                                                                       |
| **Idioma**   | Inglés                                                                                                      |
| **Nivel**    | 🟡 Intermedio                                                                                               |
| **URL**      | [youtube.com/watch?v=...](https://www.youtube.com/results?search_query=flutter+pass+arguments+named+routes) |

**Contenido:**

- RouteSettings y arguments
- Extraer argumentos en destino
- Clases de argumentos tipadas
- Manejo de errores

---

### 4. onGenerateRoute Tutorial

| Campo        | Valor                                                                                                    |
| ------------ | -------------------------------------------------------------------------------------------------------- |
| **Canal**    | Reso Coder                                                                                               |
| **Duración** | 22:45                                                                                                    |
| **Idioma**   | Inglés                                                                                                   |
| **Nivel**    | 🟡 Intermedio                                                                                            |
| **URL**      | [youtube.com/watch?v=...](https://www.youtube.com/results?search_query=flutter+onGenerateRoute+tutorial) |

**Contenido:**

- onGenerateRoute vs routes map
- Routing dinámico
- Validación de argumentos
- Pantallas de error (404)

---

### 5. Flutter Routes Best Practices

| Campo        | Valor                                                                                                 |
| ------------ | ----------------------------------------------------------------------------------------------------- |
| **Canal**    | Flutter Mapp                                                                                          |
| **Duración** | 35:00                                                                                                 |
| **Idioma**   | Inglés                                                                                                |
| **Nivel**    | 🔴 Avanzado                                                                                           |
| **URL**      | [youtube.com/watch?v=...](https://www.youtube.com/results?search_query=flutter+routes+best+practices) |

**Contenido:**

- Arquitectura de rutas escalable
- Route generators
- Deep linking básico
- Testing de navegación

---

## 📝 Notas de Estudio

### Configuración de Rutas

```dart
// En MaterialApp
MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => HomeScreen(),
    '/details': (context) => DetailsScreen(),
    '/settings': (context) => SettingsScreen(),
  },
);

// Navegación
Navigator.pushNamed(context, '/details');

// Con argumentos
Navigator.pushNamed(
  context,
  '/details',
  arguments: {'id': '123', 'title': 'Item'},
);
```

### Checklist de Aprendizaje

- [ ] Configuro rutas nombradas en MaterialApp
- [ ] Uso pushNamed correctamente
- [ ] Paso argumentos con named routes
- [ ] Implemento onGenerateRoute
- [ ] Creo clase AppRoutes centralizada
- [ ] Manejo rutas no encontradas

---

## 🔗 Recursos Adicionales

- [Named Routes Documentation](https://docs.flutter.dev/cookbook/navigation/named-routes)
- [Pass Arguments to Named Route](https://docs.flutter.dev/cookbook/navigation/navigate-with-arguments)
