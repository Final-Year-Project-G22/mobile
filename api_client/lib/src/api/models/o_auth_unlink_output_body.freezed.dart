// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'o_auth_unlink_output_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OAuthUnlinkOutputBody {

 String get unlinked;/// A URL to the JSON Schema for this object.
@JsonKey(name: '\$schema') String? get schema;
/// Create a copy of OAuthUnlinkOutputBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OAuthUnlinkOutputBodyCopyWith<OAuthUnlinkOutputBody> get copyWith => _$OAuthUnlinkOutputBodyCopyWithImpl<OAuthUnlinkOutputBody>(this as OAuthUnlinkOutputBody, _$identity);

  /// Serializes this OAuthUnlinkOutputBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OAuthUnlinkOutputBody&&(identical(other.unlinked, unlinked) || other.unlinked == unlinked)&&(identical(other.schema, schema) || other.schema == schema));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,unlinked,schema);

@override
String toString() {
  return 'OAuthUnlinkOutputBody(unlinked: $unlinked, schema: $schema)';
}


}

/// @nodoc
abstract mixin class $OAuthUnlinkOutputBodyCopyWith<$Res>  {
  factory $OAuthUnlinkOutputBodyCopyWith(OAuthUnlinkOutputBody value, $Res Function(OAuthUnlinkOutputBody) _then) = _$OAuthUnlinkOutputBodyCopyWithImpl;
@useResult
$Res call({
 String unlinked,@JsonKey(name: '\$schema') String? schema
});




}
/// @nodoc
class _$OAuthUnlinkOutputBodyCopyWithImpl<$Res>
    implements $OAuthUnlinkOutputBodyCopyWith<$Res> {
  _$OAuthUnlinkOutputBodyCopyWithImpl(this._self, this._then);

  final OAuthUnlinkOutputBody _self;
  final $Res Function(OAuthUnlinkOutputBody) _then;

/// Create a copy of OAuthUnlinkOutputBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? unlinked = null,Object? schema = freezed,}) {
  return _then(_self.copyWith(
unlinked: null == unlinked ? _self.unlinked : unlinked // ignore: cast_nullable_to_non_nullable
as String,schema: freezed == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OAuthUnlinkOutputBody].
extension OAuthUnlinkOutputBodyPatterns on OAuthUnlinkOutputBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OAuthUnlinkOutputBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OAuthUnlinkOutputBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OAuthUnlinkOutputBody value)  $default,){
final _that = this;
switch (_that) {
case _OAuthUnlinkOutputBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OAuthUnlinkOutputBody value)?  $default,){
final _that = this;
switch (_that) {
case _OAuthUnlinkOutputBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String unlinked, @JsonKey(name: '\$schema')  String? schema)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OAuthUnlinkOutputBody() when $default != null:
return $default(_that.unlinked,_that.schema);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String unlinked, @JsonKey(name: '\$schema')  String? schema)  $default,) {final _that = this;
switch (_that) {
case _OAuthUnlinkOutputBody():
return $default(_that.unlinked,_that.schema);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String unlinked, @JsonKey(name: '\$schema')  String? schema)?  $default,) {final _that = this;
switch (_that) {
case _OAuthUnlinkOutputBody() when $default != null:
return $default(_that.unlinked,_that.schema);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OAuthUnlinkOutputBody implements OAuthUnlinkOutputBody {
  const _OAuthUnlinkOutputBody({required this.unlinked, @JsonKey(name: '\$schema') this.schema});
  factory _OAuthUnlinkOutputBody.fromJson(Map<String, dynamic> json) => _$OAuthUnlinkOutputBodyFromJson(json);

@override final  String unlinked;
/// A URL to the JSON Schema for this object.
@override@JsonKey(name: '\$schema') final  String? schema;

/// Create a copy of OAuthUnlinkOutputBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OAuthUnlinkOutputBodyCopyWith<_OAuthUnlinkOutputBody> get copyWith => __$OAuthUnlinkOutputBodyCopyWithImpl<_OAuthUnlinkOutputBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OAuthUnlinkOutputBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OAuthUnlinkOutputBody&&(identical(other.unlinked, unlinked) || other.unlinked == unlinked)&&(identical(other.schema, schema) || other.schema == schema));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,unlinked,schema);

@override
String toString() {
  return 'OAuthUnlinkOutputBody(unlinked: $unlinked, schema: $schema)';
}


}

/// @nodoc
abstract mixin class _$OAuthUnlinkOutputBodyCopyWith<$Res> implements $OAuthUnlinkOutputBodyCopyWith<$Res> {
  factory _$OAuthUnlinkOutputBodyCopyWith(_OAuthUnlinkOutputBody value, $Res Function(_OAuthUnlinkOutputBody) _then) = __$OAuthUnlinkOutputBodyCopyWithImpl;
@override @useResult
$Res call({
 String unlinked,@JsonKey(name: '\$schema') String? schema
});




}
/// @nodoc
class __$OAuthUnlinkOutputBodyCopyWithImpl<$Res>
    implements _$OAuthUnlinkOutputBodyCopyWith<$Res> {
  __$OAuthUnlinkOutputBodyCopyWithImpl(this._self, this._then);

  final _OAuthUnlinkOutputBody _self;
  final $Res Function(_OAuthUnlinkOutputBody) _then;

/// Create a copy of OAuthUnlinkOutputBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? unlinked = null,Object? schema = freezed,}) {
  return _then(_OAuthUnlinkOutputBody(
unlinked: null == unlinked ? _self.unlinked : unlinked // ignore: cast_nullable_to_non_nullable
as String,schema: freezed == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
