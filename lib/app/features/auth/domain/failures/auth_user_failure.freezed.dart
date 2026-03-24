// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_user_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthUserFailure {

 String? get message;
/// Create a copy of AuthUserFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthUserFailureCopyWith<AuthUserFailure> get copyWith => _$AuthUserFailureCopyWithImpl<AuthUserFailure>(this as AuthUserFailure, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthUserFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AuthUserFailure(message: $message)';
}


}

/// @nodoc
abstract mixin class $AuthUserFailureCopyWith<$Res>  {
  factory $AuthUserFailureCopyWith(AuthUserFailure value, $Res Function(AuthUserFailure) _then) = _$AuthUserFailureCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$AuthUserFailureCopyWithImpl<$Res>
    implements $AuthUserFailureCopyWith<$Res> {
  _$AuthUserFailureCopyWithImpl(this._self, this._then);

  final AuthUserFailure _self;
  final $Res Function(AuthUserFailure) _then;

/// Create a copy of AuthUserFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = freezed,}) {
  return _then(_self.copyWith(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthUserFailure].
extension AuthUserFailurePatterns on AuthUserFailure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( EmailAlreadyInUse value)?  emailAlreadyInUse,TResult Function( InvalidEmailAndPasswordCombination value)?  invalidEmailAndPasswordCombination,TResult Function( ServerError value)?  serverError,TResult Function( NetworkError value)?  networkError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case EmailAlreadyInUse() when emailAlreadyInUse != null:
return emailAlreadyInUse(_that);case InvalidEmailAndPasswordCombination() when invalidEmailAndPasswordCombination != null:
return invalidEmailAndPasswordCombination(_that);case ServerError() when serverError != null:
return serverError(_that);case NetworkError() when networkError != null:
return networkError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( EmailAlreadyInUse value)  emailAlreadyInUse,required TResult Function( InvalidEmailAndPasswordCombination value)  invalidEmailAndPasswordCombination,required TResult Function( ServerError value)  serverError,required TResult Function( NetworkError value)  networkError,}){
final _that = this;
switch (_that) {
case EmailAlreadyInUse():
return emailAlreadyInUse(_that);case InvalidEmailAndPasswordCombination():
return invalidEmailAndPasswordCombination(_that);case ServerError():
return serverError(_that);case NetworkError():
return networkError(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( EmailAlreadyInUse value)?  emailAlreadyInUse,TResult? Function( InvalidEmailAndPasswordCombination value)?  invalidEmailAndPasswordCombination,TResult? Function( ServerError value)?  serverError,TResult? Function( NetworkError value)?  networkError,}){
final _that = this;
switch (_that) {
case EmailAlreadyInUse() when emailAlreadyInUse != null:
return emailAlreadyInUse(_that);case InvalidEmailAndPasswordCombination() when invalidEmailAndPasswordCombination != null:
return invalidEmailAndPasswordCombination(_that);case ServerError() when serverError != null:
return serverError(_that);case NetworkError() when networkError != null:
return networkError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? message)?  emailAlreadyInUse,TResult Function( String? message)?  invalidEmailAndPasswordCombination,TResult Function( String? message)?  serverError,TResult Function( String? message)?  networkError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case EmailAlreadyInUse() when emailAlreadyInUse != null:
return emailAlreadyInUse(_that.message);case InvalidEmailAndPasswordCombination() when invalidEmailAndPasswordCombination != null:
return invalidEmailAndPasswordCombination(_that.message);case ServerError() when serverError != null:
return serverError(_that.message);case NetworkError() when networkError != null:
return networkError(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? message)  emailAlreadyInUse,required TResult Function( String? message)  invalidEmailAndPasswordCombination,required TResult Function( String? message)  serverError,required TResult Function( String? message)  networkError,}) {final _that = this;
switch (_that) {
case EmailAlreadyInUse():
return emailAlreadyInUse(_that.message);case InvalidEmailAndPasswordCombination():
return invalidEmailAndPasswordCombination(_that.message);case ServerError():
return serverError(_that.message);case NetworkError():
return networkError(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? message)?  emailAlreadyInUse,TResult? Function( String? message)?  invalidEmailAndPasswordCombination,TResult? Function( String? message)?  serverError,TResult? Function( String? message)?  networkError,}) {final _that = this;
switch (_that) {
case EmailAlreadyInUse() when emailAlreadyInUse != null:
return emailAlreadyInUse(_that.message);case InvalidEmailAndPasswordCombination() when invalidEmailAndPasswordCombination != null:
return invalidEmailAndPasswordCombination(_that.message);case ServerError() when serverError != null:
return serverError(_that.message);case NetworkError() when networkError != null:
return networkError(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class EmailAlreadyInUse implements AuthUserFailure {
  const EmailAlreadyInUse({this.message});
  

@override final  String? message;

/// Create a copy of AuthUserFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmailAlreadyInUseCopyWith<EmailAlreadyInUse> get copyWith => _$EmailAlreadyInUseCopyWithImpl<EmailAlreadyInUse>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailAlreadyInUse&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AuthUserFailure.emailAlreadyInUse(message: $message)';
}


}

/// @nodoc
abstract mixin class $EmailAlreadyInUseCopyWith<$Res> implements $AuthUserFailureCopyWith<$Res> {
  factory $EmailAlreadyInUseCopyWith(EmailAlreadyInUse value, $Res Function(EmailAlreadyInUse) _then) = _$EmailAlreadyInUseCopyWithImpl;
@override @useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$EmailAlreadyInUseCopyWithImpl<$Res>
    implements $EmailAlreadyInUseCopyWith<$Res> {
  _$EmailAlreadyInUseCopyWithImpl(this._self, this._then);

  final EmailAlreadyInUse _self;
  final $Res Function(EmailAlreadyInUse) _then;

/// Create a copy of AuthUserFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(EmailAlreadyInUse(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class InvalidEmailAndPasswordCombination implements AuthUserFailure {
  const InvalidEmailAndPasswordCombination({this.message});
  

@override final  String? message;

/// Create a copy of AuthUserFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvalidEmailAndPasswordCombinationCopyWith<InvalidEmailAndPasswordCombination> get copyWith => _$InvalidEmailAndPasswordCombinationCopyWithImpl<InvalidEmailAndPasswordCombination>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidEmailAndPasswordCombination&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AuthUserFailure.invalidEmailAndPasswordCombination(message: $message)';
}


}

/// @nodoc
abstract mixin class $InvalidEmailAndPasswordCombinationCopyWith<$Res> implements $AuthUserFailureCopyWith<$Res> {
  factory $InvalidEmailAndPasswordCombinationCopyWith(InvalidEmailAndPasswordCombination value, $Res Function(InvalidEmailAndPasswordCombination) _then) = _$InvalidEmailAndPasswordCombinationCopyWithImpl;
@override @useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$InvalidEmailAndPasswordCombinationCopyWithImpl<$Res>
    implements $InvalidEmailAndPasswordCombinationCopyWith<$Res> {
  _$InvalidEmailAndPasswordCombinationCopyWithImpl(this._self, this._then);

  final InvalidEmailAndPasswordCombination _self;
  final $Res Function(InvalidEmailAndPasswordCombination) _then;

/// Create a copy of AuthUserFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(InvalidEmailAndPasswordCombination(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ServerError implements AuthUserFailure {
  const ServerError({this.message});
  

@override final  String? message;

/// Create a copy of AuthUserFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerErrorCopyWith<ServerError> get copyWith => _$ServerErrorCopyWithImpl<ServerError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AuthUserFailure.serverError(message: $message)';
}


}

/// @nodoc
abstract mixin class $ServerErrorCopyWith<$Res> implements $AuthUserFailureCopyWith<$Res> {
  factory $ServerErrorCopyWith(ServerError value, $Res Function(ServerError) _then) = _$ServerErrorCopyWithImpl;
@override @useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$ServerErrorCopyWithImpl<$Res>
    implements $ServerErrorCopyWith<$Res> {
  _$ServerErrorCopyWithImpl(this._self, this._then);

  final ServerError _self;
  final $Res Function(ServerError) _then;

/// Create a copy of AuthUserFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(ServerError(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class NetworkError implements AuthUserFailure {
  const NetworkError({this.message});
  

@override final  String? message;

/// Create a copy of AuthUserFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NetworkErrorCopyWith<NetworkError> get copyWith => _$NetworkErrorCopyWithImpl<NetworkError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AuthUserFailure.networkError(message: $message)';
}


}

/// @nodoc
abstract mixin class $NetworkErrorCopyWith<$Res> implements $AuthUserFailureCopyWith<$Res> {
  factory $NetworkErrorCopyWith(NetworkError value, $Res Function(NetworkError) _then) = _$NetworkErrorCopyWithImpl;
@override @useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$NetworkErrorCopyWithImpl<$Res>
    implements $NetworkErrorCopyWith<$Res> {
  _$NetworkErrorCopyWithImpl(this._self, this._then);

  final NetworkError _self;
  final $Res Function(NetworkError) _then;

/// Create a copy of AuthUserFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(NetworkError(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
