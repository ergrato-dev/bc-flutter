/// Comportamiento compartido para entidades con fecha de creación.
///
/// NOTA PARA EL APRENDIZ: este mixin ya está completo, no necesitas
/// modificarlo.
mixin Timestamped {
  DateTime get createdAt;

  bool get isRecent => DateTime.now().difference(createdAt).inDays < 7;
}
