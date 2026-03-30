// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_current_user_response_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GetCurrentUserResponseBody {

/// Current user account
 AccountDto get account;/// Current user
 UserDto get user;/// A URL to the JSON Schema for this object.
@JsonKey(name: '\$schema') String? get schema;
/// Create a copy of GetCurrentUserResponseBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetCurrentUserResponseBodyCopyWith<GetCurrentUserResponseBody> get copyWith => _$GetCurrentUserResponseBodyCopyWithImpl<GetCurrentUserResponseBody>(this as GetCurrentUserResponseBody, _$identity);

  /// Serializes this GetCurrentUserResponseBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetCurrentUserResponseBody&&(identical(other.account, account) || other.account == account)&&(identical(other.user, user) || other.user == user)&&(identical(other.schema, schema) || other.schema == schema));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,account,user,schema);

@override
String toString() {
  return 'GetCurrentUserResponseBody(account: $account, user: $user, schema: $schema)';
}


}

/// @nodoc
abstract mixin class $GetCurrentUserResponseBodyCopyWith<$Res>  {
  factory $GetCurrentUserResponseBodyCopyWith(GetCurrentUserResponseBody value, $Res Function(GetCurrentUserResponseBody) _then) = _$GetCurrentUserResponseBodyCopyWithImpl;
@useResult
$Res call({
 AccountDto account, UserDto user,@JsonKey(name: '\$schema') String? schema
});


$AccountDtoCopyWith<$Res> get account;$UserDtoCopyWith<$Res> get user;

}
/// @nodoc
class _$GetCurrentUserResponseBodyCopyWithImpl<$Res>
    implements $GetCurrentUserResponseBodyCopyWith<$Res> {
  _$GetCurrentUserResponseBodyCopyWithImpl(this._self, this._then);

  final GetCurrentUserResponseBody _self;
  final $Res Function(GetCurrentUserResponseBody) _then;

/// Create a copy of GetCurrentUserResponseBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? account = null,Object? user = null,Object? schema = freezed,}) {
  return _then(_self.copyWith(
account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as AccountDto,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserDto,schema: freezed == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of GetCurrentUserResponseBody
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountDtoCopyWith<$Res> get account {
  
  return $AccountDtoCopyWith<$Res>(_self.account, (value) {
    return _then(_self.copyWith(account: value));
  });
}/// Create a copy of GetCurrentUserResponseBody
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDtoCopyWith<$Res> get user {
  
  return $UserDtoCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [GetCurrentUserResponseBody].
extension GetCurrentUserResponseBodyPatterns on GetCurrentUserResponseBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetCurrentUserResponseBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetCurrentUserResponseBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetCurrentUserResponseBody value)  $default,){
final _that = this;
switch (_that) {
case _GetCurrentUserResponseBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetCurrentUserResponseBody value)?  $default,){
final _that = this;
switch (_that) {
case _GetCurrentUserResponseBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AccountDto account,  UserDto user, @JsonKey(name: '\$schema')  String? schema)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetCurrentUserResponseBody() when $default != null:
return $default(_that.account,_that.user,_that.schema);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AccountDto account,  UserDto user, @JsonKey(name: '\$schema')  String? schema)  $default,) {final _that = this;
switch (_that) {
case _GetCurrentUserResponseBody():
return $default(_that.account,_that.user,_that.schema);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AccountDto account,  UserDto user, @JsonKey(name: '\$schema')  String? schema)?  $default,) {final _that = this;
switch (_that) {
case _GetCurrentUserResponseBody() when $default != null:
return $default(_that.account,_that.user,_that.schema);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetCurrentUserResponseBody implements GetCurrentUserResponseBody {
  const _GetCurrentUserResponseBody({required this.account, required this.user, @JsonKey(name: '\$schema') this.schema});
  factory _GetCurrentUserResponseBody.fromJson(Map<String, dynamic> json) => _$GetCurrentUserResponseBodyFromJson(json);

/// Current user account
@override final  AccountDto account;
/// Current user
@override final  UserDto user;
/// A URL to the JSON Schema for this object.
@override@JsonKey(name: '\$schema') final  String? schema;

/// Create a copy of GetCurrentUserResponseBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetCurrentUserResponseBodyCopyWith<_GetCurrentUserResponseBody> get copyWith => __$GetCurrentUserResponseBodyCopyWithImpl<_GetCurrentUserResponseBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetCurrentUserResponseBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetCurrentUserResponseBody&&(identical(other.account, account) || other.account == account)&&(identical(other.user, user) || other.user == user)&&(identical(other.schema, schema) || other.schema == schema));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,account,user,schema);

@override
String toString() {
  return 'GetCurrentUserResponseBody(account: $account, user: $user, schema: $schema)';
}


}

/// @nodoc
abstract mixin class _$GetCurrentUserResponseBodyCopyWith<$Res> implements $GetCurrentUserResponseBodyCopyWith<$Res> {
  factory _$GetCurrentUserResponseBodyCopyWith(_GetCurrentUserResponseBody value, $Res Function(_GetCurrentUserResponseBody) _then) = __$GetCurrentUserResponseBodyCopyWithImpl;
@override @useResult
$Res call({
 AccountDto account, UserDto user,@JsonKey(name: '\$schema') String? schema
});


@override $AccountDtoCopyWith<$Res> get account;@override $UserDtoCopyWith<$Res> get user;

}
/// @nodoc
class __$GetCurrentUserResponseBodyCopyWithImpl<$Res>
    implements _$GetCurrentUserResponseBodyCopyWith<$Res> {
  __$GetCurrentUserResponseBodyCopyWithImpl(this._self, this._then);

  final _GetCurrentUserResponseBody _self;
  final $Res Function(_GetCurrentUserResponseBody) _then;

/// Create a copy of GetCurrentUserResponseBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? account = null,Object? user = null,Object? schema = freezed,}) {
  return _then(_GetCurrentUserResponseBody(
account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as AccountDto,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserDto,schema: freezed == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of GetCurrentUserResponseBody
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountDtoCopyWith<$Res> get account {
  
  return $AccountDtoCopyWith<$Res>(_self.account, (value) {
    return _then(_self.copyWith(account: value));
  });
}/// Create a copy of GetCurrentUserResponseBody
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
