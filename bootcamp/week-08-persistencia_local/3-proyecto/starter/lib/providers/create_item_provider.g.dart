// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_item_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CreateItemNotifier)
final createItemProvider = CreateItemNotifierProvider._();

final class CreateItemNotifierProvider
    extends $AsyncNotifierProvider<CreateItemNotifier, void> {
  CreateItemNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'createItemProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$createItemNotifierHash();

  @$internal
  @override
  CreateItemNotifier create() => CreateItemNotifier();
}

String _$createItemNotifierHash() =>
    r'c73bc02e80a54215a2660c2c2ee949e8984e349b';

abstract class _$CreateItemNotifier extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<void>, void>,
        AsyncValue<void>,
        Object?,
        Object?>;
    return element.handleCreate(ref, build);
  }
}
