# 🔒 Política de Seguridad

## Versiones Soportadas

| Versión | Soportada |
| ------- | --------- |
| main    | ✅        |

## Reportar una Vulnerabilidad

La seguridad de este proyecto es importante para nosotros. Si descubres una vulnerabilidad de seguridad, te pedimos que la reportes de manera responsable.

### ⚠️ NO hacer público el reporte

Por favor, **NO** abras un issue público para reportar vulnerabilidades de seguridad.

### 📧 Cómo Reportar

1. **Abre un Security Advisory privado** en GitHub:
   - Ve a la pestaña "Security" del repositorio
   - Haz clic en "Report a vulnerability"
   - Completa el formulario con los detalles

2. **Incluye en tu reporte**:
   - Descripción detallada de la vulnerabilidad
   - Pasos para reproducir el problema
   - Impacto potencial
   - Sugerencias de solución (si las tienes)

### ⏱️ Tiempo de Respuesta

- **Confirmación inicial**: 48 horas
- **Evaluación**: 7 días
- **Resolución**: Dependiendo de la severidad

### 🎁 Reconocimiento

Agradecemos a todos los investigadores de seguridad que reportan vulnerabilidades de manera responsable. Tu nombre será incluido en nuestros agradecimientos (si lo deseas).

## Mejores Prácticas de Seguridad

Este bootcamp enseña las siguientes prácticas de seguridad:

### Validación de Datos

```dart
// ✅ Validar entradas de formularios explícitamente
String? validateEmail(String? value) {
  if (value == null || value.isEmpty) return 'El email es requerido';
  final regex = RegExp(r'^[\w.+-]+@[\w-]+\.[a-zA-Z]{2,}$');
  if (!regex.hasMatch(value)) return 'Email inválido';
  return null;
}
```

### Almacenamiento Seguro

```dart
// ✅ Tokens y credenciales en flutter_secure_storage (Keychain/Keystore)
final storage = FlutterSecureStorage();
await storage.write(key: 'access_token', value: token);

// ❌ NUNCA guardar tokens/credenciales en SharedPreferences (texto plano)
```

### Variables de Entorno

```dart
// ✅ Nunca hardcodear secretos — usar flutter_dotenv o --dart-define
final apiKey = const String.fromEnvironment('API_KEY');

// ❌ NUNCA: final apiKey = "sk-live-abc123...";
```

### Inyección SQL

```dart
// ✅ Usar queries parametrizadas (sqflite / drift) — evita SQL injection
final result = await db.query('users', where: 'email = ?', whereArgs: [email]);

// ❌ NUNCA construir SQL con interpolación de strings
// await db.rawQuery("SELECT * FROM users WHERE email = '$email'");
```

### Comunicación con APIs

```dart
// ✅ HTTPS siempre, certificate pinning en apps que manejan datos sensibles
// ✅ Nunca loguear tokens, contraseñas ni datos personales (usar solo datos sintéticos en dev)
```

## Dependencias

Mantenemos las dependencias actualizadas para evitar vulnerabilidades conocidas. Usamos:

- Versiones exactas (`pubspec.yaml` sin `^`/`>=` en dependencias críticas) para reproducibilidad
- `flutter pub outdated` y Dependabot para alertas automáticas
- Auditorías regulares de seguridad

---

Gracias por ayudar a mantener este proyecto seguro. 🛡️
