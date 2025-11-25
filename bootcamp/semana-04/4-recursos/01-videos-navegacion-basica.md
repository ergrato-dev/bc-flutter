# 🎬 Videos: Navegación Básica en Flutter

## 📋 Contenido

Videos tutoriales sobre Navigator, push, pop y navegación fundamental.

---

## 🎥 Videos Recomendados

### 1. Flutter Navigation Basics (Oficial)

| Campo | Valor |
|-------|-------|
| **Canal** | Flutter |
| **Duración** | 12:34 |
| **Idioma** | Inglés (subtítulos) |
| **Nivel** | 🟢 Principiante |
| **URL** | [youtube.com/watch?v=...](https://www.youtube.com/results?search_query=flutter+navigation+basics) |

**Contenido:**
- Introducción a Navigator
- Método push y pop
- MaterialPageRoute
- Ejemplo práctico

---

### 2. Navegación en Flutter - Curso Completo

| Campo | Valor |
|-------|-------|
| **Canal** | Fernando Herrera |
| **Duración** | 45:00 |
| **Idioma** | Español |
| **Nivel** | 🟢 Principiante |
| **URL** | [youtube.com/watch?v=...](https://www.youtube.com/results?search_query=flutter+navegacion+fernando+herrera) |

**Contenido:**
- Navigator.push explicado
- Navigator.pop con datos
- Transiciones entre pantallas
- Proyecto práctico

---

### 3. Push, Pop & Routes in Flutter

| Campo | Valor |
|-------|-------|
| **Canal** | The Net Ninja |
| **Duración** | 18:22 |
| **Idioma** | Inglés |
| **Nivel** | 🟢 Principiante |
| **URL** | [youtube.com/watch?v=...](https://www.youtube.com/results?search_query=flutter+push+pop+routes+net+ninja) |

**Contenido:**
- Stack de navegación
- Push y pop visualizado
- Pasar datos entre screens
- Recibir datos de vuelta

---

### 4. Flutter Navigation - MaterialPageRoute vs CupertinoPageRoute

| Campo | Valor |
|-------|-------|
| **Canal** | Reso Coder |
| **Duración** | 15:45 |
| **Idioma** | Inglés |
| **Nivel** | 🟡 Intermedio |
| **URL** | [youtube.com/watch?v=...](https://www.youtube.com/results?search_query=flutter+materialPageRoute+cupertinoPageRoute) |

**Contenido:**
- Diferencias Material vs Cupertino
- Animaciones de transición
- PageRouteBuilder personalizado
- Mejores prácticas

---

### 5. Navegación Flutter desde Cero

| Campo | Valor |
|-------|-------|
| **Canal** | Código Facilito |
| **Duración** | 32:10 |
| **Idioma** | Español |
| **Nivel** | 🟢 Principiante |
| **URL** | [youtube.com/watch?v=...](https://www.youtube.com/results?search_query=flutter+navegacion+codigo+facilito) |

**Contenido:**
- Conceptos fundamentales
- Navigator explicado
- Ejemplo app multi-pantalla
- Tips y trucos

---

## 📝 Notas de Estudio

### Conceptos Clave

```dart
// Push - Agregar pantalla al stack
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => NewScreen()),
);

// Pop - Remover pantalla del stack
Navigator.pop(context);

// Pop con datos
Navigator.pop(context, 'Datos de retorno');
```

### Checklist de Aprendizaje

- [ ] Entiendo el concepto de stack de navegación
- [ ] Puedo usar Navigator.push correctamente
- [ ] Puedo usar Navigator.pop con y sin datos
- [ ] Conozco la diferencia entre Material y Cupertino routes
- [ ] Puedo crear transiciones básicas

---

## 🔗 Recursos Adicionales

- [Navigation Cookbook](https://docs.flutter.dev/cookbook/navigation)
- [Navigator Class API](https://api.flutter.dev/flutter/widgets/Navigator-class.html)
