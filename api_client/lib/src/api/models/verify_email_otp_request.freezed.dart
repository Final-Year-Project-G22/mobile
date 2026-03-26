// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verify_email_otp_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VerifyEmailOtpRequest {

/// 6-digit verification code
 String get otp;/// A URL to the JSON Schema for this object.
@JsonKey(name: '\$schema') String? get schema;
/// Create a copy of VerifyEmailOtpRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyEmailOtpRequestCopyWith<VerifyEmailOtpRequest> get copyWith => _$VerifyEmailOtpRequestCopyWithImpl<VerifyEmailOtpRequest>(this as VerifyEmailOtpRequest, _$identity);

  /// Serializes this VerifyEmailOtpRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyEmailOtpRequest&&(identical(other.otp, otp) || other.otp == otp)&&(identical(other.schema, schema) || other.schema == schema));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,otp,schema);

@override
String toString() {
  return 'VerifyEmailOtpRequest(otp: $otp, schema: $schema)';
}


}

/// @nodoc
abstract mixin class $VerifyEmailOtpRequestCopyWith<$Res>  {
  factory $VerifyEmailOtpRequestCopyWith(VerifyEmailOtpRequest value, $Res Function(VerifyEmailOtpRequest) _then) = _$VerifyEmailOtpRequestCopyWithImpl;
@useResult
$Res call({
 String otp,@JsonKey(name: '\$schema') String? schema
});




}
/// @nodoc
class _$VerifyEmailOtpRequestCopyWithImpl<$Res>
    implements $VerifyEmailOtpRequestCopyWith<$Res> {
  _$VerifyEmailOtpRequestCopyWithImpl(this._self, this._then);

  final VerifyEmailOtpRequest _self;
  final $Res Function(VerifyEmailOtpRequest) _then;

/// Create a copy of VerifyEmailOtpRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? otp = null,Object? schema = freezed,}) {
  return _then(_self.copyWith(
otp: null == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as String,schema: freezed == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VerifyEmailOtpRequest].
extension VerifyEmailOtpRequestPatterns on VerifyEmailOtpRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerifyEmailOtpRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerifyEmailOtpRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerifyEmailOtpRequest value)  $default,){
final _that = this;
switch (_that) {
case _VerifyEmailOtpRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerifyEmailOtpRequest value)?  $default,){
final _that = this;
switch (_that) {
case _VerifyEmailOtpRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String otp, @JsonKey(name: '\$schema')  String? schema)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerifyEmailOtpRequest() when $default != null:
return $default(_that.otp,_that.schema);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String otp, @JsonKey(name: '\$schema')  String? schema)  $default,) {final _that = this;
switch (_that) {
case _VerifyEmailOtpRequest():
return $default(_that.otp,_that.schema);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String otp, @JsonKey(name: '\$schema')  String? schema)?  $default,) {final _that = this;
switch (_that) {
case _VerifyEmailOtpRequest() when $default != null:
return $default(_that.otp,_that.schema);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VerifyEmailOtpRequest implements VerifyEmailOtpRequest {
  const _VerifyEmailOtpRequest({required this.otp, @JsonKey(name: '\$schema') this.schema});
  factory _VerifyEmailOtpRequest.fromJson(Map<String, dynamic> json) => _$VerifyEmailOtpRequestFromJson(json);

/// 6-digit verification code
@override final  String otp;
/// A URL to the JSON Schema for this object.
@override@JsonKey(name: '\$schema') final  String? schema;

/// Create a copy of VerifyEmailOtpRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyEmailOtpRequestCopyWith<_VerifyEmailOtpRequest> get copyWith => __$VerifyEmailOtpRequestCopyWithImpl<_VerifyEmailOtpRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerifyEmailOtpRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyEmailOtpRequest&&(identical(other.otp, otp) || other.otp == otp)&&(identical(other.schema, schema) || other.schema == schema));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,otp,schema);

@override
String toString() {
  return 'VerifyEmailOtpRequest(otp: $otp, schema: $schema)';
}


}

/// @nodoc
abstract mixin class _$VerifyEmailOtpRequestCopyWith<$Res> implements $VerifyEmailOtpRequestCopyWith<$Res> {
  factory _$VerifyEmailOtpRequestCopyWith(_VerifyEmailOtpRequest value, $Res Function(_VerifyEmailOtpRequest) _then) = __$VerifyEmailOtpRequestCopyWithImpl;
@override @useResult
$Res call({
 String otp,@JsonKey(name: '\$schema') String? schema
});




}
/// @nodoc
class __$VerifyEmailOtpRequestCopyWithImpl<$Res>
    implements _$VerifyEmailOtpRequestCopyWith<$Res> {
  __$VerifyEmailOtpRequestCopyWithImpl(this._self, this._then);

  final _VerifyEmailOtpRequest _self;
  final $Res Function(_VerifyEmailOtpRequest) _then;

/// Create a copy of VerifyEmailOtpRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? otp = null,Object? schema = freezed,}) {
  return _then(_VerifyEmailOtpRequest(
otp: null == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as String,schema: freezed == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
