// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FavoritesNotifier)
final favoritesProvider = FavoritesNotifierProvider._();

final class FavoritesNotifierProvider
    extends $NotifierProvider<FavoritesNotifier, Set<String>> {
  FavoritesNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'favoritesProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$favoritesNotifierHash();

  @$internal
  @override
  FavoritesNotifier create() => FavoritesNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<String>>(value),
    );
  }
}

String _$favoritesNotifierHash() => r'0fe12660b156889f58859a051a6a8c7f787cd51c';

abstract class _$FavoritesNotifier extends $Notifier<Set<String>> {
  Set<String> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Set<String>, Set<String>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<Set<String>, Set<String>>, Set<String>, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}
