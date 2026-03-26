// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_tab_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomeTabIndex)
final homeTabIndexProvider = HomeTabIndexProvider._();

final class HomeTabIndexProvider extends $NotifierProvider<HomeTabIndex, int> {
  HomeTabIndexProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeTabIndexProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeTabIndexHash();

  @$internal
  @override
  HomeTabIndex create() => HomeTabIndex();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$homeTabIndexHash() => r'70e1e794a8eea32c62b5082fa602ff272626feb6';

abstract class _$HomeTabIndex extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
