// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_user_profile_response_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateUserProfileResponseBody {

/// Bio
 String get bio;/// First name
 String get firstName;/// Last name
 String get lastName;/// A URL to the JSON Schema for this object.
@JsonKey(name: '\$schema') String? get schema;
/// Create a copy of UpdateUserProfileResponseBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateUserProfileResponseBodyCopyWith<UpdateUserProfileResponseBody> get copyWith => _$UpdateUserProfileResponseBodyCopyWithImpl<UpdateUserProfileResponseBody>(this as UpdateUserProfileResponseBody, _$identity);

  /// Serializes this UpdateUserProfileResponseBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateUserProfileResponseBody&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.schema, schema) || other.schema == schema));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bio,firstName,lastName,schema);

@override
String toString() {
  return 'UpdateUserProfileResponseBody(bio: $bio, firstName: $firstName, lastName: $lastName, schema: $schema)';
}


}

/// @nodoc
abstract mixin class $UpdateUserProfileResponseBodyCopyWith<$Res>  {
  factory $UpdateUserProfileResponseBodyCopyWith(UpdateUserProfileResponseBody value, $Res Function(UpdateUserProfileResponseBody) _then) = _$UpdateUserProfileResponseBodyCopyWithImpl;
@useResult
$Res call({
 String bio, String firstName, String lastName,@JsonKey(name: '\$schema') String? schema
});




}
/// @nodoc
class _$UpdateUserProfileResponseBodyCopyWithImpl<$Res>
    implements $UpdateUserProfileResponseBodyCopyWith<$Res> {
  _$UpdateUserProfileResponseBodyCopyWithImpl(this._self, this._then);

  final UpdateUserProfileResponseBody _self;
  final $Res Function(UpdateUserProfileResponseBody) _then;

/// Create a copy of UpdateUserProfileResponseBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bio = null,Object? firstName = null,Object? lastName = null,Object? schema = freezed,}) {
  return _then(_self.copyWith(
bio: null == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,schema: freezed == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateUserProfileResponseBody].
extension UpdateUserProfileResponseBodyPatterns on UpdateUserProfileResponseBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateUserProfileResponseBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateUserProfileResponseBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateUserProfileResponseBody value)  $default,){
final _that = this;
switch (_that) {
case _UpdateUserProfileResponseBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateUserProfileResponseBody value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateUserProfileResponseBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String bio,  String firstName,  String lastName, @JsonKey(name: '\$schema')  String? schema)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateUserProfileResponseBody() when $default != null:
return $default(_that.bio,_that.firstName,_that.lastName,_that.schema);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String bio,  String firstName,  String lastName, @JsonKey(name: '\$schema')  String? schema)  $default,) {final _that = this;
switch (_that) {
case _UpdateUserProfileResponseBody():
return $default(_that.bio,_that.firstName,_that.lastName,_that.schema);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String bio,  String firstName,  String lastName, @JsonKey(name: '\$schema')  String? schema)?  $default,) {final _that = this;
switch (_that) {
case _UpdateUserProfileResponseBody() when $default != null:
return $default(_that.bio,_that.firstName,_that.lastName,_that.schema);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateUserProfileResponseBody implements UpdateUserProfileResponseBody {
  const _UpdateUserProfileResponseBody({required this.bio, required this.firstName, required this.lastName, @JsonKey(name: '\$schema') this.schema});
  factory _UpdateUserProfileResponseBody.fromJson(Map<String, dynamic> json) => _$UpdateUserProfileResponseBodyFromJson(json);

/// Bio
@override final  String bio;
/// First name
@override final  String firstName;
/// Last name
@override final  String lastName;
/// A URL to the JSON Schema for this object.
@override@JsonKey(name: '\$schema') final  String? schema;

/// Create a copy of UpdateUserProfileResponseBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateUserProfileResponseBodyCopyWith<_UpdateUserProfileResponseBody> get copyWith => __$UpdateUserProfileResponseBodyCopyWithImpl<_UpdateUserProfileResponseBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateUserProfileResponseBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateUserProfileResponseBody&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.schema, schema) || other.schema == schema));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bio,firstName,lastName,schema);

@override
String toString() {
  return 'UpdateUserProfileResponseBody(bio: $bio, firstName: $firstName, lastName: $lastName, schema: $schema)';
}


}

/// @nodoc
abstract mixin class _$UpdateUserProfileResponseBodyCopyWith<$Res> implements $UpdateUserProfileResponseBodyCopyWith<$Res> {
  factory _$UpdateUserProfileResponseBodyCopyWith(_UpdateUserProfileResponseBody value, $Res Function(_UpdateUserProfileResponseBody) _then) = __$UpdateUserProfileResponseBodyCopyWithImpl;
@override @useResult
$Res call({
 String bio, String firstName, String lastName,@JsonKey(name: '\$schema') String? schema
});




}
/// @nodoc
class __$UpdateUserProfileResponseBodyCopyWithImpl<$Res>
    implements _$UpdateUserProfileResponseBodyCopyWith<$Res> {
  __$UpdateUserProfileResponseBodyCopyWithImpl(this._self, this._then);

  final _UpdateUserProfileResponseBody _self;
  final $Res Function(_UpdateUserProfileResponseBody) _then;

/// Create a copy of UpdateUserProfileResponseBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bio = null,Object? firstName = null,Object? lastName = null,Object? schema = freezed,}) {
  return _then(_UpdateUserProfileResponseBody(
bio: null == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,schema: freezed == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
