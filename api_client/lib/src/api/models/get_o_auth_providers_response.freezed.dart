// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_o_auth_providers_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GetOAuthProvidersResponse {

 List<dynamic>? get providers;/// A URL to the JSON Schema for this object.
@JsonKey(name: '\$schema') String? get schema;
/// Create a copy of GetOAuthProvidersResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetOAuthProvidersResponseCopyWith<GetOAuthProvidersResponse> get copyWith => _$GetOAuthProvidersResponseCopyWithImpl<GetOAuthProvidersResponse>(this as GetOAuthProvidersResponse, _$identity);

  /// Serializes this GetOAuthProvidersResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetOAuthProvidersResponse&&const DeepCollectionEquality().equals(other.providers, providers)&&(identical(other.schema, schema) || other.schema == schema));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(providers),schema);

@override
String toString() {
  return 'GetOAuthProvidersResponse(providers: $providers, schema: $schema)';
}


}

/// @nodoc
abstract mixin class $GetOAuthProvidersResponseCopyWith<$Res>  {
  factory $GetOAuthProvidersResponseCopyWith(GetOAuthProvidersResponse value, $Res Function(GetOAuthProvidersResponse) _then) = _$GetOAuthProvidersResponseCopyWithImpl;
@useResult
$Res call({
 List<dynamic>? providers,@JsonKey(name: '\$schema') String? schema
});




}
/// @nodoc
class _$GetOAuthProvidersResponseCopyWithImpl<$Res>
    implements $GetOAuthProvidersResponseCopyWith<$Res> {
  _$GetOAuthProvidersResponseCopyWithImpl(this._self, this._then);

  final GetOAuthProvidersResponse _self;
  final $Res Function(GetOAuthProvidersResponse) _then;

/// Create a copy of GetOAuthProvidersResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? providers = freezed,Object? schema = freezed,}) {
  return _then(_self.copyWith(
providers: freezed == providers ? _self.providers : providers // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,schema: freezed == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GetOAuthProvidersResponse].
extension GetOAuthProvidersResponsePatterns on GetOAuthProvidersResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetOAuthProvidersResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetOAuthProvidersResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetOAuthProvidersResponse value)  $default,){
final _that = this;
switch (_that) {
case _GetOAuthProvidersResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetOAuthProvidersResponse value)?  $default,){
final _that = this;
switch (_that) {
case _GetOAuthProvidersResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<dynamic>? providers, @JsonKey(name: '\$schema')  String? schema)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetOAuthProvidersResponse() when $default != null:
return $default(_that.providers,_that.schema);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<dynamic>? providers, @JsonKey(name: '\$schema')  String? schema)  $default,) {final _that = this;
switch (_that) {
case _GetOAuthProvidersResponse():
return $default(_that.providers,_that.schema);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<dynamic>? providers, @JsonKey(name: '\$schema')  String? schema)?  $default,) {final _that = this;
switch (_that) {
case _GetOAuthProvidersResponse() when $default != null:
return $default(_that.providers,_that.schema);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetOAuthProvidersResponse implements GetOAuthProvidersResponse {
  const _GetOAuthProvidersResponse({required final  List<dynamic>? providers, @JsonKey(name: '\$schema') this.schema}): _providers = providers;
  factory _GetOAuthProvidersResponse.fromJson(Map<String, dynamic> json) => _$GetOAuthProvidersResponseFromJson(json);

 final  List<dynamic>? _providers;
@override List<dynamic>? get providers {
  final value = _providers;
  if (value == null) return null;
  if (_providers is EqualUnmodifiableListView) return _providers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// A URL to the JSON Schema for this object.
@override@JsonKey(name: '\$schema') final  String? schema;

/// Create a copy of GetOAuthProvidersResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetOAuthProvidersResponseCopyWith<_GetOAuthProvidersResponse> get copyWith => __$GetOAuthProvidersResponseCopyWithImpl<_GetOAuthProvidersResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetOAuthProvidersResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetOAuthProvidersResponse&&const DeepCollectionEquality().equals(other._providers, _providers)&&(identical(other.schema, schema) || other.schema == schema));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_providers),schema);

@override
String toString() {
  return 'GetOAuthProvidersResponse(providers: $providers, schema: $schema)';
}


}

/// @nodoc
abstract mixin class _$GetOAuthProvidersResponseCopyWith<$Res> implements $GetOAuthProvidersResponseCopyWith<$Res> {
  factory _$GetOAuthProvidersResponseCopyWith(_GetOAuthProvidersResponse value, $Res Function(_GetOAuthProvidersResponse) _then) = __$GetOAuthProvidersResponseCopyWithImpl;
@override @useResult
$Res call({
 List<dynamic>? providers,@JsonKey(name: '\$schema') String? schema
});




}
/// @nodoc
class __$GetOAuthProvidersResponseCopyWithImpl<$Res>
    implements _$GetOAuthProvidersResponseCopyWith<$Res> {
  __$GetOAuthProvidersResponseCopyWithImpl(this._self, this._then);

  final _GetOAuthProvidersResponse _self;
  final $Res Function(_GetOAuthProvidersResponse) _then;

/// Create a copy of GetOAuthProvidersResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? providers = freezed,Object? schema = freezed,}) {
  return _then(_GetOAuthProvidersResponse(
providers: freezed == providers ? _self._providers : providers // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,schema: freezed == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
