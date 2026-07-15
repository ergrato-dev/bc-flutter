@.github/copilot-instructions.md

# Notas específicas para Claude Code

- Este repo es contenido de bootcamp (Dart/Flutter), no una app en producción — el código de
  `starter/` y `solution/` es material didáctico, evalúalo con ese criterio.
- `**/solution/` está en `.gitignore` por política anticopia — nunca lo elimines del
  `.gitignore` ni sugieras subirlo.
- Antes de generar contenido de una semana, lee el `README.md` de la semana anterior para
  mantener coherencia de progresión (especialmente el gestor de estado vigente: Provider
  semana 4, Riverpod desde semana 5, Bloc/Cubit desde semana 10).
- Verifica ejemplos de código con `docker compose run --rm flutter flutter analyze` antes de
  darlos por finalizados.
- Al terminar el contenido real de una semana, elimina el `.gitkeep` de cada carpeta que ya
  tenga archivos — es solo un placeholder del scaffold, no debe quedar junto a contenido real.
