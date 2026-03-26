// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'upload_avatar_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UploadAvatarResponse {

 String get imageUrl;/// A URL to the JSON Schema for this object.
@JsonKey(name: '\$schema') String? get schema;
/// Create a copy of UploadAvatarResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UploadAvatarResponseCopyWith<UploadAvatarResponse> get copyWith => _$UploadAvatarResponseCopyWithImpl<UploadAvatarResponse>(this as UploadAvatarResponse, _$identity);

  /// Serializes this UploadAvatarResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UploadAvatarResponse&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.schema, schema) || other.schema == schema));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,imageUrl,schema);

@override
String toString() {
  return 'UploadAvatarResponse(imageUrl: $imageUrl, schema: $schema)';
}


}

/// @nodoc
abstract mixin class $UploadAvatarResponseCopyWith<$Res>  {
  factory $UploadAvatarResponseCopyWith(UploadAvatarResponse value, $Res Function(UploadAvatarResponse) _then) = _$UploadAvatarResponseCopyWithImpl;
@useResult
$Res call({
 String imageUrl,@JsonKey(name: '\$schema') String? schema
});




}
/// @nodoc
class _$UploadAvatarResponseCopyWithImpl<$Res>
    implements $UploadAvatarResponseCopyWith<$Res> {
  _$UploadAvatarResponseCopyWithImpl(this._self, this._then);

  final UploadAvatarResponse _self;
  final $Res Function(UploadAvatarResponse) _then;

/// Create a copy of UploadAvatarResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? imageUrl = null,Object? schema = freezed,}) {
  return _then(_self.copyWith(
imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,schema: freezed == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UploadAvatarResponse].
extension UploadAvatarResponsePatterns on UploadAvatarResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UploadAvatarResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UploadAvatarResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UploadAvatarResponse value)  $default,){
final _that = this;
switch (_that) {
case _UploadAvatarResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UploadAvatarResponse value)?  $default,){
final _that = this;
switch (_that) {
case _UploadAvatarResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String imageUrl, @JsonKey(name: '\$schema')  String? schema)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UploadAvatarResponse() when $default != null:
return $default(_that.imageUrl,_that.schema);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String imageUrl, @JsonKey(name: '\$schema')  String? schema)  $default,) {final _that = this;
switch (_that) {
case _UploadAvatarResponse():
return $default(_that.imageUrl,_that.schema);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String imageUrl, @JsonKey(name: '\$schema')  String? schema)?  $default,) {final _that = this;
switch (_that) {
case _UploadAvatarResponse() when $default != null:
return $default(_that.imageUrl,_that.schema);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UploadAvatarResponse implements UploadAvatarResponse {
  const _UploadAvatarResponse({required this.imageUrl, @JsonKey(name: '\$schema') this.schema});
  factory _UploadAvatarResponse.fromJson(Map<String, dynamic> json) => _$UploadAvatarResponseFromJson(json);

@override final  String imageUrl;
/// A URL to the JSON Schema for this object.
@override@JsonKey(name: '\$schema') final  String? schema;

/// Create a copy of UploadAvatarResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UploadAvatarResponseCopyWith<_UploadAvatarResponse> get copyWith => __$UploadAvatarResponseCopyWithImpl<_UploadAvatarResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UploadAvatarResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UploadAvatarResponse&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.schema, schema) || other.schema == schema));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,imageUrl,schema);

@override
String toString() {
  return 'UploadAvatarResponse(imageUrl: $imageUrl, schema: $schema)';
}


}

/// @nodoc
abstract mixin class _$UploadAvatarResponseCopyWith<$Res> implements $UploadAvatarResponseCopyWith<$Res> {
  factory _$UploadAvatarResponseCopyWith(_UploadAvatarResponse value, $Res Function(_UploadAvatarResponse) _then) = __$UploadAvatarResponseCopyWithImpl;
@override @useResult
$Res call({
 String imageUrl,@JsonKey(name: '\$schema') String? schema
});




}
/// @nodoc
class __$UploadAvatarResponseCopyWithImpl<$Res>
    implements _$UploadAvatarResponseCopyWith<$Res> {
  __$UploadAvatarResponseCopyWithImpl(this._self, this._then);

  final _UploadAvatarResponse _self;
  final $Res Function(_UploadAvatarResponse) _then;

/// Create a copy of UploadAvatarResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? imageUrl = null,Object? schema = freezed,}) {
  return _then(_UploadAvatarResponse(
imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,schema: freezed == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
