// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(itemsRepository)
final itemsRepositoryProvider = ItemsRepositoryProvider._();

final class ItemsRepositoryProvider extends $FunctionalProvider<ItemsRepository,
    ItemsRepository, ItemsRepository> with $Provider<ItemsRepository> {
  ItemsRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'itemsRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$itemsRepositoryHash();

  @$internal
  @override
  $ProviderElement<ItemsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ItemsRepository create(Ref ref) {
    return itemsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ItemsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ItemsRepository>(value),
    );
  }
}

String _$itemsRepositoryHash() => r'b3bbce21786e3577f301498269bf4c9fc551a0b5';
