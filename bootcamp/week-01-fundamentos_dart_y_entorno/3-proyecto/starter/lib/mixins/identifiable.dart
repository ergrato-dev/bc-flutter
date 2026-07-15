/// Comportamiento compartido para entidades con un identificador.
///
/// NOTA PARA EL APRENDIZ: este mixin ya está completo, no necesitas
/// modificarlo — es la pieza reutilizable que tu modelo `Item` usará.
mixin Identifiable {
  String get id;

  String get shortId => id.length <= 6 ? id : id.substring(0, 6);
}
