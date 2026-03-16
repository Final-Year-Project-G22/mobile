// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_response_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegisterResponseBody {

/// JWT access token
 String get accessToken;/// Created account
 AccountDto get account;/// When the access token expires
 DateTime get expiresAt;/// Created user
 UserDto get user;/// A URL to the JSON Schema for this object.
@JsonKey(name: '\$schema') String? get schema;
/// Create a copy of RegisterResponseBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterResponseBodyCopyWith<RegisterResponseBody> get copyWith => _$RegisterResponseBodyCopyWithImpl<RegisterResponseBody>(this as RegisterResponseBody, _$identity);

  /// Serializes this RegisterResponseBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterResponseBody&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.account, account) || other.account == account)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.user, user) || other.user == user)&&(identical(other.schema, schema) || other.schema == schema));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,account,expiresAt,user,schema);

@override
String toString() {
  return 'RegisterResponseBody(accessToken: $accessToken, account: $account, expiresAt: $expiresAt, user: $user, schema: $schema)';
}


}

/// @nodoc
abstract mixin class $RegisterResponseBodyCopyWith<$Res>  {
  factory $RegisterResponseBodyCopyWith(RegisterResponseBody value, $Res Function(RegisterResponseBody) _then) = _$RegisterResponseBodyCopyWithImpl;
@useResult
$Res call({
 String accessToken, AccountDto account, DateTime expiresAt, UserDto user,@JsonKey(name: '\$schema') String? schema
});


$AccountDtoCopyWith<$Res> get account;$UserDtoCopyWith<$Res> get user;

}
/// @nodoc
class _$RegisterResponseBodyCopyWithImpl<$Res>
    implements $RegisterResponseBodyCopyWith<$Res> {
  _$RegisterResponseBodyCopyWithImpl(this._self, this._then);

  final RegisterResponseBody _self;
  final $Res Function(RegisterResponseBody) _then;

/// Create a copy of RegisterResponseBody
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
/// Create a copy of RegisterResponseBody
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountDtoCopyWith<$Res> get account {
  
  return $AccountDtoCopyWith<$Res>(_self.account, (value) {
    return _then(_self.copyWith(account: value));
  });
}/// Create a copy of RegisterResponseBody
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDtoCopyWith<$Res> get user {
  
  return $UserDtoCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [RegisterResponseBody].
extension RegisterResponseBodyPatterns on RegisterResponseBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegisterResponseBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegisterResponseBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegisterResponseBody value)  $default,){
final _that = this;
switch (_that) {
case _RegisterResponseBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegisterResponseBody value)?  $default,){
final _that = this;
switch (_that) {
case _RegisterResponseBody() when $default != null:
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
case _RegisterResponseBody() when $default != null:
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
case _RegisterResponseBody():
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
case _RegisterResponseBody() when $default != null:
return $default(_that.accessToken,_that.account,_that.expiresAt,_that.user,_that.schema);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegisterResponseBody implements RegisterResponseBody {
  const _RegisterResponseBody({required this.accessToken, required this.account, required this.expiresAt, required this.user, @JsonKey(name: '\$schema') this.schema});
  factory _RegisterResponseBody.fromJson(Map<String, dynamic> json) => _$RegisterResponseBodyFromJson(json);

/// JWT access token
@override final  String accessToken;
/// Created account
@override final  AccountDto account;
/// When the access token expires
@override final  DateTime expiresAt;
/// Created user
@override final  UserDto user;
/// A URL to the JSON Schema for this object.
@override@JsonKey(name: '\$schema') final  String? schema;

/// Create a copy of RegisterResponseBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterResponseBodyCopyWith<_RegisterResponseBody> get copyWith => __$RegisterResponseBodyCopyWithImpl<_RegisterResponseBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegisterResponseBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterResponseBody&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.account, account) || other.account == account)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.user, user) || other.user == user)&&(identical(other.schema, schema) || other.schema == schema));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,account,expiresAt,user,schema);

@override
String toString() {
  return 'RegisterResponseBody(accessToken: $accessToken, account: $account, expiresAt: $expiresAt, user: $user, schema: $schema)';
}


}

/// @nodoc
abstract mixin class _$RegisterResponseBodyCopyWith<$Res> implements $RegisterResponseBodyCopyWith<$Res> {
  factory _$RegisterResponseBodyCopyWith(_RegisterResponseBody value, $Res Function(_RegisterResponseBody) _then) = __$RegisterResponseBodyCopyWithImpl;
@override @useResult
$Res call({
 String accessToken, AccountDto account, DateTime expiresAt, UserDto user,@JsonKey(name: '\$schema') String? schema
});


@override $AccountDtoCopyWith<$Res> get account;@override $UserDtoCopyWith<$Res> get user;

}
/// @nodoc
class __$RegisterResponseBodyCopyWithImpl<$Res>
    implements _$RegisterResponseBodyCopyWith<$Res> {
  __$RegisterResponseBodyCopyWithImpl(this._self, this._then);

  final _RegisterResponseBody _self;
  final $Res Function(_RegisterResponseBody) _then;

/// Create a copy of RegisterResponseBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accessToken = null,Object? account = null,Object? expiresAt = null,Object? user = null,Object? schema = freezed,}) {
  return _then(_RegisterResponseBody(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as AccountDto,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserDto,schema: freezed == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of RegisterResponseBody
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountDtoCopyWith<$Res> get account {
  
  return $AccountDtoCopyWith<$Res>(_self.account, (value) {
    return _then(_self.copyWith(account: value));
  });
}/// Create a copy of RegisterResponseBody
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
