# 🐳 Configuración Docker para BC-Flutter

Este documento especifica cómo y para qué se usa Docker en el bootcamp.

## 🚀 ¿Por qué Docker?

1. **Entorno consistente**: `flutter analyze`/`flutter test`/`flutter build` corren igual en
   cualquier máquina, sin importar qué versión de Flutter tenga instalada cada estudiante.
2. **Paridad con CI**: el mismo `docker-compose.yml` que usa el estudiante en su máquina es el
   que corre en GitHub Actions (semana 18).
3. **Sin conflictos de versiones**: no hace falta gestionar múltiples SDKs de Flutter con FVM
   para cumplir con la versión pineada del curso.
4. **Reproducible**: el mismo código se analiza/testea igual en cualquier máquina.

## ⚠️ Docker y desarrollo visual — la limitación que hay que entender

**Docker NO reemplaza al SDK local de Flutter.** Esta es la diferencia clave frente a bootcamps
backend (como `bc-fastapi`), donde "todo vía Docker" funciona sin matices porque el resultado es
un servidor HTTP expuesto en un puerto.

Una app Flutter necesita **renderizar** en un emulador Android, un simulador iOS o un
dispositivo físico. Un contenedor Linux no tiene GUI:

- **`flutter run` en un emulador/simulador**: requiere el SDK de Flutter instalado en el host,
  conectado a Android Studio (emulador) o Xcode (simulador, solo macOS). Esto **no es opcional**
  y Docker no lo resuelve — ni siquiera con Docker Desktop en macOS/Windows.
- **`flutter analyze` / `flutter test` / `flutter build apk` / `flutter build appbundle`**: son
  operaciones **headless** (sin GUI). Estas sí corren perfectamente dentro de Docker, y son las
  que usamos como entorno oficial reproducible.
- **`flutter build ipa`** (compilación para iOS): requiere siempre un host **macOS con Xcode**.
  Esto es una limitación de Apple, no de Docker — ni el SDK local en Linux/Windows lo resuelve.

**En resumen**: usa Docker para validar tu código (`analyze`/`test`/`build`) de forma
reproducible; usa el SDK local + emulador/simulador para *ver* tu app funcionando.

## 📋 Requisitos Previos

### Instalar Docker

**Fedora/RHEL:**
```bash
sudo dnf install docker docker-compose-plugin
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
# Cerrar sesión y volver a entrar
```

**Ubuntu/Debian:**
```bash
sudo apt update
sudo apt install docker.io docker-compose-v2
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
# Cerrar sesión y volver a entrar
```

**macOS:**
```bash
# Docker Desktop desde https://docker.com, o:
brew install --cask docker
```

**Windows:**
```bash
# Instalar Docker Desktop desde https://docker.com
# Requiere WSL2 habilitado
```

### Verificar Instalación

```bash
docker --version        # Docker version 27.x.x
docker compose version  # Docker Compose version v2.31.x
docker run --rm hello-world
```

## 📁 Estructura de Archivos Docker

Cada proyecto semanal (`3-proyecto/starter/`) incluye su propia imagen:

```
3-proyecto/starter/
├── Dockerfile           # Basado en ghcr.io/cirruslabs/flutter:stable
├── docker-compose.yml   # Servicio único: flutter (analyze/test/build)
├── .env.example         # Template de variables de entorno (si aplica)
├── pubspec.yaml
└── lib/
```

La plantilla raíz (`Dockerfile`/`docker-compose.yml` en la raíz del repo) es la base que se
copia a cada `3-proyecto/starter/` al generar contenido de una semana nueva.

## 🔧 Comandos Esenciales

```bash
# Analizar código estático
docker compose run --rm flutter flutter analyze

# Correr tests
docker compose run --rm flutter flutter test

# Compilar APK (headless, no requiere emulador)
docker compose run --rm flutter flutter build apk

# Abrir shell en el contenedor
docker compose run --rm flutter bash

# Instalar/actualizar dependencias tras editar pubspec.yaml
docker compose run --rm flutter flutter pub get

# Reset completo (borra volumen de pub-cache)
docker compose down -v
```

## 🔍 Debugging

- Los errores de `flutter analyze` dentro de Docker son idénticos a los que reportaría el SDK
  local — no hay diferencia de comportamiento entre ambos entornos para análisis estático.
- Si `flutter test` pasa en Docker pero falla en tu máquina (o viceversa), sospecha primero de
  una diferencia de versión del SDK local vs. la imagen `ghcr.io/cirruslabs/flutter:stable`
  fijada — ejecuta `flutter --version` en ambos entornos y compara.

## 📚 Recursos

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [cirruslabs/docker-images-flutter](https://github.com/cirruslabs/docker-images-flutter)
- [Flutter CI/CD](https://docs.flutter.dev/deployment/cd)
