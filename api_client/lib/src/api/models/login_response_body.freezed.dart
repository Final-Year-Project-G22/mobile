// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_response_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoginResponseBody {

/// JWT access token
 String get accessToken;/// Authenticated account
 AccountDto get account;/// When the access token expires
 DateTime get expiresAt;/// Authenticated user
 UserDto get user;/// A URL to the JSON Schema for this object.
@JsonKey(name: '\$schema') String? get schema;
/// Create a copy of LoginResponseBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginResponseBodyCopyWith<LoginResponseBody> get copyWith => _$LoginResponseBodyCopyWithImpl<LoginResponseBody>(this as LoginResponseBody, _$identity);

  /// Serializes this LoginResponseBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginResponseBody&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.account, account) || other.account == account)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.user, user) || other.user == user)&&(identical(other.schema, schema) || other.schema == schema));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,account,expiresAt,user,schema);

@override
String toString() {
  return 'LoginResponseBody(accessToken: $accessToken, account: $account, expiresAt: $expiresAt, user: $user, schema: $schema)';
}


}

/// @nodoc
abstract mixin class $LoginResponseBodyCopyWith<$Res>  {
  factory $LoginResponseBodyCopyWith(LoginResponseBody value, $Res Function(LoginResponseBody) _then) = _$LoginResponseBodyCopyWithImpl;
@useResult
$Res call({
 String accessToken, AccountDto account, DateTime expiresAt, UserDto user,@JsonKey(name: '\$schema') String? schema
});


$AccountDtoCopyWith<$Res> get account;$UserDtoCopyWith<$Res> get user;

}
/// @nodoc
class _$LoginResponseBodyCopyWithImpl<$Res>
    implements $LoginResponseBodyCopyWith<$Res> {
  _$LoginResponseBodyCopyWithImpl(this._self, this._then);

  final LoginResponseBody _self;
  final $Res Function(LoginResponseBody) _then;

/// Create a copy of LoginResponseBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accessToken = null,Object? account = null,Object? expiresAt = null,Object? user = null,Object? schema = freezed,}) {
  return _then(_self.copyWith(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as AccountDto,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserDto,schema: freezed == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of LoginResponseBody
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountDtoCopyWith<$Res> get account {
  
  return $AccountDtoCopyWith<$Res>(_self.account, (value) {
    return _then(_self.copyWith(account: value));
  });
}/// Create a copy of LoginResponseBody
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDtoCopyWith<$Res> get user {
  
  return $UserDtoCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [LoginResponseBody].
extension LoginResponseBodyPatterns on LoginResponseBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginResponseBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginResponseBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginResponseBody value)  $default,){
final _that = this;
switch (_that) {
case _LoginResponseBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginResponseBody value)?  $default,){
final _that = this;
switch (_that) {
case _LoginResponseBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String accessToken,  AccountDto account,  DateTime expiresAt,  UserDto user, @JsonKey(name: '\$schema')  String? schema)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginResponseBody() when $default != null:
return $default(_that.accessToken,_that.account,_that.expiresAt,_that.user,_that.schema);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String accessToken,  AccountDto account,  DateTime expiresAt,  UserDto user, @JsonKey(name: '\$schema')  String? schema)  $default,) {final _that = this;
switch (_that) {
case _LoginResponseBody():
return $default(_that.accessToken,_that.account,_that.expiresAt,_that.user,_that.schema);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String accessToken,  AccountDto account,  DateTime expiresAt,  UserDto user, @JsonKey(name: '\$schema')  String? schema)?  $default,) {final _that = this;
switch (_that) {
case _LoginResponseBody() when $default != null:
return $default(_that.accessToken,_that.account,_that.expiresAt,_that.user,_that.schema);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LoginResponseBody implements LoginResponseBody {
  const _LoginResponseBody({required this.accessToken, required this.account, required this.expiresAt, required this.user, @JsonKey(name: '\$schema') this.schema});
  factory _LoginResponseBody.fromJson(Map<String, dynamic> json) => _$LoginResponseBodyFromJson(json);

/// JWT access token
@override final  String accessToken;
/// Authenticated account
@override final  AccountDto account;
/// When the access token expires
@override final  DateTime expiresAt;
/// Authenticated user
@override final  UserDto user;
/// A URL to the JSON Schema for this object.
@override@JsonKey(name: '\$schema') final  String? schema;

/// Create a copy of LoginResponseBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginResponseBodyCopyWith<_LoginResponseBody> get copyWith => __$LoginResponseBodyCopyWithImpl<_LoginResponseBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoginResponseBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginResponseBody&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.account, account) || other.account == account)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.user, user) || other.user == user)&&(identical(other.schema, schema) || other.schema == schema));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,account,expiresAt,user,schema);

@override
String toString() {
  return 'LoginResponseBody(accessToken: $accessToken, account: $account, expiresAt: $expiresAt, user: $user, schema: $schema)';
}


}

/// @nodoc
abstract mixin class _$LoginResponseBodyCopyWith<$Res> implements $LoginResponseBodyCopyWith<$Res> {
  factory _$LoginResponseBodyCopyWith(_LoginResponseBody value, $Res Function(_LoginResponseBody) _then) = __$LoginResponseBodyCopyWithImpl;
@override @useResult
$Res call({
 String accessToken, AccountDto account, DateTime expiresAt, UserDto user,@JsonKey(name: '\$schema') String? schema
});


@override $AccountDtoCopyWith<$Res> get account;@override $UserDtoCopyWith<$Res> get user;

}
/// @nodoc
class __$LoginResponseBodyCopyWithImpl<$Res>
    implements _$LoginResponseBodyCopyWith<$Res> {
  __$LoginResponseBodyCopyWithImpl(this._self, this._then);

  final _LoginResponseBody _self;
  final $Res Function(_LoginResponseBody) _then;

/// Create a copy of LoginResponseBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accessToken = null,Object? account = null,Object? expiresAt = null,Object? user = null,Object? schema = freezed,}) {
  return _then(_LoginResponseBody(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as AccountDto,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserDto,schema: freezed == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of LoginResponseBody
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountDtoCopyWith<$Res> get account {
  
  return $AccountDtoCopyWith<$Res>(_self.account, (value) {
    return _then(_self.copyWith(account: value));
  });
}/// Create a copy of LoginResponseBody
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDtoCopyWith<$Res> get user {
  
  return $UserDtoCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
