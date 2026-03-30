// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'o_auth_identity_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OAuthIdentityDto {

 String get provider; DateTime? get lastUsedAt; DateTime? get linkedAt; String? get providerEmail;
/// Create a copy of OAuthIdentityDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OAuthIdentityDtoCopyWith<OAuthIdentityDto> get copyWith => _$OAuthIdentityDtoCopyWithImpl<OAuthIdentityDto>(this as OAuthIdentityDto, _$identity);

  /// Serializes this OAuthIdentityDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OAuthIdentityDto&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.lastUsedAt, lastUsedAt) || other.lastUsedAt == lastUsedAt)&&(identical(other.linkedAt, linkedAt) || other.linkedAt == linkedAt)&&(identical(other.providerEmail, providerEmail) || other.providerEmail == providerEmail));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,provider,lastUsedAt,linkedAt,providerEmail);

@override
String toString() {
  return 'OAuthIdentityDto(provider: $provider, lastUsedAt: $lastUsedAt, linkedAt: $linkedAt, providerEmail: $providerEmail)';
}


}

/// @nodoc
abstract mixin class $OAuthIdentityDtoCopyWith<$Res>  {
  factory $OAuthIdentityDtoCopyWith(OAuthIdentityDto value, $Res Function(OAuthIdentityDto) _then) = _$OAuthIdentityDtoCopyWithImpl;
@useResult
$Res call({
 String provider, DateTime? lastUsedAt, DateTime? linkedAt, String? providerEmail
});




}
/// @nodoc
class _$OAuthIdentityDtoCopyWithImpl<$Res>
    implements $OAuthIdentityDtoCopyWith<$Res> {
  _$OAuthIdentityDtoCopyWithImpl(this._self, this._then);

  final OAuthIdentityDto _self;
  final $Res Function(OAuthIdentityDto) _then;

/// Create a copy of OAuthIdentityDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? provider = null,Object? lastUsedAt = freezed,Object? linkedAt = freezed,Object? providerEmail = freezed,}) {
  return _then(_self.copyWith(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,lastUsedAt: freezed == lastUsedAt ? _self.lastUsedAt : lastUsedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,linkedAt: freezed == linkedAt ? _self.linkedAt : linkedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,providerEmail: freezed == providerEmail ? _self.providerEmail : providerEmail // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OAuthIdentityDto].
extension OAuthIdentityDtoPatterns on OAuthIdentityDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OAuthIdentityDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OAuthIdentityDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OAuthIdentityDto value)  $default,){
final _that = this;
switch (_that) {
case _OAuthIdentityDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OAuthIdentityDto value)?  $default,){
final _that = this;
switch (_that) {
case _OAuthIdentityDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String provider,  DateTime? lastUsedAt,  DateTime? linkedAt,  String? providerEmail)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OAuthIdentityDto() when $default != null:
return $default(_that.provider,_that.lastUsedAt,_that.linkedAt,_that.providerEmail);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String provider,  DateTime? lastUsedAt,  DateTime? linkedAt,  String? providerEmail)  $default,) {final _that = this;
switch (_that) {
case _OAuthIdentityDto():
return $default(_that.provider,_that.lastUsedAt,_that.linkedAt,_that.providerEmail);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String provider,  DateTime? lastUsedAt,  DateTime? linkedAt,  String? providerEmail)?  $default,) {final _that = this;
switch (_that) {
case _OAuthIdentityDto() when $default != null:
return $default(_that.provider,_that.lastUsedAt,_that.linkedAt,_that.providerEmail);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OAuthIdentityDto implements OAuthIdentityDto {
  const _OAuthIdentityDto({required this.provider, this.lastUsedAt, this.linkedAt, this.providerEmail});
  factory _OAuthIdentityDto.fromJson(Map<String, dynamic> json) => _$OAuthIdentityDtoFromJson(json);

@override final  String provider;
@override final  DateTime? lastUsedAt;
@override final  DateTime? linkedAt;
@override final  String? providerEmail;

/// Create a copy of OAuthIdentityDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OAuthIdentityDtoCopyWith<_OAuthIdentityDto> get copyWith => __$OAuthIdentityDtoCopyWithImpl<_OAuthIdentityDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OAuthIdentityDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OAuthIdentityDto&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.lastUsedAt, lastUsedAt) || other.lastUsedAt == lastUsedAt)&&(identical(other.linkedAt, linkedAt) || other.linkedAt == linkedAt)&&(identical(other.providerEmail, providerEmail) || other.providerEmail == providerEmail));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,provider,lastUsedAt,linkedAt,providerEmail);

@override
String toString() {
  return 'OAuthIdentityDto(provider: $provider, lastUsedAt: $lastUsedAt, linkedAt: $linkedAt, providerEmail: $providerEmail)';
}


}

/// @nodoc
abstract mixin class _$OAuthIdentityDtoCopyWith<$Res> implements $OAuthIdentityDtoCopyWith<$Res> {
  factory _$OAuthIdentityDtoCopyWith(_OAuthIdentityDto value, $Res Function(_OAuthIdentityDto) _then) = __$OAuthIdentityDtoCopyWithImpl;
@override @useResult
$Res call({
 String provider, DateTime? lastUsedAt, DateTime? linkedAt, String? providerEmail
});




}
/// @nodoc
class __$OAuthIdentityDtoCopyWithImpl<$Res>
    implements _$OAuthIdentityDtoCopyWith<$Res> {
  __$OAuthIdentityDtoCopyWithImpl(this._self, this._then);

  final _OAuthIdentityDto _self;
  final $Res Function(_OAuthIdentityDto) _then;

/// Create a copy of OAuthIdentityDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? provider = null,Object? lastUsedAt = freezed,Object? linkedAt = freezed,Object? providerEmail = freezed,}) {
  return _then(_OAuthIdentityDto(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,lastUsedAt: freezed == lastUsedAt ? _self.lastUsedAt : lastUsedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,linkedAt: freezed == linkedAt ? _self.linkedAt : linkedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,providerEmail: freezed == providerEmail ? _self.providerEmail : providerEmail // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
