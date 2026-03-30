// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_form_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LoginFormNotifier)
final loginFormProvider = LoginFormNotifierProvider._();

final class LoginFormNotifierProvider
    extends $NotifierProvider<LoginFormNotifier, LoginFormState> {
  LoginFormNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loginFormProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loginFormNotifierHash();

  @$internal
  @override
  LoginFormNotifier create() => LoginFormNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LoginFormState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LoginFormState>(value),
    );
  }
}

String _$loginFormNotifierHash() => r'3429a8cc2e0e2137f88fbdf87c75e84521aacc14';

abstract class _$LoginFormNotifier extends $Notifier<LoginFormState> {
  LoginFormState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<LoginFormState, LoginFormState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LoginFormState, LoginFormState>,
              LoginFormState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(RegisterFormNotifier)
final registerFormProvider = RegisterFormNotifierProvider._();

final class RegisterFormNotifierProvider
    extends $NotifierProvider<RegisterFormNotifier, RegisterFormState> {
  RegisterFormNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registerFormProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registerFormNotifierHash();

  @$internal
  @override
  RegisterFormNotifier create() => RegisterFormNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RegisterFormState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RegisterFormState>(value),
    );
  }
}

String _$registerFormNotifierHash() =>
    r'97e9bedc1719aaac237813b268bc688d4f2ffa81';

abstract class _$RegisterFormNotifier extends $Notifier<RegisterFormState> {
  RegisterFormState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<RegisterFormState, RegisterFormState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RegisterFormState, RegisterFormState>,
              RegisterFormState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
