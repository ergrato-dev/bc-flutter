# 📝 Artículos: Navigator en Flutter

## 📋 Contenido

Artículos detallados sobre Navigator 1.0, 2.0 y conceptos avanzados.

---

## 📰 Artículos Recomendados

### 1. Understanding Navigator 1.0

| Campo              | Valor                                                                                                             |
| ------------------ | ----------------------------------------------------------------------------------------------------------------- |
| **Autor**          | Flutter Team                                                                                                      |
| **Fuente**         | Medium / flutter.dev                                                                                              |
| **Tiempo lectura** | 15 min                                                                                                            |
| **Nivel**          | 🟢 Principiante                                                                                                   |
| **URL**            | [medium.com/flutter](https://medium.com/flutter/learning-flutters-new-navigation-and-routing-system-7c9068155ade) |

**Resumen:**

- Cómo funciona el Navigator stack
- Métodos push, pop, pushReplacement
- MaterialPageRoute explicado
- Limitaciones de Navigator 1.0

---

### 2. Navigator 2.0 Explained

| Campo              | Valor                                                                                                             |
| ------------------ | ----------------------------------------------------------------------------------------------------------------- |
| **Autor**          | John Ryan (Flutter Team)                                                                                          |
| **Fuente**         | Medium                                                                                                            |
| **Tiempo lectura** | 25 min                                                                                                            |
| **Nivel**          | 🔴 Avanzado                                                                                                       |
| **URL**            | [medium.com/flutter](https://medium.com/flutter/learning-flutters-new-navigation-and-routing-system-7c9068155ade) |

**Resumen:**

- Router widget
- RouteInformationParser
- RouterDelegate
- Deep linking nativo
- Declarative vs Imperative

---

### 3. Flutter Navigation: The Complete Guide

| Campo              | Valor                                                              |
| ------------------ | ------------------------------------------------------------------ |
| **Autor**          | Reso Coder                                                         |
| **Fuente**         | resocoder.com                                                      |
| **Tiempo lectura** | 30 min                                                             |
| **Nivel**          | 🟡 Intermedio                                                      |
| **URL**            | [resocoder.com](https://resocoder.com/category/tutorials/flutter/) |

**Resumen:**

- Navigator 1.0 en profundidad
- Named routes best practices
- Passing arguments correctly
- Common mistakes to avoid

---

### 4. Deep Linking in Flutter

| Campo              | Valor                                              |
| ------------------ | -------------------------------------------------- |
| **Autor**          | Suragch                                            |
| **Fuente**         | Medium                                             |
| **Tiempo lectura** | 20 min                                             |
| **Nivel**          | 🔴 Avanzado                                        |
| **URL**            | [medium.com](https://medium.com/flutter-community) |

**Resumen:**

- Qué es deep linking
- Configuración Android/iOS
- Manejo de URIs
- Testing deep links

---

### 5. Navegación Declarativa vs Imperativa

| Campo              | Valor                                      |
| ------------------ | ------------------------------------------ |
| **Autor**          | Varios                                     |
| **Fuente**         | Dev.to                                     |
| **Tiempo lectura** | 12 min                                     |
| **Nivel**          | 🟡 Intermedio                              |
| **URL**            | [dev.to/flutter](https://dev.to/t/flutter) |

**Resumen:**

- Diferencias conceptuales
- Cuándo usar cada enfoque
- Pros y contras
- Ejemplos prácticos

---

## 📊 Comparativa Navigator 1.0 vs 2.0

| Aspecto      | Navigator 1.0 | Navigator 2.0       |
| ------------ | ------------- | ------------------- |
| Estilo       | Imperativo    | Declarativo         |
| Deep Linking | Manual        | Integrado           |
| Complejidad  | Baja          | Alta                |
| Control      | Limitado      | Completo            |
| URL Sync     | No            | Sí                  |
| Web Support  | Básico        | Completo            |
| Caso de uso  | Apps simples  | Apps complejas, web |

---

## 📝 Código de Ejemplo

### Navigator 1.0 (Imperativo)

```dart
// Push
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => DetailScreen()),
);

// Pop
Navigator.pop(context);

// Named route
Navigator.pushNamed(context, '/detail', arguments: {'id': 123});
```

### Navigator 2.0 (Declarativo)

```dart
// Configuración
MaterialApp.router(
  routerDelegate: MyRouterDelegate(),
  routeInformationParser: MyRouteInformationParser(),
);

// El router decide qué mostrar según el estado
class MyRouterDelegate extends RouterDelegate<MyRoutePath> {
  // ...implementación
}
```

---

## 🔗 Enlaces Adicionales

### Documentación Oficial

- [Navigator class](https://api.flutter.dev/flutter/widgets/Navigator-class.html)
- [Router class](https://api.flutter.dev/flutter/widgets/Router-class.html)
- [Navigation cookbook](https://docs.flutter.dev/cookbook/navigation)

### Artículos Complementarios

- Flutter Navigation Patterns
- When to use Navigator 2.0
- Migration guide 1.0 to 2.0

---

## ✅ Checklist de Lectura

- [ ] Entiendo Navigator 1.0 completamente
- [ ] Conozco las limitaciones de Navigator 1.0
- [ ] Comprendo conceptos de Navigator 2.0
- [ ] Sé cuándo usar cada versión
- [ ] Entiendo deep linking básico
