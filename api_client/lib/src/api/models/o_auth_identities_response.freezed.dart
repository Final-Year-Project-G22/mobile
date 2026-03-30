// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'o_auth_identities_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OAuthIdentitiesResponse {

 List<dynamic>? get identities;/// A URL to the JSON Schema for this object.
@JsonKey(name: '\$schema') String? get schema;
/// Create a copy of OAuthIdentitiesResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OAuthIdentitiesResponseCopyWith<OAuthIdentitiesResponse> get copyWith => _$OAuthIdentitiesResponseCopyWithImpl<OAuthIdentitiesResponse>(this as OAuthIdentitiesResponse, _$identity);

  /// Serializes this OAuthIdentitiesResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OAuthIdentitiesResponse&&const DeepCollectionEquality().equals(other.identities, identities)&&(identical(other.schema, schema) || other.schema == schema));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(identities),schema);

@override
String toString() {
  return 'OAuthIdentitiesResponse(identities: $identities, schema: $schema)';
}


}

/// @nodoc
abstract mixin class $OAuthIdentitiesResponseCopyWith<$Res>  {
  factory $OAuthIdentitiesResponseCopyWith(OAuthIdentitiesResponse value, $Res Function(OAuthIdentitiesResponse) _then) = _$OAuthIdentitiesResponseCopyWithImpl;
@useResult
$Res call({
 List<dynamic>? identities,@JsonKey(name: '\$schema') String? schema
});




}
/// @nodoc
class _$OAuthIdentitiesResponseCopyWithImpl<$Res>
    implements $OAuthIdentitiesResponseCopyWith<$Res> {
  _$OAuthIdentitiesResponseCopyWithImpl(this._self, this._then);

  final OAuthIdentitiesResponse _self;
  final $Res Function(OAuthIdentitiesResponse) _then;

/// Create a copy of OAuthIdentitiesResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? identities = freezed,Object? schema = freezed,}) {
  return _then(_self.copyWith(
identities: freezed == identities ? _self.identities : identities // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,schema: freezed == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OAuthIdentitiesResponse].
extension OAuthIdentitiesResponsePatterns on OAuthIdentitiesResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OAuthIdentitiesResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OAuthIdentitiesResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OAuthIdentitiesResponse value)  $default,){
final _that = this;
switch (_that) {
case _OAuthIdentitiesResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OAuthIdentitiesResponse value)?  $default,){
final _that = this;
switch (_that) {
case _OAuthIdentitiesResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<dynamic>? identities, @JsonKey(name: '\$schema')  String? schema)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OAuthIdentitiesResponse() when $default != null:
return $default(_that.identities,_that.schema);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<dynamic>? identities, @JsonKey(name: '\$schema')  String? schema)  $default,) {final _that = this;
switch (_that) {
case _OAuthIdentitiesResponse():
return $default(_that.identities,_that.schema);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<dynamic>? identities, @JsonKey(name: '\$schema')  String? schema)?  $default,) {final _that = this;
switch (_that) {
case _OAuthIdentitiesResponse() when $default != null:
return $default(_that.identities,_that.schema);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OAuthIdentitiesResponse implements OAuthIdentitiesResponse {
  const _OAuthIdentitiesResponse({required final  List<dynamic>? identities, @JsonKey(name: '\$schema') this.schema}): _identities = identities;
  factory _OAuthIdentitiesResponse.fromJson(Map<String, dynamic> json) => _$OAuthIdentitiesResponseFromJson(json);

 final  List<dynamic>? _identities;
@override List<dynamic>? get identities {
  final value = _identities;
  if (value == null) return null;
  if (_identities is EqualUnmodifiableListView) return _identities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// A URL to the JSON Schema for this object.
@override@JsonKey(name: '\$schema') final  String? schema;

/// Create a copy of OAuthIdentitiesResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OAuthIdentitiesResponseCopyWith<_OAuthIdentitiesResponse> get copyWith => __$OAuthIdentitiesResponseCopyWithImpl<_OAuthIdentitiesResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OAuthIdentitiesResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OAuthIdentitiesResponse&&const DeepCollectionEquality().equals(other._identities, _identities)&&(identical(other.schema, schema) || other.schema == schema));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_identities),schema);

@override
String toString() {
  return 'OAuthIdentitiesResponse(identities: $identities, schema: $schema)';
}


}

/// @nodoc
abstract mixin class _$OAuthIdentitiesResponseCopyWith<$Res> implements $OAuthIdentitiesResponseCopyWith<$Res> {
  factory _$OAuthIdentitiesResponseCopyWith(_OAuthIdentitiesResponse value, $Res Function(_OAuthIdentitiesResponse) _then) = __$OAuthIdentitiesResponseCopyWithImpl;
@override @useResult
$Res call({
 List<dynamic>? identities,@JsonKey(name: '\$schema') String? schema
});




}
/// @nodoc
class __$OAuthIdentitiesResponseCopyWithImpl<$Res>
    implements _$OAuthIdentitiesResponseCopyWith<$Res> {
  __$OAuthIdentitiesResponseCopyWithImpl(this._self, this._then);

  final _OAuthIdentitiesResponse _self;
  final $Res Function(_OAuthIdentitiesResponse) _then;

/// Create a copy of OAuthIdentitiesResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? identities = freezed,Object? schema = freezed,}) {
  return _then(_OAuthIdentitiesResponse(
identities: freezed == identities ? _self._identities : identities // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,schema: freezed == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
