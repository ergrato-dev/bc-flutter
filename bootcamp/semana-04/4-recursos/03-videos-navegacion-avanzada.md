# 🎬 Videos: Navegación Avanzada en Flutter

## 📋 Contenido

Videos sobre BottomNavigationBar, Drawer, TabBar y navegación anidada.

---

## 🎥 Videos Recomendados

### 1. BottomNavigationBar Tutorial

| Campo        | Valor                                                                                                        |
| ------------ | ------------------------------------------------------------------------------------------------------------ |
| **Canal**    | Flutter                                                                                                      |
| **Duración** | 15:30                                                                                                        |
| **Idioma**   | Inglés (subtítulos)                                                                                          |
| **Nivel**    | 🟡 Intermedio                                                                                                |
| **URL**      | [youtube.com/watch?v=...](https://www.youtube.com/results?search_query=flutter+bottomnavigationbar+tutorial) |

**Contenido:**

- BottomNavigationBar básico
- Cambio de páginas
- Estilos y personalización
- Material 3 NavigationBar

---

### 2. IndexedStack - Preservar Estado

| Campo        | Valor                                                                                                       |
| ------------ | ----------------------------------------------------------------------------------------------------------- |
| **Canal**    | Reso Coder                                                                                                  |
| **Duración** | 12:45                                                                                                       |
| **Idioma**   | Inglés                                                                                                      |
| **Nivel**    | 🟡 Intermedio                                                                                               |
| **URL**      | [youtube.com/watch?v=...](https://www.youtube.com/results?search_query=flutter+indexedstack+preserve+state) |

**Contenido:**

- Problema de pérdida de estado
- IndexedStack explicado
- Comparación con PageView
- Performance considerations

---

### 3. Drawer Navigation Flutter

| Campo        | Valor                                                                                                      |
| ------------ | ---------------------------------------------------------------------------------------------------------- |
| **Canal**    | Johannes Milke                                                                                             |
| **Duración** | 20:15                                                                                                      |
| **Idioma**   | Inglés                                                                                                     |
| **Nivel**    | 🟡 Intermedio                                                                                              |
| **URL**      | [youtube.com/watch?v=...](https://www.youtube.com/results?search_query=flutter+drawer+navigation+tutorial) |

**Contenido:**

- Drawer widget
- UserAccountsDrawerHeader
- NavigationDrawer (Material 3)
- Integración con Bottom Nav

---

### 4. TabBar y TabBarView

| Campo        | Valor                                                                                                      |
| ------------ | ---------------------------------------------------------------------------------------------------------- |
| **Canal**    | The Flutter Way                                                                                            |
| **Duración** | 18:00                                                                                                      |
| **Idioma**   | Inglés                                                                                                     |
| **Nivel**    | 🟡 Intermedio                                                                                              |
| **URL**      | [youtube.com/watch?v=...](https://www.youtube.com/results?search_query=flutter+tabbar+tabbarview+tutorial) |

**Contenido:**

- DefaultTabController
- TabBar personalizado
- TabBarView con contenido
- Tabs dinámicos

---

### 5. Nested Navigation Flutter

| Campo        | Valor                                                                                                      |
| ------------ | ---------------------------------------------------------------------------------------------------------- |
| **Canal**    | Flutter Explained                                                                                          |
| **Duración** | 25:30                                                                                                      |
| **Idioma**   | Inglés                                                                                                     |
| **Nivel**    | 🔴 Avanzado                                                                                                |
| **URL**      | [youtube.com/watch?v=...](https://www.youtube.com/results?search_query=flutter+nested+navigation+tutorial) |

**Contenido:**

- Navigator por tab
- GlobalKey<NavigatorState>
- Manejo de back button
- WillPopScope / PopScope

---

### 6. Navegación Avanzada Flutter - Español

| Campo        | Valor                                                                                                                |
| ------------ | -------------------------------------------------------------------------------------------------------------------- |
| **Canal**    | Fernando Herrera                                                                                                     |
| **Duración** | 55:00                                                                                                                |
| **Idioma**   | Español                                                                                                              |
| **Nivel**    | 🔴 Avanzado                                                                                                          |
| **URL**      | [youtube.com/watch?v=...](https://www.youtube.com/results?search_query=flutter+navegacion+avanzada+fernando+herrera) |

**Contenido:**

- Bottom Navigation completo
- Drawer con estado
- Combinación de patrones
- Proyecto real

---

## 📝 Notas de Estudio

### BottomNavigationBar

```dart
Scaffold(
  body: IndexedStack(
    index: _currentIndex,
    children: _pages,
  ),
  bottomNavigationBar: BottomNavigationBar(
    currentIndex: _currentIndex,
    onTap: (index) => setState(() => _currentIndex = index),
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
    ],
  ),
);
```

### Drawer

```dart
Scaffold(
  drawer: Drawer(
    child: ListView(
      children: [
        UserAccountsDrawerHeader(
          accountName: Text('Usuario'),
          accountEmail: Text('email@example.com'),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Inicio'),
          onTap: () => Navigator.pushNamed(context, '/'),
        ),
      ],
    ),
  ),
);
```

### Checklist de Aprendizaje

- [ ] Implemento BottomNavigationBar funcional
- [ ] Uso IndexedStack para preservar estado
- [ ] Creo Drawer con header de usuario
- [ ] Implemento TabBar con DefaultTabController
- [ ] Manejo navegación anidada
- [ ] Controlo el back button correctamente

---

## 🔗 Recursos Adicionales

- [BottomNavigationBar Class](https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html)
- [Drawer Class](https://api.flutter.dev/flutter/material/Drawer-class.html)
- [TabBar Class](https://api.flutter.dev/flutter/material/TabBar-class.html)
