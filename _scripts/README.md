# Scripts de Automatización

Esta carpeta contiene scripts para automatizar tareas comunes del bootcamp.

## 📜 Scripts Disponibles

### `auto-commit.sh`

**What?**  
Script que realiza commits automáticos cada 5 minutos usando Conventional Commits en inglés.

**For?**

- Mantener historial continuo durante sesiones de desarrollo
- Prevenir pérdida de trabajo por eventos inesperados
- Crear historial de commits semántico automáticamente
- Seguir especificación de Conventional Commits

**Impact?**

- Reduce riesgo de perder trabajo
- Mantiene historial limpio y semántico
- Permite rollback fácil a cualquier estado auto-guardado
- Soporta generación automática de changelog

#### Uso

```bash
# Ejecutar el script
./_scripts/auto-commit.sh

# O desde cualquier lugar
bash /ruta/al/proyecto/_scripts/auto-commit.sh
```

#### Características

- **Detección automática de tipo de commit:**

  - `docs`: Cambios en documentación (.md, \_docs/)
  - `feat`: Nuevas características (código Dart)
  - `fix`: Corrección de bugs
  - `style`: Cambios visuales (assets, estilos)
  - `refactor`: Mejoras de código
  - `test`: Cambios en tests
  - `chore`: Mantenimiento (scripts, configuración)

- **Scope automático:**

  - Detecta semana específica (semana-01, semana-02, etc.)
  - Identifica carpeta afectada (\_docs, \_assets, \_scripts)
  - Asigna scope genérico cuando aplica

- **Mensaje completo con contexto:**

  ```
  feat(semana-03): add new features and implementations

  What?
  Add new features and implementations in semana-03 section

  For?
  Maintain continuous development progress

  Impact?
  3 file(s) modified - Auto-committed at 14:30:45
  ```

#### Detener el Script

Presiona `Ctrl+C` para detener el auto-commit en cualquier momento.

---

### `setup-cron.sh`

**What?**  
Script para configurar una tarea cron que ejecuta auto-commit.sh cada 5 minutos en Fedora 43.

**For?**
- Automatizar la ejecución de auto-commit sin intervención manual
- Mantener commits automáticos durante horas de trabajo
- Simplificar la configuración de cron

**Impact?**
- Habilita control de versiones continuo y automático
- Elimina necesidad de ejecutar manualmente el script
- Crea logs centralizados para monitoreo

#### Uso

```bash
# Instalar tarea cron
./_scripts/setup-cron.sh
```

#### Características

- Crea tarea cron: `*/5 * * * *` (cada 5 minutos)
- Logs en `~/.local/share/bc-flutter-autocommit/`
- Detecta y reemplaza tareas existentes
- Verifica existencia del script antes de configurar

#### Comandos Útiles

```bash
# Ver tareas cron
crontab -l

# Editar tareas cron
crontab -e

# Remover tarea
crontab -l | grep -v 'auto-commit.sh' | crontab -

# Ver logs
tail -f ~/.local/share/bc-flutter-autocommit/autocommit.log

# Ver errores
tail -f ~/.local/share/bc-flutter-autocommit/autocommit-error.log

# Estado del servicio cron
systemctl status crond
```

---

## 🔧 Próximos Scripts (Planeados)

- `setup/init-proyecto.sh` - Inicializar proyecto Flutter
- `generators/generate-week.sh` - Generar estructura de semana
- `validators/validate-code.dart` - Validar código de estudiantes

---

## 📝 Notas

- Todos los scripts siguen el principio: **What? For? Impact?**
- Scripts en inglés para nombres y variables
- Documentación en español
- Logs con colores para mejor legibilidad
