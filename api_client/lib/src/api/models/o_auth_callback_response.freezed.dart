// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'o_auth_callback_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OAuthCallbackResponse {

/// A URL to the JSON Schema for this object.
@JsonKey(name: '\$schema') String? get schema; String? get accessToken; AccountDto? get account; OAuthEmailRequiredResponse? get emailRequired; DateTime? get expiresAt; bool? get isNewUser; String? get refreshToken; UserDto? get user;
/// Create a copy of OAuthCallbackResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OAuthCallbackResponseCopyWith<OAuthCallbackResponse> get copyWith => _$OAuthCallbackResponseCopyWithImpl<OAuthCallbackResponse>(this as OAuthCallbackResponse, _$identity);

  /// Serializes this OAuthCallbackResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OAuthCallbackResponse&&(identical(other.schema, schema) || other.schema == schema)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.account, account) || other.account == account)&&(identical(other.emailRequired, emailRequired) || other.emailRequired == emailRequired)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.isNewUser, isNewUser) || other.isNewUser == isNewUser)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schema,accessToken,account,emailRequired,expiresAt,isNewUser,refreshToken,user);

@override
String toString() {
  return 'OAuthCallbackResponse(schema: $schema, accessToken: $accessToken, account: $account, emailRequired: $emailRequired, expiresAt: $expiresAt, isNewUser: $isNewUser, refreshToken: $refreshToken, user: $user)';
}


}

/// @nodoc
abstract mixin class $OAuthCallbackResponseCopyWith<$Res>  {
  factory $OAuthCallbackResponseCopyWith(OAuthCallbackResponse value, $Res Function(OAuthCallbackResponse) _then) = _$OAuthCallbackResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: '\$schema') String? schema, String? accessToken, AccountDto? account, OAuthEmailRequiredResponse? emailRequired, DateTime? expiresAt, bool? isNewUser, String? refreshToken, UserDto? user
});


$AccountDtoCopyWith<$Res>? get account;$OAuthEmailRequiredResponseCopyWith<$Res>? get emailRequired;$UserDtoCopyWith<$Res>? get user;

}
/// @nodoc
class _$OAuthCallbackResponseCopyWithImpl<$Res>
    implements $OAuthCallbackResponseCopyWith<$Res> {
  _$OAuthCallbackResponseCopyWithImpl(this._self, this._then);

  final OAuthCallbackResponse _self;
  final $Res Function(OAuthCallbackResponse) _then;

/// Create a copy of OAuthCallbackResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schema = freezed,Object? accessToken = freezed,Object? account = freezed,Object? emailRequired = freezed,Object? expiresAt = freezed,Object? isNewUser = freezed,Object? refreshToken = freezed,Object? user = freezed,}) {
  return _then(_self.copyWith(
schema: freezed == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String?,accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,account: freezed == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as AccountDto?,emailRequired: freezed == emailRequired ? _self.emailRequired : emailRequired // ignore: cast_nullable_to_non_nullable
as OAuthEmailRequiredResponse?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isNewUser: freezed == isNewUser ? _self.isNewUser : isNewUser // ignore: cast_nullable_to_non_nullable
as bool?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserDto?,
  ));
}
/// Create a copy of OAuthCallbackResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountDtoCopyWith<$Res>? get account {
    if (_self.account == null) {
    return null;
  }

  return $AccountDtoCopyWith<$Res>(_self.account!, (value) {
    return _then(_self.copyWith(account: value));
  });
}/// Create a copy of OAuthCallbackResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OAuthEmailRequiredResponseCopyWith<$Res>? get emailRequired {
    if (_self.emailRequired == null) {
    return null;
  }

  return $OAuthEmailRequiredResponseCopyWith<$Res>(_self.emailRequired!, (value) {
    return _then(_self.copyWith(emailRequired: value));
  });
}/// Create a copy of OAuthCallbackResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDtoCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserDtoCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [OAuthCallbackResponse].
extension OAuthCallbackResponsePatterns on OAuthCallbackResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OAuthCallbackResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OAuthCallbackResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OAuthCallbackResponse value)  $default,){
final _that = this;
switch (_that) {
case _OAuthCallbackResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OAuthCallbackResponse value)?  $default,){
final _that = this;
switch (_that) {
case _OAuthCallbackResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: '\$schema')  String? schema,  String? accessToken,  AccountDto? account,  OAuthEmailRequiredResponse? emailRequired,  DateTime? expiresAt,  bool? isNewUser,  String? refreshToken,  UserDto? user)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OAuthCallbackResponse() when $default != null:
return $default(_that.schema,_that.accessToken,_that.account,_that.emailRequired,_that.expiresAt,_that.isNewUser,_that.refreshToken,_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: '\$schema')  String? schema,  String? accessToken,  AccountDto? account,  OAuthEmailRequiredResponse? emailRequired,  DateTime? expiresAt,  bool? isNewUser,  String? refreshToken,  UserDto? user)  $default,) {final _that = this;
switch (_that) {
case _OAuthCallbackResponse():
return $default(_that.schema,_that.accessToken,_that.account,_that.emailRequired,_that.expiresAt,_that.isNewUser,_that.refreshToken,_that.user);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: '\$schema')  String? schema,  String? accessToken,  AccountDto? account,  OAuthEmailRequiredResponse? emailRequired,  DateTime? expiresAt,  bool? isNewUser,  String? refreshToken,  UserDto? user)?  $default,) {final _that = this;
switch (_that) {
case _OAuthCallbackResponse() when $default != null:
return $default(_that.schema,_that.accessToken,_that.account,_that.emailRequired,_that.expiresAt,_that.isNewUser,_that.refreshToken,_that.user);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OAuthCallbackResponse implements OAuthCallbackResponse {
  const _OAuthCallbackResponse({@JsonKey(name: '\$schema') this.schema, this.accessToken, this.account, this.emailRequired, this.expiresAt, this.isNewUser, this.refreshToken, this.user});
  factory _OAuthCallbackResponse.fromJson(Map<String, dynamic> json) => _$OAuthCallbackResponseFromJson(json);

/// A URL to the JSON Schema for this object.
@override@JsonKey(name: '\$schema') final  String? schema;
@override final  String? accessToken;
@override final  AccountDto? account;
@override final  OAuthEmailRequiredResponse? emailRequired;
@override final  DateTime? expiresAt;
@override final  bool? isNewUser;
@override final  String? refreshToken;
@override final  UserDto? user;

/// Create a copy of OAuthCallbackResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OAuthCallbackResponseCopyWith<_OAuthCallbackResponse> get copyWith => __$OAuthCallbackResponseCopyWithImpl<_OAuthCallbackResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OAuthCallbackResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OAuthCallbackResponse&&(identical(other.schema, schema) || other.schema == schema)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.account, account) || other.account == account)&&(identical(other.emailRequired, emailRequired) || other.emailRequired == emailRequired)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.isNewUser, isNewUser) || other.isNewUser == isNewUser)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schema,accessToken,account,emailRequired,expiresAt,isNewUser,refreshToken,user);

@override
String toString() {
  return 'OAuthCallbackResponse(schema: $schema, accessToken: $accessToken, account: $account, emailRequired: $emailRequired, expiresAt: $expiresAt, isNewUser: $isNewUser, refreshToken: $refreshToken, user: $user)';
}


}

/// @nodoc
abstract mixin class _$OAuthCallbackResponseCopyWith<$Res> implements $OAuthCallbackResponseCopyWith<$Res> {
  factory _$OAuthCallbackResponseCopyWith(_OAuthCallbackResponse value, $Res Function(_OAuthCallbackResponse) _then) = __$OAuthCallbackResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: '\$schema') String? schema, String? accessToken, AccountDto? account, OAuthEmailRequiredResponse? emailRequired, DateTime? expiresAt, bool? isNewUser, String? refreshToken, UserDto? user
});


@override $AccountDtoCopyWith<$Res>? get account;@override $OAuthEmailRequiredResponseCopyWith<$Res>? get emailRequired;@override $UserDtoCopyWith<$Res>? get user;

}
/// @nodoc
class __$OAuthCallbackResponseCopyWithImpl<$Res>
    implements _$OAuthCallbackResponseCopyWith<$Res> {
  __$OAuthCallbackResponseCopyWithImpl(this._self, this._then);

  final _OAuthCallbackResponse _self;
  final $Res Function(_OAuthCallbackResponse) _then;

/// Create a copy of OAuthCallbackResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schema = freezed,Object? accessToken = freezed,Object? account = freezed,Object? emailRequired = freezed,Object? expiresAt = freezed,Object? isNewUser = freezed,Object? refreshToken = freezed,Object? user = freezed,}) {
  return _then(_OAuthCallbackResponse(
schema: freezed == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String?,accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,account: freezed == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as AccountDto?,emailRequired: freezed == emailRequired ? _self.emailRequired : emailRequired // ignore: cast_nullable_to_non_nullable
as OAuthEmailRequiredResponse?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isNewUser: freezed == isNewUser ? _self.isNewUser : isNewUser // ignore: cast_nullable_to_non_nullable
as bool?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserDto?,
  ));
}

/// Create a copy of OAuthCallbackResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountDtoCopyWith<$Res>? get account {
    if (_self.account == null) {
    return null;
  }

  return $AccountDtoCopyWith<$Res>(_self.account!, (value) {
    return _then(_self.copyWith(account: value));
  });
}/// Create a copy of OAuthCallbackResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OAuthEmailRequiredResponseCopyWith<$Res>? get emailRequired {
    if (_self.emailRequired == null) {
    return null;
  }

  return $OAuthEmailRequiredResponseCopyWith<$Res>(_self.emailRequired!, (value) {
    return _then(_self.copyWith(emailRequired: value));
  });
}/// Create a copy of OAuthCallbackResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDtoCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserDtoCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
