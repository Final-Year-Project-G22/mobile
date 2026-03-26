// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'o_auth_provider_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OAuthProviderDto {

 String get displayName; String get icon; String get name;
/// Create a copy of OAuthProviderDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OAuthProviderDtoCopyWith<OAuthProviderDto> get copyWith => _$OAuthProviderDtoCopyWithImpl<OAuthProviderDto>(this as OAuthProviderDto, _$identity);

  /// Serializes this OAuthProviderDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OAuthProviderDto&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,displayName,icon,name);

@override
String toString() {
  return 'OAuthProviderDto(displayName: $displayName, icon: $icon, name: $name)';
}


}

/// @nodoc
abstract mixin class $OAuthProviderDtoCopyWith<$Res>  {
  factory $OAuthProviderDtoCopyWith(OAuthProviderDto value, $Res Function(OAuthProviderDto) _then) = _$OAuthProviderDtoCopyWithImpl;
@useResult
$Res call({
 String displayName, String icon, String name
});




}
/// @nodoc
class _$OAuthProviderDtoCopyWithImpl<$Res>
    implements $OAuthProviderDtoCopyWith<$Res> {
  _$OAuthProviderDtoCopyWithImpl(this._self, this._then);

  final OAuthProviderDto _self;
  final $Res Function(OAuthProviderDto) _then;

/// Create a copy of OAuthProviderDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? displayName = null,Object? icon = null,Object? name = null,}) {
  return _then(_self.copyWith(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OAuthProviderDto].
extension OAuthProviderDtoPatterns on OAuthProviderDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OAuthProviderDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OAuthProviderDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OAuthProviderDto value)  $default,){
final _that = this;
switch (_that) {
case _OAuthProviderDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OAuthProviderDto value)?  $default,){
final _that = this;
switch (_that) {
case _OAuthProviderDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String displayName,  String icon,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OAuthProviderDto() when $default != null:
return $default(_that.displayName,_that.icon,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String displayName,  String icon,  String name)  $default,) {final _that = this;
switch (_that) {
case _OAuthProviderDto():
return $default(_that.displayName,_that.icon,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String displayName,  String icon,  String name)?  $default,) {final _that = this;
switch (_that) {
case _OAuthProviderDto() when $default != null:
return $default(_that.displayName,_that.icon,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OAuthProviderDto implements OAuthProviderDto {
  const _OAuthProviderDto({required this.displayName, required this.icon, required this.name});
  factory _OAuthProviderDto.fromJson(Map<String, dynamic> json) => _$OAuthProviderDtoFromJson(json);

@override final  String displayName;
@override final  String icon;
@override final  String name;

/// Create a copy of OAuthProviderDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OAuthProviderDtoCopyWith<_OAuthProviderDto> get copyWith => __$OAuthProviderDtoCopyWithImpl<_OAuthProviderDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OAuthProviderDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OAuthProviderDto&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,displayName,icon,name);

@override
String toString() {
  return 'OAuthProviderDto(displayName: $displayName, icon: $icon, name: $name)';
}


}

/// @nodoc
abstract mixin class _$OAuthProviderDtoCopyWith<$Res> implements $OAuthProviderDtoCopyWith<$Res> {
  factory _$OAuthProviderDtoCopyWith(_OAuthProviderDto value, $Res Function(_OAuthProviderDto) _then) = __$OAuthProviderDtoCopyWithImpl;
@override @useResult
$Res call({
 String displayName, String icon, String name
});




}
/// @nodoc
class __$OAuthProviderDtoCopyWithImpl<$Res>
    implements _$OAuthProviderDtoCopyWith<$Res> {
  __$OAuthProviderDtoCopyWithImpl(this._self, this._then);

  final _OAuthProviderDto _self;
  final $Res Function(_OAuthProviderDto) _then;

/// Create a copy of OAuthProviderDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? displayName = null,Object? icon = null,Object? name = null,}) {
  return _then(_OAuthProviderDto(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
