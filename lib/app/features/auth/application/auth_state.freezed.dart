// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthState {

 EmailAddress get email; Password get password; FirstName get firstName; LastName get lastName; bool get isSubmitting; bool get showErrorMessages; AuthValueFailure<String>? get fieldFailure; Option<Either<AuthUserFailure, Unit>> get authFailureOrSuccessOption;
/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthStateCopyWith<AuthState> get copyWith => _$AuthStateCopyWithImpl<AuthState>(this as AuthState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.showErrorMessages, showErrorMessages) || other.showErrorMessages == showErrorMessages)&&(identical(other.fieldFailure, fieldFailure) || other.fieldFailure == fieldFailure)&&(identical(other.authFailureOrSuccessOption, authFailureOrSuccessOption) || other.authFailureOrSuccessOption == authFailureOrSuccessOption));
}


@override
int get hashCode => Object.hash(runtimeType,email,password,firstName,lastName,isSubmitting,showErrorMessages,fieldFailure,authFailureOrSuccessOption);

@override
String toString() {
  return 'AuthState(email: $email, password: $password, firstName: $firstName, lastName: $lastName, isSubmitting: $isSubmitting, showErrorMessages: $showErrorMessages, fieldFailure: $fieldFailure, authFailureOrSuccessOption: $authFailureOrSuccessOption)';
}


}

/// @nodoc
abstract mixin class $AuthStateCopyWith<$Res>  {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) _then) = _$AuthStateCopyWithImpl;
@useResult
$Res call({
 EmailAddress email, Password password, FirstName firstName, LastName lastName, bool isSubmitting, bool showErrorMessages, AuthValueFailure<String>? fieldFailure, Option<Either<AuthUserFailure, Unit>> authFailureOrSuccessOption
});


$AuthValueFailureCopyWith<String, $Res>? get fieldFailure;

}
/// @nodoc
class _$AuthStateCopyWithImpl<$Res>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._self, this._then);

  final AuthState _self;
  final $Res Function(AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? password = null,Object? firstName = null,Object? lastName = null,Object? isSubmitting = null,Object? showErrorMessages = null,Object? fieldFailure = freezed,Object? authFailureOrSuccessOption = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as EmailAddress,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as Password,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as FirstName,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as LastName,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,showErrorMessages: null == showErrorMessages ? _self.showErrorMessages : showErrorMessages // ignore: cast_nullable_to_non_nullable
as bool,fieldFailure: freezed == fieldFailure ? _self.fieldFailure : fieldFailure // ignore: cast_nullable_to_non_nullable
as AuthValueFailure<String>?,authFailureOrSuccessOption: null == authFailureOrSuccessOption ? _self.authFailureOrSuccessOption : authFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<AuthUserFailure, Unit>>,
  ));
}
/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthValueFailureCopyWith<String, $Res>? get fieldFailure {
    if (_self.fieldFailure == null) {
    return null;
  }

  return $AuthValueFailureCopyWith<String, $Res>(_self.fieldFailure!, (value) {
    return _then(_self.copyWith(fieldFailure: value));
  });
}
}


/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthState value)  $default,){
final _that = this;
switch (_that) {
case _AuthState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthState value)?  $default,){
final _that = this;
switch (_that) {
case _AuthState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EmailAddress email,  Password password,  FirstName firstName,  LastName lastName,  bool isSubmitting,  bool showErrorMessages,  AuthValueFailure<String>? fieldFailure,  Option<Either<AuthUserFailure, Unit>> authFailureOrSuccessOption)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthState() when $default != null:
return $default(_that.email,_that.password,_that.firstName,_that.lastName,_that.isSubmitting,_that.showErrorMessages,_that.fieldFailure,_that.authFailureOrSuccessOption);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EmailAddress email,  Password password,  FirstName firstName,  LastName lastName,  bool isSubmitting,  bool showErrorMessages,  AuthValueFailure<String>? fieldFailure,  Option<Either<AuthUserFailure, Unit>> authFailureOrSuccessOption)  $default,) {final _that = this;
switch (_that) {
case _AuthState():
return $default(_that.email,_that.password,_that.firstName,_that.lastName,_that.isSubmitting,_that.showErrorMessages,_that.fieldFailure,_that.authFailureOrSuccessOption);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EmailAddress email,  Password password,  FirstName firstName,  LastName lastName,  bool isSubmitting,  bool showErrorMessages,  AuthValueFailure<String>? fieldFailure,  Option<Either<AuthUserFailure, Unit>> authFailureOrSuccessOption)?  $default,) {final _that = this;
switch (_that) {
case _AuthState() when $default != null:
return $default(_that.email,_that.password,_that.firstName,_that.lastName,_that.isSubmitting,_that.showErrorMessages,_that.fieldFailure,_that.authFailureOrSuccessOption);case _:
  return null;

}
}

}

/// @nodoc


class _AuthState implements AuthState {
  const _AuthState({required this.email, required this.password, required this.firstName, required this.lastName, this.isSubmitting = false, this.showErrorMessages = false, this.fieldFailure, required this.authFailureOrSuccessOption});
  

@override final  EmailAddress email;
@override final  Password password;
@override final  FirstName firstName;
@override final  LastName lastName;
@override@JsonKey() final  bool isSubmitting;
@override@JsonKey() final  bool showErrorMessages;
@override final  AuthValueFailure<String>? fieldFailure;
@override final  Option<Either<AuthUserFailure, Unit>> authFailureOrSuccessOption;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthStateCopyWith<_AuthState> get copyWith => __$AuthStateCopyWithImpl<_AuthState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthState&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.showErrorMessages, showErrorMessages) || other.showErrorMessages == showErrorMessages)&&(identical(other.fieldFailure, fieldFailure) || other.fieldFailure == fieldFailure)&&(identical(other.authFailureOrSuccessOption, authFailureOrSuccessOption) || other.authFailureOrSuccessOption == authFailureOrSuccessOption));
}


@override
int get hashCode => Object.hash(runtimeType,email,password,firstName,lastName,isSubmitting,showErrorMessages,fieldFailure,authFailureOrSuccessOption);

@override
String toString() {
  return 'AuthState(email: $email, password: $password, firstName: $firstName, lastName: $lastName, isSubmitting: $isSubmitting, showErrorMessages: $showErrorMessages, fieldFailure: $fieldFailure, authFailureOrSuccessOption: $authFailureOrSuccessOption)';
}


}

/// @nodoc
abstract mixin class _$AuthStateCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$AuthStateCopyWith(_AuthState value, $Res Function(_AuthState) _then) = __$AuthStateCopyWithImpl;
@override @useResult
$Res call({
 EmailAddress email, Password password, FirstName firstName, LastName lastName, bool isSubmitting, bool showErrorMessages, AuthValueFailure<String>? fieldFailure, Option<Either<AuthUserFailure, Unit>> authFailureOrSuccessOption
});


@override $AuthValueFailureCopyWith<String, $Res>? get fieldFailure;

}
/// @nodoc
class __$AuthStateCopyWithImpl<$Res>
    implements _$AuthStateCopyWith<$Res> {
  __$AuthStateCopyWithImpl(this._self, this._then);

  final _AuthState _self;
  final $Res Function(_AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,Object? firstName = null,Object? lastName = null,Object? isSubmitting = null,Object? showErrorMessages = null,Object? fieldFailure = freezed,Object? authFailureOrSuccessOption = null,}) {
  return _then(_AuthState(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as EmailAddress,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as Password,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as FirstName,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as LastName,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,showErrorMessages: null == showErrorMessages ? _self.showErrorMessages : showErrorMessages // ignore: cast_nullable_to_non_nullable
as bool,fieldFailure: freezed == fieldFailure ? _self.fieldFailure : fieldFailure // ignore: cast_nullable_to_non_nullable
as AuthValueFailure<String>?,authFailureOrSuccessOption: null == authFailureOrSuccessOption ? _self.authFailureOrSuccessOption : authFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
as Option<Either<AuthUserFailure, Unit>>,
  ));
}

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthValueFailureCopyWith<String, $Res>? get fieldFailure {
    if (_self.fieldFailure == null) {
    return null;
  }

  return $AuthValueFailureCopyWith<String, $Res>(_self.fieldFailure!, (value) {
    return _then(_self.copyWith(fieldFailure: value));
  });
}
}

// dart format on
