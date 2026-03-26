// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_account_password_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateAccountPasswordRequest {

/// Password (min 8 chars, 1 uppercase, 1 lowercase, 1 digit)
 String get confirmPassword;/// Password
 String get existingPassword;/// Password (min 8 chars, 1 uppercase, 1 lowercase, 1 digit)
 String get newPassword;/// A URL to the JSON Schema for this object.
@JsonKey(name: '\$schema') String? get schema;
/// Create a copy of UpdateAccountPasswordRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateAccountPasswordRequestCopyWith<UpdateAccountPasswordRequest> get copyWith => _$UpdateAccountPasswordRequestCopyWithImpl<UpdateAccountPasswordRequest>(this as UpdateAccountPasswordRequest, _$identity);

  /// Serializes this UpdateAccountPasswordRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateAccountPasswordRequest&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword)&&(identical(other.existingPassword, existingPassword) || other.existingPassword == existingPassword)&&(identical(other.newPassword, newPassword) || other.newPassword == newPassword)&&(identical(other.schema, schema) || other.schema == schema));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,confirmPassword,existingPassword,newPassword,schema);

@override
String toString() {
  return 'UpdateAccountPasswordRequest(confirmPassword: $confirmPassword, existingPassword: $existingPassword, newPassword: $newPassword, schema: $schema)';
}


}

/// @nodoc
abstract mixin class $UpdateAccountPasswordRequestCopyWith<$Res>  {
  factory $UpdateAccountPasswordRequestCopyWith(UpdateAccountPasswordRequest value, $Res Function(UpdateAccountPasswordRequest) _then) = _$UpdateAccountPasswordRequestCopyWithImpl;
@useResult
$Res call({
 String confirmPassword, String existingPassword, String newPassword,@JsonKey(name: '\$schema') String? schema
});




}
/// @nodoc
class _$UpdateAccountPasswordRequestCopyWithImpl<$Res>
    implements $UpdateAccountPasswordRequestCopyWith<$Res> {
  _$UpdateAccountPasswordRequestCopyWithImpl(this._self, this._then);

  final UpdateAccountPasswordRequest _self;
  final $Res Function(UpdateAccountPasswordRequest) _then;

/// Create a copy of UpdateAccountPasswordRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? confirmPassword = null,Object? existingPassword = null,Object? newPassword = null,Object? schema = freezed,}) {
  return _then(_self.copyWith(
confirmPassword: null == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String,existingPassword: null == existingPassword ? _self.existingPassword : existingPassword // ignore: cast_nullable_to_non_nullable
as String,newPassword: null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,schema: freezed == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateAccountPasswordRequest].
extension UpdateAccountPasswordRequestPatterns on UpdateAccountPasswordRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateAccountPasswordRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateAccountPasswordRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateAccountPasswordRequest value)  $default,){
final _that = this;
switch (_that) {
case _UpdateAccountPasswordRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateAccountPasswordRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateAccountPasswordRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String confirmPassword,  String existingPassword,  String newPassword, @JsonKey(name: '\$schema')  String? schema)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateAccountPasswordRequest() when $default != null:
return $default(_that.confirmPassword,_that.existingPassword,_that.newPassword,_that.schema);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String confirmPassword,  String existingPassword,  String newPassword, @JsonKey(name: '\$schema')  String? schema)  $default,) {final _that = this;
switch (_that) {
case _UpdateAccountPasswordRequest():
return $default(_that.confirmPassword,_that.existingPassword,_that.newPassword,_that.schema);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String confirmPassword,  String existingPassword,  String newPassword, @JsonKey(name: '\$schema')  String? schema)?  $default,) {final _that = this;
switch (_that) {
case _UpdateAccountPasswordRequest() when $default != null:
return $default(_that.confirmPassword,_that.existingPassword,_that.newPassword,_that.schema);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateAccountPasswordRequest implements UpdateAccountPasswordRequest {
  const _UpdateAccountPasswordRequest({required this.confirmPassword, required this.existingPassword, required this.newPassword, @JsonKey(name: '\$schema') this.schema});
  factory _UpdateAccountPasswordRequest.fromJson(Map<String, dynamic> json) => _$UpdateAccountPasswordRequestFromJson(json);

/// Password (min 8 chars, 1 uppercase, 1 lowercase, 1 digit)
@override final  String confirmPassword;
/// Password
@override final  String existingPassword;
/// Password (min 8 chars, 1 uppercase, 1 lowercase, 1 digit)
@override final  String newPassword;
/// A URL to the JSON Schema for this object.
@override@JsonKey(name: '\$schema') final  String? schema;

/// Create a copy of UpdateAccountPasswordRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateAccountPasswordRequestCopyWith<_UpdateAccountPasswordRequest> get copyWith => __$UpdateAccountPasswordRequestCopyWithImpl<_UpdateAccountPasswordRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateAccountPasswordRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateAccountPasswordRequest&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword)&&(identical(other.existingPassword, existingPassword) || other.existingPassword == existingPassword)&&(identical(other.newPassword, newPassword) || other.newPassword == newPassword)&&(identical(other.schema, schema) || other.schema == schema));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,confirmPassword,existingPassword,newPassword,schema);

@override
String toString() {
  return 'UpdateAccountPasswordRequest(confirmPassword: $confirmPassword, existingPassword: $existingPassword, newPassword: $newPassword, schema: $schema)';
}


}

/// @nodoc
abstract mixin class _$UpdateAccountPasswordRequestCopyWith<$Res> implements $UpdateAccountPasswordRequestCopyWith<$Res> {
  factory _$UpdateAccountPasswordRequestCopyWith(_UpdateAccountPasswordRequest value, $Res Function(_UpdateAccountPasswordRequest) _then) = __$UpdateAccountPasswordRequestCopyWithImpl;
@override @useResult
$Res call({
 String confirmPassword, String existingPassword, String newPassword,@JsonKey(name: '\$schema') String? schema
});




}
/// @nodoc
class __$UpdateAccountPasswordRequestCopyWithImpl<$Res>
    implements _$UpdateAccountPasswordRequestCopyWith<$Res> {
  __$UpdateAccountPasswordRequestCopyWithImpl(this._self, this._then);

  final _UpdateAccountPasswordRequest _self;
  final $Res Function(_UpdateAccountPasswordRequest) _then;

/// Create a copy of UpdateAccountPasswordRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? confirmPassword = null,Object? existingPassword = null,Object? newPassword = null,Object? schema = freezed,}) {
  return _then(_UpdateAccountPasswordRequest(
confirmPassword: null == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String,existingPassword: null == existingPassword ? _self.existingPassword : existingPassword // ignore: cast_nullable_to_non_nullable
as String,newPassword: null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,schema: freezed == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
