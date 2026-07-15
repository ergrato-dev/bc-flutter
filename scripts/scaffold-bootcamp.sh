#!/usr/bin/env bash
# ============================================================
# scaffold-bootcamp.sh
# Genera la estructura completa de las 19 semanas del bootcamp.
# Solo crea archivos si no existen (idempotente).
# Uso: bash scripts/scaffold-bootcamp.sh
# ============================================================
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BASE="$REPO_ROOT/bootcamp"

echo ""
echo "🚀 Scaffold bc-flutter Bootcamp — 19 semanas"
echo "   Destino: $BASE"
echo ""

# ─── Datos de semanas (índice 1..19, índice 0 vacío) ────────────────────────
NUMS=(   ""   "01" "02" "03" "04" "05" "06" "07" "08" "09" "10"
                "11" "12" "13" "14" "15" "16" "17" "18" "19")

SLUGS=(  ""
  "fundamentos_dart_y_entorno"
  "widgets_y_layout"
  "navegacion_go_router"
  "estado_local_y_provider"
  "riverpod"
  "networking_dio_riverpod"
  "formularios_validacion"
  "persistencia_local"
  "autenticacion_completa"
  "clean_architecture_y_bloc"
  "animaciones_basicas"
  "animaciones_avanzadas"
  "apis_nativas_platform_channels"
  "push_notifications"
  "testing"
  "performance_devtools"
  "build_release_publicacion"
  "cicd"
  "proyecto_final"
)

TITLES=( ""
  "Fundamentos de Dart y Entorno"
  "Widgets y Layout"
  "Navegación con go_router"
  "Estado Local y Provider"
  "Riverpod"
  "Networking con Dio y Riverpod"
  "Formularios y Validación"
  "Persistencia Local"
  "Autenticación Completa"
  "Clean Architecture y Bloc"
  "Animaciones Básicas"
  "Animaciones Avanzadas"
  "APIs Nativas y Platform Channels"
  "Push Notifications"
  "Testing"
  "Performance y DevTools"
  "Build, Release y Publicación"
  "CI/CD"
  "Proyecto Final Integrador"
)

PHASES=( ""
  "Fase 0 — Lenguaje (Dart)"
  "Fase 1 — Fundamentos Flutter"
  "Fase 1 — Fundamentos Flutter"
  "Fase 2 — Estado y Datos"
  "Fase 2 — Estado y Datos"
  "Fase 2 — Estado y Datos"
  "Fase 2 — Estado y Datos"
  "Fase 2 — Estado y Datos"
  "Fase 2 — Estado y Datos"
  "Fase 2 — Estado y Datos"
  "Fase 3 — Avanzado"
  "Fase 3 — Avanzado"
  "Fase 3 — Avanzado"
  "Fase 3 — Avanzado"
  "Fase 3 — Avanzado"
  "Fase 3 — Avanzado"
  "Fase 4 — Producción"
  "Fase 4 — Producción"
  "Fase 4 — Producción"
)

TOTAL=19

# ─── Loop principal ──────────────────────────────────────────────────────────
for I in $(seq 1 $TOTAL); do
  NUM="${NUMS[$I]}"
  SLUG="${SLUGS[$I]}"
  TITLE="${TITLES[$I]}"
  PHASE="${PHASES[$I]}"
  IS_FINAL_WEEK=$([[ $I -eq $TOTAL ]] && echo 1 || echo 0)

  WEEK_DIR="$BASE/week-${NUM}-${SLUG}"
  echo "  → week-${NUM}: $TITLE"

  # 1. Directorios (la semana final solo lleva 3-proyecto y 5-glosario)
  if [[ $IS_FINAL_WEEK -eq 1 ]]; then
    mkdir -p \
      "$WEEK_DIR/3-proyecto/starter/lib" \
      "$WEEK_DIR/5-glosario"
  else
    mkdir -p \
      "$WEEK_DIR/0-assets" \
      "$WEEK_DIR/1-teoria" \
      "$WEEK_DIR/2-practicas" \
      "$WEEK_DIR/3-proyecto/starter/lib" \
      "$WEEK_DIR/4-recursos/ebooks-free" \
      "$WEEK_DIR/4-recursos/videografia" \
      "$WEEK_DIR/4-recursos/webgrafia" \
      "$WEEK_DIR/5-glosario"
  fi

  # 2. .gitkeep para directorios sin contenido aún
  if [[ $IS_FINAL_WEEK -eq 1 ]]; then
    GITKEEP_DIRS=("$WEEK_DIR/3-proyecto/starter/lib")
  else
    GITKEEP_DIRS=(
      "$WEEK_DIR/0-assets"
      "$WEEK_DIR/1-teoria"
      "$WEEK_DIR/2-practicas"
      "$WEEK_DIR/3-proyecto/starter/lib"
      "$WEEK_DIR/4-recursos/ebooks-free"
      "$WEEK_DIR/4-recursos/videografia"
      "$WEEK_DIR/4-recursos/webgrafia"
    )
  fi
  for D in "${GITKEEP_DIRS[@]}"; do
    touch "$D/.gitkeep"
  done

  # 3. Dockerfile / docker-compose.yml del proyecto (plantilla raíz)
  [[ -f "$WEEK_DIR/3-proyecto/starter/Dockerfile" ]] || cp "$REPO_ROOT/Dockerfile" "$WEEK_DIR/3-proyecto/starter/Dockerfile"
  [[ -f "$WEEK_DIR/3-proyecto/starter/docker-compose.yml" ]] || cp "$REPO_ROOT/docker-compose.yml" "$WEEK_DIR/3-proyecto/starter/docker-compose.yml"

  # 4. Navigation links
  if [[ $I -gt 1 ]]; then
    PREV_NUM="${NUMS[$((I-1))]}"
    PREV_SLUG="${SLUGS[$((I-1))]}"
    PREV_TITLE="${TITLES[$((I-1))]}"
    PREV_LINK="[← Semana ${PREV_NUM} — ${PREV_TITLE}](../week-${PREV_NUM}-${PREV_SLUG}/README.md)"
  else
    PREV_LINK="← (primera semana)"
  fi
  if [[ $I -lt $TOTAL ]]; then
    NEXT_NUM="${NUMS[$((I+1))]}"
    NEXT_SLUG="${SLUGS[$((I+1))]}"
    NEXT_TITLE="${TITLES[$((I+1))]}"
    NEXT_LINK="[Semana ${NEXT_NUM} — ${NEXT_TITLE} →](../week-${NEXT_NUM}-${NEXT_SLUG}/README.md)"
  else
    NEXT_LINK="(última semana) →"
  fi

  # 5. README.md principal
  if [[ $IS_FINAL_WEEK -eq 1 ]]; then
    [[ -f "$WEEK_DIR/README.md" ]] || cat > "$WEEK_DIR/README.md" << ENDOFREADME
# Semana ${NUM} — ${TITLE}

> **${PHASE}** | Semana ${I} de ${TOTAL} | ⏱️ 16 horas

## 🎯 Objetivos de aprendizaje

> 🚧 **Contenido en desarrollo.** Usa el prompt \`nueva-semana\` para generar el contenido completo.

Esta semana no introduce teoría ni ejercicios guiados nuevos: el estudiante consolida el
proyecto de su dominio único construido a lo largo del bootcamp.

## 📚 Requisitos previos

- Semanas 1-18 completadas

## 🗂️ Estructura de la semana

| Carpeta       | Contenido            | Tiempo |
| -------------- | --------------------- | ------ |
| \`3-proyecto/\` | Consolidación final    | 16h    |

## ⏱️ Distribución del tiempo (16 horas)

| Actividad | Tiempo | Descripción                       |
| --------- | ------ | ----------------------------------- |
| Proyecto  | 16h    | Consolidación, pulido y defensa      |

## 📌 Entregables

- [ ] App funcional en emulador/simulador iOS y/o Android
- [ ] \`flutter analyze\` y \`flutter test\` sin errores (verificable con Docker)
- [ ] Documento de decisiones de arquitectura
- [ ] Demo en vivo + defensa oral

## 🔗 Navegación

${PREV_LINK} | ${NEXT_LINK}
ENDOFREADME
  else
    [[ -f "$WEEK_DIR/README.md" ]] || cat > "$WEEK_DIR/README.md" << ENDOFREADME
# Semana ${NUM} — ${TITLE}

> **${PHASE}** | Semana ${I} de ${TOTAL} | ⏱️ 16 horas

## 🎯 Objetivos de aprendizaje

> 🚧 **Contenido en desarrollo.** Usa el prompt \`nueva-semana\` para generar el contenido completo.

Al finalizar esta semana, el estudiante será capaz de:

- [ ] Objetivo 1
- [ ] Objetivo 2
- [ ] Objetivo 3

## 📚 Requisitos previos

- Semana anterior completada
- Flutter SDK local configurado (\`flutter doctor\` sin errores) + Docker

## 🗂️ Estructura de la semana

| Carpeta           | Contenido                    | Tiempo |
| ----------------- | ---------------------------- | ------ |
| \`1-teoria/\`       | Material teórico             | 4h     |
| \`2-practicas/\`    | Ejercicios guiados           | 6h     |
| \`3-proyecto/\`     | Proyecto integrador          | 6h     |

## 📝 Contenidos

### Teoría

> 🚧 Por generar — usa el prompt \`nueva-teoria\`

### Prácticas

> 🚧 Por generar — usa el prompt \`nuevo-ejercicio\`

### Proyecto

> 🚧 Por generar — usa el prompt \`nuevo-proyecto\`

## ⏱️ Distribución del tiempo (16 horas)

| Actividad  | Tiempo | Descripción                |
| ---------- | ------ | --------------------------- |
| Teoría     | 4h     | Lectura y ejemplos          |
| Prácticas  | 6h     | Ejercicios guiados          |
| Proyecto   | 6h     | Implementación propia       |

## 📌 Entregables

- [ ] Ejercicios completados (prácticas descomentadas y funcionando)
- [ ] Proyecto adaptado al dominio asignado
- [ ] \`flutter analyze\` sin errores (verificable con Docker)
- [ ] App corriendo en emulador/simulador iOS y/o Android

## 🔗 Navegación

${PREV_LINK} | ${NEXT_LINK}
ENDOFREADME
  fi

  # 6. rubrica-evaluacion.md
  [[ -f "$WEEK_DIR/rubrica-evaluacion.md" ]] || cat > "$WEEK_DIR/rubrica-evaluacion.md" << ENDOFRUBRICA
# Rúbrica de Evaluación — Semana ${NUM}

> 🚧 **Contenido en desarrollo.** Usa el prompt \`nueva-semana\` para generar la rúbrica completa.

## Distribución de Puntaje

| Tipo de Evidencia    | Peso | Instrumento             |
| -------------------- | ---- | ------------------------ |
| Conocimiento 🧠      | 30%  | Cuestionario teórico     |
| Desempeño 💪         | 40%  | Ejercicios en clase      |
| Producto 📦          | 30%  | Proyecto entregable      |

**Mínimo aprobatorio**: 70% en cada tipo de evidencia.

## 🧠 Conocimiento (30%)

> Criterios específicos de *${TITLE}* — por definir.

## 💪 Desempeño (40%)

> Criterios de ejercicios prácticos — por definir.

## 📦 Producto (30%)

> Criterios del proyecto adaptado al dominio — por definir.

### Criterios transversales

- ✅ Implementación coherente con el dominio asignado
- ✅ Sin copia de implementaciones de otros aprendices
- ✅ App funcional en emulador/simulador iOS y/o Android
- ✅ \`flutter analyze\` sin errores
ENDOFRUBRICA

  # 7. 3-proyecto/README.md
  [[ -f "$WEEK_DIR/3-proyecto/README.md" ]] || cat > "$WEEK_DIR/3-proyecto/README.md" << ENDOFPROYECTO
# Proyecto Semana ${NUM} — ${TITLE}

> 🚧 **Contenido en desarrollo.** Usa el prompt \`nuevo-proyecto\` para generar el proyecto completo.

## 🎯 Objetivo

Implementar los conceptos de **${TITLE}** aplicados a tu dominio asignado.

## 📋 Tu Dominio Asignado

**Dominio**: [El instructor te asignará tu dominio único al inicio del bootcamp]

> 📌 Recuerda: tu implementación debe ser coherente con tu dominio.
> No copies implementaciones de otros aprendices.

## 🚀 Cómo ejecutar

\`\`\`bash
cd starter
flutter pub get
flutter run
\`\`\`

## 🐳 Validar con Docker

\`\`\`bash
docker compose run --rm flutter flutter analyze
docker compose run --rm flutter flutter test
\`\`\`

## 🛠️ Entregables

1. App funcional en emulador/simulador iOS y/o Android
2. Código adaptado a tu dominio
3. README actualizado con descripción de tu implementación

## 📊 Criterios de Evaluación

Ver [../../rubrica-evaluacion.md](../../rubrica-evaluacion.md)
ENDOFPROYECTO

  # 8. 5-glosario/README.md
  [[ -f "$WEEK_DIR/5-glosario/README.md" ]] || cat > "$WEEK_DIR/5-glosario/README.md" << ENDOFGLOSARIO
# Glosario — Semana ${NUM}: ${TITLE}

> 🚧 **Contenido en desarrollo.** Usa el prompt \`nueva-semana\` para generar el glosario.

Términos técnicos clave introducidos esta semana, ordenados alfabéticamente.

---

> 📚 Glosario global del bootcamp: [docs/plan-estudios.md](../../docs/plan-estudios.md)
ENDOFGLOSARIO

done

echo ""
echo "✅ Scaffold completo — 19 semanas generadas en bootcamp/"
echo ""
ls "$BASE"
