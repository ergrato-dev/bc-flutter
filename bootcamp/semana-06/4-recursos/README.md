# 📖 Recursos - Semana 06

## 📚 Índice de Recursos

### 📋 Cheatsheets y Guías Rápidas

| # | Recurso | Descripción |
|---|---------|-------------|
| 01 | [Cheatsheet HTTP Methods](./01-cheatsheet-http-methods.md) | Métodos HTTP, códigos de estado, headers |
| 02 | [Guía Rápida http](./02-guia-rapida-http-package.md) | Uso del package http de Dart |
| 03 | [Guía Rápida Dio](./03-guia-rapida-dio.md) | Uso del package Dio con interceptores |
| 04 | [Patrones Error Handling](./04-patrones-error-handling.md) | Result, Either, AsyncValue patterns |
| 05 | [JSON Serialization](./05-json-serialization-patterns.md) | Manual, json_serializable, Freezed |

### 🛠️ Guías Prácticas

| # | Recurso | Descripción |
|---|---------|-------------|
| 06 | [APIs Gratuitas](./06-apis-gratuitas-practicar.md) | Lista de APIs para practicar |
| 07 | [Debugging Network](./07-debugging-network.md) | Herramientas y técnicas de debug |
| 08 | [Seguridad API Keys](./08-seguridad-api-keys.md) | Cómo proteger tus API keys |
| 09 | [Caching Strategies](./09-caching-strategies.md) | Estrategias de caché para APIs |
| 10 | [Mejores Prácticas REST](./10-mejores-practicas-rest.md) | Diseño y consumo de APIs REST |
| 11 | [Testing API Calls](./11-testing-api-calls.md) | Unit, Widget e Integration tests |
| 12 | [Referencias Oficiales](./12-referencias-oficiales.md) | Documentación y recursos externos |

---

## 🎯 Por Tema

### HTTP y REST
- [01 - Cheatsheet HTTP Methods](./01-cheatsheet-http-methods.md)
- [10 - Mejores Prácticas REST](./10-mejores-practicas-rest.md)

### Packages HTTP
- [02 - Guía Rápida http](./02-guia-rapida-http-package.md)
- [03 - Guía Rápida Dio](./03-guia-rapida-dio.md)

### JSON y Modelos
- [05 - JSON Serialization](./05-json-serialization-patterns.md)

### Error Handling
- [04 - Patrones Error Handling](./04-patrones-error-handling.md)

### Performance y Caché
- [09 - Caching Strategies](./09-caching-strategies.md)

### Seguridad
- [08 - Seguridad API Keys](./08-seguridad-api-keys.md)

### Testing y Debug
- [07 - Debugging Network](./07-debugging-network.md)
- [11 - Testing API Calls](./11-testing-api-calls.md)

### APIs para Practicar
- [06 - APIs Gratuitas](./06-apis-gratuitas-practicar.md)

---

## 📦 Packages Recomendados

```yaml
dependencies:
  # HTTP
  http: ^1.1.0
  dio: ^5.4.0
  
  # Serialización
  json_annotation: ^4.8.1
  freezed_annotation: ^2.4.1
  
  # Caché
  shared_preferences: ^2.2.2
  hive: ^2.2.3
  dio_cache_interceptor: ^3.4.4
  
  # Conectividad
  connectivity_plus: ^5.0.2

dev_dependencies:
  build_runner: ^2.4.8
  json_serializable: ^6.7.1
  freezed: ^2.4.6
  mockito: ^5.4.4
```

---

📅 **Semana 06** | Consumo de APIs y HTTP
