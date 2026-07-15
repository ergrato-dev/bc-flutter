// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ItemsNotifier)
final itemsProvider = ItemsNotifierProvider._();

final class ItemsNotifierProvider
    extends $AsyncNotifierProvider<ItemsNotifier, List<Item>> {
  ItemsNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'itemsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$itemsNotifierHash();

  @$internal
  @override
  ItemsNotifier create() => ItemsNotifier();
}

String _$itemsNotifierHash() => r'b76ed17b7901a235ac0de5a219623bd8f4802872';

abstract class _$ItemsNotifier extends $AsyncNotifier<List<Item>> {
  FutureOr<List<Item>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Item>>, List<Item>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<Item>>, List<Item>>,
        AsyncValue<List<Item>>,
        Object?,
        Object?>;
    return element.handleCreate(ref, build);
  }
}
