// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_form_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoginFormState {

 String get email; String get password; bool get isSubmitting; bool get showErrorMessages; AuthValueFailure<String>? get emailFailure; AuthValueFailure<String>? get passwordFailure;
/// Create a copy of LoginFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginFormStateCopyWith<LoginFormState> get copyWith => _$LoginFormStateCopyWithImpl<LoginFormState>(this as LoginFormState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginFormState&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.showErrorMessages, showErrorMessages) || other.showErrorMessages == showErrorMessages)&&(identical(other.emailFailure, emailFailure) || other.emailFailure == emailFailure)&&(identical(other.passwordFailure, passwordFailure) || other.passwordFailure == passwordFailure));
}


@override
int get hashCode => Object.hash(runtimeType,email,password,isSubmitting,showErrorMessages,emailFailure,passwordFailure);

@override
String toString() {
  return 'LoginFormState(email: $email, password: $password, isSubmitting: $isSubmitting, showErrorMessages: $showErrorMessages, emailFailure: $emailFailure, passwordFailure: $passwordFailure)';
}


}

/// @nodoc
abstract mixin class $LoginFormStateCopyWith<$Res>  {
  factory $LoginFormStateCopyWith(LoginFormState value, $Res Function(LoginFormState) _then) = _$LoginFormStateCopyWithImpl;
@useResult
$Res call({
 String email, String password, bool isSubmitting, bool showErrorMessages, AuthValueFailure<String>? emailFailure, AuthValueFailure<String>? passwordFailure
});


$AuthValueFailureCopyWith<String, $Res>? get emailFailure;$AuthValueFailureCopyWith<String, $Res>? get passwordFailure;

}
/// @nodoc
class _$LoginFormStateCopyWithImpl<$Res>
    implements $LoginFormStateCopyWith<$Res> {
  _$LoginFormStateCopyWithImpl(this._self, this._then);

  final LoginFormState _self;
  final $Res Function(LoginFormState) _then;

/// Create a copy of LoginFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? password = null,Object? isSubmitting = null,Object? showErrorMessages = null,Object? emailFailure = freezed,Object? passwordFailure = freezed,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,showErrorMessages: null == showErrorMessages ? _self.showErrorMessages : showErrorMessages // ignore: cast_nullable_to_non_nullable
as bool,emailFailure: freezed == emailFailure ? _self.emailFailure : emailFailure // ignore: cast_nullable_to_non_nullable
as AuthValueFailure<String>?,passwordFailure: freezed == passwordFailure ? _self.passwordFailure : passwordFailure // ignore: cast_nullable_to_non_nullable
as AuthValueFailure<String>?,
  ));
}
/// Create a copy of LoginFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthValueFailureCopyWith<String, $Res>? get emailFailure {
    if (_self.emailFailure == null) {
    return null;
  }

  return $AuthValueFailureCopyWith<String, $Res>(_self.emailFailure!, (value) {
    return _then(_self.copyWith(emailFailure: value));
  });
}/// Create a copy of LoginFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthValueFailureCopyWith<String, $Res>? get passwordFailure {
    if (_self.passwordFailure == null) {
    return null;
  }

  return $AuthValueFailureCopyWith<String, $Res>(_self.passwordFailure!, (value) {
    return _then(_self.copyWith(passwordFailure: value));
  });
}
}


/// Adds pattern-matching-related methods to [LoginFormState].
extension LoginFormStatePatterns on LoginFormState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginFormState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginFormState value)  $default,){
final _that = this;
switch (_that) {
case _LoginFormState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginFormState value)?  $default,){
final _that = this;
switch (_that) {
case _LoginFormState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String password,  bool isSubmitting,  bool showErrorMessages,  AuthValueFailure<String>? emailFailure,  AuthValueFailure<String>? passwordFailure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginFormState() when $default != null:
return $default(_that.email,_that.password,_that.isSubmitting,_that.showErrorMessages,_that.emailFailure,_that.passwordFailure);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String password,  bool isSubmitting,  bool showErrorMessages,  AuthValueFailure<String>? emailFailure,  AuthValueFailure<String>? passwordFailure)  $default,) {final _that = this;
switch (_that) {
case _LoginFormState():
return $default(_that.email,_that.password,_that.isSubmitting,_that.showErrorMessages,_that.emailFailure,_that.passwordFailure);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String password,  bool isSubmitting,  bool showErrorMessages,  AuthValueFailure<String>? emailFailure,  AuthValueFailure<String>? passwordFailure)?  $default,) {final _that = this;
switch (_that) {
case _LoginFormState() when $default != null:
return $default(_that.email,_that.password,_that.isSubmitting,_that.showErrorMessages,_that.emailFailure,_that.passwordFailure);case _:
  return null;

}
}

}

/// @nodoc


class _LoginFormState implements LoginFormState {
  const _LoginFormState({this.email = '', this.password = '', this.isSubmitting = false, this.showErrorMessages = false, this.emailFailure, this.passwordFailure});
  

@override@JsonKey() final  String email;
@override@JsonKey() final  String password;
@override@JsonKey() final  bool isSubmitting;
@override@JsonKey() final  bool showErrorMessages;
@override final  AuthValueFailure<String>? emailFailure;
@override final  AuthValueFailure<String>? passwordFailure;

/// Create a copy of LoginFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginFormStateCopyWith<_LoginFormState> get copyWith => __$LoginFormStateCopyWithImpl<_LoginFormState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginFormState&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.showErrorMessages, showErrorMessages) || other.showErrorMessages == showErrorMessages)&&(identical(other.emailFailure, emailFailure) || other.emailFailure == emailFailure)&&(identical(other.passwordFailure, passwordFailure) || other.passwordFailure == passwordFailure));
}


@override
int get hashCode => Object.hash(runtimeType,email,password,isSubmitting,showErrorMessages,emailFailure,passwordFailure);

@override
String toString() {
  return 'LoginFormState(email: $email, password: $password, isSubmitting: $isSubmitting, showErrorMessages: $showErrorMessages, emailFailure: $emailFailure, passwordFailure: $passwordFailure)';
}


}

/// @nodoc
abstract mixin class _$LoginFormStateCopyWith<$Res> implements $LoginFormStateCopyWith<$Res> {
  factory _$LoginFormStateCopyWith(_LoginFormState value, $Res Function(_LoginFormState) _then) = __$LoginFormStateCopyWithImpl;
@override @useResult
$Res call({
 String email, String password, bool isSubmitting, bool showErrorMessages, AuthValueFailure<String>? emailFailure, AuthValueFailure<String>? passwordFailure
});


@override $AuthValueFailureCopyWith<String, $Res>? get emailFailure;@override $AuthValueFailureCopyWith<String, $Res>? get passwordFailure;

}
/// @nodoc
class __$LoginFormStateCopyWithImpl<$Res>
    implements _$LoginFormStateCopyWith<$Res> {
  __$LoginFormStateCopyWithImpl(this._self, this._then);

  final _LoginFormState _self;
  final $Res Function(_LoginFormState) _then;

/// Create a copy of LoginFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,Object? isSubmitting = null,Object? showErrorMessages = null,Object? emailFailure = freezed,Object? passwordFailure = freezed,}) {
  return _then(_LoginFormState(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,showErrorMessages: null == showErrorMessages ? _self.showErrorMessages : showErrorMessages // ignore: cast_nullable_to_non_nullable
as bool,emailFailure: freezed == emailFailure ? _self.emailFailure : emailFailure // ignore: cast_nullable_to_non_nullable
as AuthValueFailure<String>?,passwordFailure: freezed == passwordFailure ? _self.passwordFailure : passwordFailure // ignore: cast_nullable_to_non_nullable
as AuthValueFailure<String>?,
  ));
}

/// Create a copy of LoginFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthValueFailureCopyWith<String, $Res>? get emailFailure {
    if (_self.emailFailure == null) {
    return null;
  }

  return $AuthValueFailureCopyWith<String, $Res>(_self.emailFailure!, (value) {
    return _then(_self.copyWith(emailFailure: value));
  });
}/// Create a copy of LoginFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthValueFailureCopyWith<String, $Res>? get passwordFailure {
    if (_self.passwordFailure == null) {
    return null;
  }

  return $AuthValueFailureCopyWith<String, $Res>(_self.passwordFailure!, (value) {
    return _then(_self.copyWith(passwordFailure: value));
  });
}
}

/// @nodoc
mixin _$RegisterFormState {

 String get email; String get password; String get firstName; String get lastName; bool get isSubmitting; bool get showErrorMessages; AuthValueFailure<String>? get emailFailure; AuthValueFailure<String>? get passwordFailure; AuthValueFailure<String>? get firstNameFailure; AuthValueFailure<String>? get lastNameFailure;
/// Create a copy of RegisterFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterFormStateCopyWith<RegisterFormState> get copyWith => _$RegisterFormStateCopyWithImpl<RegisterFormState>(this as RegisterFormState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterFormState&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.showErrorMessages, showErrorMessages) || other.showErrorMessages == showErrorMessages)&&(identical(other.emailFailure, emailFailure) || other.emailFailure == emailFailure)&&(identical(other.passwordFailure, passwordFailure) || other.passwordFailure == passwordFailure)&&(identical(other.firstNameFailure, firstNameFailure) || other.firstNameFailure == firstNameFailure)&&(identical(other.lastNameFailure, lastNameFailure) || other.lastNameFailure == lastNameFailure));
}


@override
int get hashCode => Object.hash(runtimeType,email,password,firstName,lastName,isSubmitting,showErrorMessages,emailFailure,passwordFailure,firstNameFailure,lastNameFailure);

@override
String toString() {
  return 'RegisterFormState(email: $email, password: $password, firstName: $firstName, lastName: $lastName, isSubmitting: $isSubmitting, showErrorMessages: $showErrorMessages, emailFailure: $emailFailure, passwordFailure: $passwordFailure, firstNameFailure: $firstNameFailure, lastNameFailure: $lastNameFailure)';
}


}

/// @nodoc
abstract mixin class $RegisterFormStateCopyWith<$Res>  {
  factory $RegisterFormStateCopyWith(RegisterFormState value, $Res Function(RegisterFormState) _then) = _$RegisterFormStateCopyWithImpl;
@useResult
$Res call({
 String email, String password, String firstName, String lastName, bool isSubmitting, bool showErrorMessages, AuthValueFailure<String>? emailFailure, AuthValueFailure<String>? passwordFailure, AuthValueFailure<String>? firstNameFailure, AuthValueFailure<String>? lastNameFailure
});


$AuthValueFailureCopyWith<String, $Res>? get emailFailure;$AuthValueFailureCopyWith<String, $Res>? get passwordFailure;$AuthValueFailureCopyWith<String, $Res>? get firstNameFailure;$AuthValueFailureCopyWith<String, $Res>? get lastNameFailure;

}
/// @nodoc
class _$RegisterFormStateCopyWithImpl<$Res>
    implements $RegisterFormStateCopyWith<$Res> {
  _$RegisterFormStateCopyWithImpl(this._self, this._then);

  final RegisterFormState _self;
  final $Res Function(RegisterFormState) _then;

/// Create a copy of RegisterFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? password = null,Object? firstName = null,Object? lastName = null,Object? isSubmitting = null,Object? showErrorMessages = null,Object? emailFailure = freezed,Object? passwordFailure = freezed,Object? firstNameFailure = freezed,Object? lastNameFailure = freezed,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,showErrorMessages: null == showErrorMessages ? _self.showErrorMessages : showErrorMessages // ignore: cast_nullable_to_non_nullable
as bool,emailFailure: freezed == emailFailure ? _self.emailFailure : emailFailure // ignore: cast_nullable_to_non_nullable
as AuthValueFailure<String>?,passwordFailure: freezed == passwordFailure ? _self.passwordFailure : passwordFailure // ignore: cast_nullable_to_non_nullable
as AuthValueFailure<String>?,firstNameFailure: freezed == firstNameFailure ? _self.firstNameFailure : firstNameFailure // ignore: cast_nullable_to_non_nullable
as AuthValueFailure<String>?,lastNameFailure: freezed == lastNameFailure ? _self.lastNameFailure : lastNameFailure // ignore: cast_nullable_to_non_nullable
as AuthValueFailure<String>?,
  ));
}
/// Create a copy of RegisterFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthValueFailureCopyWith<String, $Res>? get emailFailure {
    if (_self.emailFailure == null) {
    return null;
  }

  return $AuthValueFailureCopyWith<String, $Res>(_self.emailFailure!, (value) {
    return _then(_self.copyWith(emailFailure: value));
  });
}/// Create a copy of RegisterFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthValueFailureCopyWith<String, $Res>? get passwordFailure {
    if (_self.passwordFailure == null) {
    return null;
  }

  return $AuthValueFailureCopyWith<String, $Res>(_self.passwordFailure!, (value) {
    return _then(_self.copyWith(passwordFailure: value));
  });
}/// Create a copy of RegisterFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthValueFailureCopyWith<String, $Res>? get firstNameFailure {
    if (_self.firstNameFailure == null) {
    return null;
  }

  return $AuthValueFailureCopyWith<String, $Res>(_self.firstNameFailure!, (value) {
    return _then(_self.copyWith(firstNameFailure: value));
  });
}/// Create a copy of RegisterFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthValueFailureCopyWith<String, $Res>? get lastNameFailure {
    if (_self.lastNameFailure == null) {
    return null;
  }

  return $AuthValueFailureCopyWith<String, $Res>(_self.lastNameFailure!, (value) {
    return _then(_self.copyWith(lastNameFailure: value));
  });
}
}


/// Adds pattern-matching-related methods to [RegisterFormState].
extension RegisterFormStatePatterns on RegisterFormState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegisterFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegisterFormState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegisterFormState value)  $default,){
final _that = this;
switch (_that) {
case _RegisterFormState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegisterFormState value)?  $default,){
final _that = this;
switch (_that) {
case _RegisterFormState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String password,  String firstName,  String lastName,  bool isSubmitting,  bool showErrorMessages,  AuthValueFailure<String>? emailFailure,  AuthValueFailure<String>? passwordFailure,  AuthValueFailure<String>? firstNameFailure,  AuthValueFailure<String>? lastNameFailure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegisterFormState() when $default != null:
return $default(_that.email,_that.password,_that.firstName,_that.lastName,_that.isSubmitting,_that.showErrorMessages,_that.emailFailure,_that.passwordFailure,_that.firstNameFailure,_that.lastNameFailure);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String password,  String firstName,  String lastName,  bool isSubmitting,  bool showErrorMessages,  AuthValueFailure<String>? emailFailure,  AuthValueFailure<String>? passwordFailure,  AuthValueFailure<String>? firstNameFailure,  AuthValueFailure<String>? lastNameFailure)  $default,) {final _that = this;
switch (_that) {
case _RegisterFormState():
return $default(_that.email,_that.password,_that.firstName,_that.lastName,_that.isSubmitting,_that.showErrorMessages,_that.emailFailure,_that.passwordFailure,_that.firstNameFailure,_that.lastNameFailure);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String password,  String firstName,  String lastName,  bool isSubmitting,  bool showErrorMessages,  AuthValueFailure<String>? emailFailure,  AuthValueFailure<String>? passwordFailure,  AuthValueFailure<String>? firstNameFailure,  AuthValueFailure<String>? lastNameFailure)?  $default,) {final _that = this;
switch (_that) {
case _RegisterFormState() when $default != null:
return $default(_that.email,_that.password,_that.firstName,_that.lastName,_that.isSubmitting,_that.showErrorMessages,_that.emailFailure,_that.passwordFailure,_that.firstNameFailure,_that.lastNameFailure);case _:
  return null;

}
}

}

/// @nodoc


class _RegisterFormState implements RegisterFormState {
  const _RegisterFormState({this.email = '', this.password = '', this.firstName = '', this.lastName = '', this.isSubmitting = false, this.showErrorMessages = false, this.emailFailure, this.passwordFailure, this.firstNameFailure, this.lastNameFailure});
  

@override@JsonKey() final  String email;
@override@JsonKey() final  String password;
@override@JsonKey() final  String firstName;
@override@JsonKey() final  String lastName;
@override@JsonKey() final  bool isSubmitting;
@override@JsonKey() final  bool showErrorMessages;
@override final  AuthValueFailure<String>? emailFailure;
@override final  AuthValueFailure<String>? passwordFailure;
@override final  AuthValueFailure<String>? firstNameFailure;
@override final  AuthValueFailure<String>? lastNameFailure;

/// Create a copy of RegisterFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterFormStateCopyWith<_RegisterFormState> get copyWith => __$RegisterFormStateCopyWithImpl<_RegisterFormState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterFormState&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.showErrorMessages, showErrorMessages) || other.showErrorMessages == showErrorMessages)&&(identical(other.emailFailure, emailFailure) || other.emailFailure == emailFailure)&&(identical(other.passwordFailure, passwordFailure) || other.passwordFailure == passwordFailure)&&(identical(other.firstNameFailure, firstNameFailure) || other.firstNameFailure == firstNameFailure)&&(identical(other.lastNameFailure, lastNameFailure) || other.lastNameFailure == lastNameFailure));
}


@override
int get hashCode => Object.hash(runtimeType,email,password,firstName,lastName,isSubmitting,showErrorMessages,emailFailure,passwordFailure,firstNameFailure,lastNameFailure);

@override
String toString() {
  return 'RegisterFormState(email: $email, password: $password, firstName: $firstName, lastName: $lastName, isSubmitting: $isSubmitting, showErrorMessages: $showErrorMessages, emailFailure: $emailFailure, passwordFailure: $passwordFailure, firstNameFailure: $firstNameFailure, lastNameFailure: $lastNameFailure)';
}


}

/// @nodoc
abstract mixin class _$RegisterFormStateCopyWith<$Res> implements $RegisterFormStateCopyWith<$Res> {
  factory _$RegisterFormStateCopyWith(_RegisterFormState value, $Res Function(_RegisterFormState) _then) = __$RegisterFormStateCopyWithImpl;
@override @useResult
$Res call({
 String email, String password, String firstName, String lastName, bool isSubmitting, bool showErrorMessages, AuthValueFailure<String>? emailFailure, AuthValueFailure<String>? passwordFailure, AuthValueFailure<String>? firstNameFailure, AuthValueFailure<String>? lastNameFailure
});


@override $AuthValueFailureCopyWith<String, $Res>? get emailFailure;@override $AuthValueFailureCopyWith<String, $Res>? get passwordFailure;@override $AuthValueFailureCopyWith<String, $Res>? get firstNameFailure;@override $AuthValueFailureCopyWith<String, $Res>? get lastNameFailure;

}
/// @nodoc
class __$RegisterFormStateCopyWithImpl<$Res>
    implements _$RegisterFormStateCopyWith<$Res> {
  __$RegisterFormStateCopyWithImpl(this._self, this._then);

  final _RegisterFormState _self;
  final $Res Function(_RegisterFormState) _then;

/// Create a copy of RegisterFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,Object? firstName = null,Object? lastName = null,Object? isSubmitting = null,Object? showErrorMessages = null,Object? emailFailure = freezed,Object? passwordFailure = freezed,Object? firstNameFailure = freezed,Object? lastNameFailure = freezed,}) {
  return _then(_RegisterFormState(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,showErrorMessages: null == showErrorMessages ? _self.showErrorMessages : showErrorMessages // ignore: cast_nullable_to_non_nullable
as bool,emailFailure: freezed == emailFailure ? _self.emailFailure : emailFailure // ignore: cast_nullable_to_non_nullable
as AuthValueFailure<String>?,passwordFailure: freezed == passwordFailure ? _self.passwordFailure : passwordFailure // ignore: cast_nullable_to_non_nullable
as AuthValueFailure<String>?,firstNameFailure: freezed == firstNameFailure ? _self.firstNameFailure : firstNameFailure // ignore: cast_nullable_to_non_nullable
as AuthValueFailure<String>?,lastNameFailure: freezed == lastNameFailure ? _self.lastNameFailure : lastNameFailure // ignore: cast_nullable_to_non_nullable
as AuthValueFailure<String>?,
  ));
}

/// Create a copy of RegisterFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthValueFailureCopyWith<String, $Res>? get emailFailure {
    if (_self.emailFailure == null) {
    return null;
  }

  return $AuthValueFailureCopyWith<String, $Res>(_self.emailFailure!, (value) {
    return _then(_self.copyWith(emailFailure: value));
  });
}/// Create a copy of RegisterFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthValueFailureCopyWith<String, $Res>? get passwordFailure {
    if (_self.passwordFailure == null) {
    return null;
  }

  return $AuthValueFailureCopyWith<String, $Res>(_self.passwordFailure!, (value) {
    return _then(_self.copyWith(passwordFailure: value));
  });
}/// Create a copy of RegisterFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthValueFailureCopyWith<String, $Res>? get firstNameFailure {
    if (_self.firstNameFailure == null) {
    return null;
  }

  return $AuthValueFailureCopyWith<String, $Res>(_self.firstNameFailure!, (value) {
    return _then(_self.copyWith(firstNameFailure: value));
  });
}/// Create a copy of RegisterFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthValueFailureCopyWith<String, $Res>? get lastNameFailure {
    if (_self.lastNameFailure == null) {
    return null;
  }

  return $AuthValueFailureCopyWith<String, $Res>(_self.lastNameFailure!, (value) {
    return _then(_self.copyWith(lastNameFailure: value));
  });
}
}

// dart format on
