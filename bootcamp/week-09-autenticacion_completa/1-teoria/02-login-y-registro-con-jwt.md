# Login y Registro con JWT

## 🎯 Objetivos

Al finalizar este archivo, comprenderás:

- Cómo hacer login vía `POST` y extraer el token de la respuesta
- Cómo modelar el resultado del login como un repository (mismo patrón de semana 6)
- Cómo traducir errores de credenciales inválidas

## 📋 Conceptos Clave

### 1. El endpoint de login

```dart
final response = await dio.post('/auth/login', data: {
  'username': 'emilys',
  'password': 'emilyspass',
});

// response.data:
// {
//   "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
//   "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
//   "id": 1, "username": "emilys", "email": "emily.johnson@x.dummyjson.com", ...
// }
```

`dummyjson.com/auth/login` retorna el JWT en el campo `accessToken`. Un login fallido (usuario o
contraseña incorrectos) responde `400` con un mensaje de error en el body — se traduce igual que
cualquier `DioException` (semana 6).

### 2. AuthRepository — mismo patrón que ItemsRepository

```dart
abstract class AuthRepository {
  Future<String> login(String username, String password);
}

class DioAuthRepository implements AuthRepository {
  DioAuthRepository(this._dio);

  final Dio _dio;

  @override
  Future<String> login(String username, String password) async {
    try {
      final response = await _dio.post('/auth/login', data: {
        'username': username,
        'password': password,
      });
      return response.data['accessToken'] as String;
    } on DioException catch (e) {
      throw Exception(_messageFor(e));
    }
  }

  String _messageFor(DioException e) {
    if (e.response?.statusCode == 400) return 'Usuario o contraseña incorrectos';
    if (e.type == DioExceptionType.connectionError) return 'Sin conexión a internet';
    return 'No se pudo iniciar sesión';
  }
}
```

Mismo `abstract class` + implementación con Dio + traducción de errores que
`ItemsRepository`/`DioItemsRepository` de semana 6 — la autenticación no introduce un patrón
nuevo de acceso a datos, reutiliza el que ya conoces.

### 3. Por qué el login usa un Dio distinto al de tus datos de dominio

El proyecto de este bootcamp usa `jsonplaceholder.typicode.com` para los elementos de tu
dominio, y `dummyjson.com` para login — dos APIs distintas, con dos `baseUrl` distintos. Por eso
esta semana agrega un **segundo provider de Dio** (`authDioProvider`), independiente del
`dioProvider` que ya conoces:

```dart
@Riverpod(keepAlive: true)
Dio authDio(Ref ref) {
  return Dio(BaseOptions(baseUrl: 'https://dummyjson.com'));
}
```

En un proyecto real, ambos endpoints normalmente viven en el mismo backend (un solo `baseUrl`)
— esta separación es solo para poder practicar login sin depender de que tu propio backend de
prácticas lo implemente.

### 4. Registro (signup)

`dummyjson.com` no expone un endpoint de registro real (solo login contra usuarios fijos de
prueba) — en un backend propio, el patrón sería idéntico: un `POST /auth/register` que retorna
el mismo tipo de token, tratado igual que el login. No lo implementarás esta semana, pero ahora
sabes que sería el mismo `AuthRepository` con un método más.

## ✅ Checklist de Verificación

- [ ] Sé hacer un `POST` de login y extraer el token de la respuesta
- [ ] Sé modelar `AuthRepository` con el mismo patrón de `ItemsRepository`
- [ ] Sé por qué el login usa un `Dio` distinto al de los datos de dominio
- [ ] Sé por qué "registro" seguiría el mismo patrón que login

## 📚 Próximo paso

[flutter_secure_storage — Persistencia Segura de Tokens →](03-flutter-secure-storage-tokens.md)
