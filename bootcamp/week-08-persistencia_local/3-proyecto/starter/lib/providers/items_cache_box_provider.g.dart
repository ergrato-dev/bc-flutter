// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_cache_box_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(itemsCacheBox)
final itemsCacheBoxProvider = ItemsCacheBoxProvider._();

final class ItemsCacheBoxProvider
    extends $FunctionalProvider<Box<dynamic>, Box<dynamic>, Box<dynamic>>
    with $Provider<Box<dynamic>> {
  ItemsCacheBoxProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'itemsCacheBoxProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$itemsCacheBoxHash();

  @$internal
  @override
  $ProviderElement<Box<dynamic>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Box<dynamic> create(Ref ref) {
    return itemsCacheBox(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Box<dynamic> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Box<dynamic>>(value),
    );
  }
}

String _$itemsCacheBoxHash() => r'01e6eac86ca360b70b78d41c15d5ef2edef625f3';
