# Ejercicio 01 — Login con JWT

> Construirás un formulario de login que hace `POST` a `dummyjson.com/auth/login` y muestra el
> token recibido (o el error), descomentando código paso a paso.

## 🎯 Objetivos

- Hacer `POST` de login con Dio y extraer el `accessToken` de la respuesta
- Traducir un login fallido (`400`) a un mensaje propio
- Mostrar el resultado (token o error) con feedback reactivo

## 📋 Requisitos

- SDK de Flutter local configurado con emulador/simulador corriendo
- Conexión a internet (usa la API pública `dummyjson.com`)

## 🚀 Cómo ejecutar

```bash
cd starter
flutter pub get
flutter run
```

---

## Paso 1: FormBuilder con usuario y contraseña

```dart
final _formKey = GlobalKey<FormBuilderState>();

FormBuilder(
  key: _formKey,
  child: Column(
    children: [
      FormBuilderTextField(
        name: 'username',
        decoration: const InputDecoration(labelText: 'Usuario'),
        validator: FormBuilderValidators.required(errorText: 'El usuario es obligatorio'),
      ),
      FormBuilderTextField(
        name: 'password',
        decoration: const InputDecoration(labelText: 'Contraseña'),
        obscureText: true,
        validator: FormBuilderValidators.required(errorText: 'La contraseña es obligatoria'),
      ),
    ],
  ),
)
```

**Abre `starter/lib/main.dart`** y descomenta la sección `PASO 1`.

> 💡 Usa las credenciales de prueba de `dummyjson.com`: usuario `emilys`, contraseña
> `emilyspass`.

---

## Paso 2: POST de login con Dio

```dart
Future<String> login(String username, String password) async {
  try {
    final response = await Dio(BaseOptions(baseUrl: 'https://dummyjson.com')).post(
      '/auth/login',
      data: {'username': username, 'password': password},
    );
    return response.data['accessToken'] as String;
  } on DioException catch (e) {
    if (e.response?.statusCode == 400) {
      throw Exception('Usuario o contraseña incorrectos');
    }
    throw Exception('No se pudo iniciar sesión');
  }
}
```

**Descomenta la sección `PASO 2`** — esta función vive fuera de cualquier widget, la conectarás
en el paso 3.

---

## Paso 3: conectar el botón y mostrar el resultado

```dart
onPressed: () async {
  if (_formKey.currentState!.saveAndValidate()) {
    final values = _formKey.currentState!.value;
    try {
      final token = await login(values['username'] as String, values['password'] as String);
      setState(() => _result = 'Token recibido: ${token.substring(0, 20)}...');
    } catch (e) {
      setState(() => _result = '$e');
    }
  }
},
```

**Descomenta la sección `PASO 3`** y agrega el botón al `Column` del `FormBuilder`, junto con un
`Text(_result)` debajo para mostrar el resultado.

✅ **Verifica**: con `emilys`/`emilyspass`, debe mostrarse un fragmento del token. Con una
contraseña incorrecta, debe mostrarse "Usuario o contraseña incorrectos" — nunca el error crudo
de Dio.

---

## ✅ Resultado final

Un login funcional contra una API JWT real — la base que extenderás en el ejercicio 02
guardando el token de forma segura, en vez de solo mostrarlo en pantalla.
