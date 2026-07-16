import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'items_cache_box_provider.g.dart';

// ============================================
// PROVIDER: itemsCacheBox
// Expone el Box de Hive ya abierto — usado por CachedItemsRepository
// (ver teoría 05).
// ============================================
//
// NOTA PARA EL APRENDIZ:
// Este archivo ya está completo — no necesitas modificarlo. El cuerpo real
// nunca se ejecuta: main.dart sobreescribe este provider con
// overrideWithValue() antes de runApp(), usando el Box que abrió con
// Hive.openBox().
@riverpod
Box<dynamic> itemsCacheBox(Ref ref) {
  throw UnimplementedError('Debe sobreescribirse en main() — ver overrides de ProviderScope.');
}
