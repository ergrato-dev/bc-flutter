# 🐳 Configuración con Docker

Docker es el entorno **oficial** para `flutter analyze`, `flutter test` y `flutter build`.
Garantiza que todos los estudiantes validen su código con exactamente las mismas versiones,
sin importar el sistema operativo. **No reemplaza** al SDK local — ver
[sdk-local.md](sdk-local.md) para renderizar la app en un emulador/simulador.

## 📋 Requisitos Previos

| Herramienta | Versión mínima | Verificar |
|-------------|---------------|-----------|
| Docker | 27.0+ | `docker --version` |
| Docker Compose | 2.31+ | `docker compose version` |
| Git | 2.40+ | `git --version` |

---

## 1. Instalar Docker

### Fedora / RHEL

```bash
sudo dnf install docker docker-compose-plugin
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
# Cierra sesión y vuelve a entrar para que el grupo tenga efecto
```

### Ubuntu / Debian

```bash
sudo apt update
sudo apt install docker.io docker-compose-v2
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
```

### macOS

```bash
# Docker Desktop desde https://docker.com/products/docker-desktop
# o Homebrew:
brew install --cask docker
```

### Windows

Docker Desktop desde [docker.com](https://docker.com/products/docker-desktop). Requiere **WSL2**.

---

## 2. Verificar la Instalación

```bash
docker --version
docker compose version
docker run --rm hello-world
```

---

## 3. Clonar el Repositorio

```bash
git clone https://github.com/ergrato-dev/bc-flutter.git
cd bc-flutter
```

---

## 4. Validar el Proyecto Raíz

```bash
docker compose run --rm flutter flutter --version
```

## 5. Trabajar en un Proyecto Semanal

Cada `3-proyecto/starter/` tiene su propio `Dockerfile`/`docker-compose.yml`:

```bash
cd bootcamp/week-05-riverpod/3-proyecto/starter
cp .env.example .env   # si existe
docker compose run --rm flutter flutter pub get
docker compose run --rm flutter flutter analyze
docker compose run --rm flutter flutter test
```

---

## 6. Comandos del Día a Día

```bash
docker compose run --rm flutter flutter analyze     # análisis estático
docker compose run --rm flutter flutter test        # unit + widget tests
docker compose run --rm flutter flutter build apk    # build headless (no requiere emulador)
docker compose run --rm flutter bash                  # shell interactiva
docker compose down -v                                 # reset completo (borra pub-cache)
```

---

## ❓ Resolución de Problemas

### `permission denied` al ejecutar docker

```bash
sudo usermod -aG docker $USER
newgrp docker
```

### `flutter run` no funciona dentro del contenedor

Esperado — Docker no renderiza GUI. Usa el SDK local (ver [sdk-local.md](sdk-local.md)) para
`flutter run` en un emulador/simulador.

### Imagen desactualizada

```bash
docker compose pull
docker compose build --no-cache
```

---

→ Volver a [setup/README.md](README.md)
