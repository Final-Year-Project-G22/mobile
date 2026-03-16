// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'refresh_response_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RefreshResponseBody {

/// New JWT access token
 String get accessToken;/// When the access token expires
 DateTime get expiresAt;/// A URL to the JSON Schema for this object.
@JsonKey(name: '\$schema') String? get schema;
/// Create a copy of RefreshResponseBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RefreshResponseBodyCopyWith<RefreshResponseBody> get copyWith => _$RefreshResponseBodyCopyWithImpl<RefreshResponseBody>(this as RefreshResponseBody, _$identity);

  /// Serializes this RefreshResponseBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshResponseBody&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.schema, schema) || other.schema == schema));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,expiresAt,schema);

@override
String toString() {
  return 'RefreshResponseBody(accessToken: $accessToken, expiresAt: $expiresAt, schema: $schema)';
}


}

/// @nodoc
abstract mixin class $RefreshResponseBodyCopyWith<$Res>  {
  factory $RefreshResponseBodyCopyWith(RefreshResponseBody value, $Res Function(RefreshResponseBody) _then) = _$RefreshResponseBodyCopyWithImpl;
@useResult
$Res call({
 String accessToken, DateTime expiresAt,@JsonKey(name: '\$schema') String? schema
});




}
/// @nodoc
class _$RefreshResponseBodyCopyWithImpl<$Res>
    implements $RefreshResponseBodyCopyWith<$Res> {
  _$RefreshResponseBodyCopyWithImpl(this._self, this._then);

  final RefreshResponseBody _self;
  final $Res Function(RefreshResponseBody) _then;

/// Create a copy of RefreshResponseBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accessToken = null,Object? expiresAt = null,Object? schema = freezed,}) {
  return _then(_self.copyWith(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,schema: freezed == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RefreshResponseBody].
extension RefreshResponseBodyPatterns on RefreshResponseBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RefreshResponseBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RefreshResponseBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RefreshResponseBody value)  $default,){
final _that = this;
switch (_that) {
case _RefreshResponseBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RefreshResponseBody value)?  $default,){
final _that = this;
switch (_that) {
case _RefreshResponseBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String accessToken,  DateTime expiresAt, @JsonKey(name: '\$schema')  String? schema)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RefreshResponseBody() when $default != null:
return $default(_that.accessToken,_that.expiresAt,_that.schema);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String accessToken,  DateTime expiresAt, @JsonKey(name: '\$schema')  String? schema)  $default,) {final _that = this;
switch (_that) {
case _RefreshResponseBody():
return $default(_that.accessToken,_that.expiresAt,_that.schema);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String accessToken,  DateTime expiresAt, @JsonKey(name: '\$schema')  String? schema)?  $default,) {final _that = this;
switch (_that) {
case _RefreshResponseBody() when $default != null:
return $default(_that.accessToken,_that.expiresAt,_that.schema);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RefreshResponseBody implements RefreshResponseBody {
  const _RefreshResponseBody({required this.accessToken, required this.expiresAt, @JsonKey(name: '\$schema') this.schema});
  factory _RefreshResponseBody.fromJson(Map<String, dynamic> json) => _$RefreshResponseBodyFromJson(json);

/// New JWT access token
@override final  String accessToken;
/// When the access token expires
@override final  DateTime expiresAt;
/// A URL to the JSON Schema for this object.
@override@JsonKey(name: '\$schema') final  String? schema;

/// Create a copy of RefreshResponseBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RefreshResponseBodyCopyWith<_RefreshResponseBody> get copyWith => __$RefreshResponseBodyCopyWithImpl<_RefreshResponseBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RefreshResponseBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshResponseBody&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.schema, schema) || other.schema == schema));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,expiresAt,schema);

@override
String toString() {
  return 'RefreshResponseBody(accessToken: $accessToken, expiresAt: $expiresAt, schema: $schema)';
}


}

/// @nodoc
abstract mixin class _$RefreshResponseBodyCopyWith<$Res> implements $RefreshResponseBodyCopyWith<$Res> {
  factory _$RefreshResponseBodyCopyWith(_RefreshResponseBody value, $Res Function(_RefreshResponseBody) _then) = __$RefreshResponseBodyCopyWithImpl;
@override @useResult
$Res call({
 String accessToken, DateTime expiresAt,@JsonKey(name: '\$schema') String? schema
});




}
/// @nodoc
class __$RefreshResponseBodyCopyWithImpl<$Res>
    implements _$RefreshResponseBodyCopyWith<$Res> {
  __$RefreshResponseBodyCopyWithImpl(this._self, this._then);

  final _RefreshResponseBody _self;
  final $Res Function(_RefreshResponseBody) _then;

/// Create a copy of RefreshResponseBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accessToken = null,Object? expiresAt = null,Object? schema = freezed,}) {
  return _then(_RefreshResponseBody(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,schema: freezed == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
