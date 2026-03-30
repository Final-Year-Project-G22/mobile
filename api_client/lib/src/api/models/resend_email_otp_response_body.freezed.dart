// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resend_email_otp_response_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ResendEmailOtpResponseBody {

/// OTP resend status message
 String get message;/// A URL to the JSON Schema for this object.
@JsonKey(name: '\$schema') String? get schema;
/// Create a copy of ResendEmailOtpResponseBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResendEmailOtpResponseBodyCopyWith<ResendEmailOtpResponseBody> get copyWith => _$ResendEmailOtpResponseBodyCopyWithImpl<ResendEmailOtpResponseBody>(this as ResendEmailOtpResponseBody, _$identity);

  /// Serializes this ResendEmailOtpResponseBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResendEmailOtpResponseBody&&(identical(other.message, message) || other.message == message)&&(identical(other.schema, schema) || other.schema == schema));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,schema);

@override
String toString() {
  return 'ResendEmailOtpResponseBody(message: $message, schema: $schema)';
}


}

/// @nodoc
abstract mixin class $ResendEmailOtpResponseBodyCopyWith<$Res>  {
  factory $ResendEmailOtpResponseBodyCopyWith(ResendEmailOtpResponseBody value, $Res Function(ResendEmailOtpResponseBody) _then) = _$ResendEmailOtpResponseBodyCopyWithImpl;
@useResult
$Res call({
 String message,@JsonKey(name: '\$schema') String? schema
});




}
/// @nodoc
class _$ResendEmailOtpResponseBodyCopyWithImpl<$Res>
    implements $ResendEmailOtpResponseBodyCopyWith<$Res> {
  _$ResendEmailOtpResponseBodyCopyWithImpl(this._self, this._then);

  final ResendEmailOtpResponseBody _self;
  final $Res Function(ResendEmailOtpResponseBody) _then;

/// Create a copy of ResendEmailOtpResponseBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? schema = freezed,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,schema: freezed == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ResendEmailOtpResponseBody].
extension ResendEmailOtpResponseBodyPatterns on ResendEmailOtpResponseBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResendEmailOtpResponseBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResendEmailOtpResponseBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResendEmailOtpResponseBody value)  $default,){
final _that = this;
switch (_that) {
case _ResendEmailOtpResponseBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResendEmailOtpResponseBody value)?  $default,){
final _that = this;
switch (_that) {
case _ResendEmailOtpResponseBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String message, @JsonKey(name: '\$schema')  String? schema)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResendEmailOtpResponseBody() when $default != null:
return $default(_that.message,_that.schema);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String message, @JsonKey(name: '\$schema')  String? schema)  $default,) {final _that = this;
switch (_that) {
case _ResendEmailOtpResponseBody():
return $default(_that.message,_that.schema);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String message, @JsonKey(name: '\$schema')  String? schema)?  $default,) {final _that = this;
switch (_that) {
case _ResendEmailOtpResponseBody() when $default != null:
return $default(_that.message,_that.schema);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ResendEmailOtpResponseBody implements ResendEmailOtpResponseBody {
  const _ResendEmailOtpResponseBody({required this.message, @JsonKey(name: '\$schema') this.schema});
  factory _ResendEmailOtpResponseBody.fromJson(Map<String, dynamic> json) => _$ResendEmailOtpResponseBodyFromJson(json);

/// OTP resend status message
@override final  String message;
/// A URL to the JSON Schema for this object.
@override@JsonKey(name: '\$schema') final  String? schema;

/// Create a copy of ResendEmailOtpResponseBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResendEmailOtpResponseBodyCopyWith<_ResendEmailOtpResponseBody> get copyWith => __$ResendEmailOtpResponseBodyCopyWithImpl<_ResendEmailOtpResponseBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResendEmailOtpResponseBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResendEmailOtpResponseBody&&(identical(other.message, message) || other.message == message)&&(identical(other.schema, schema) || other.schema == schema));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,schema);

@override
String toString() {
  return 'ResendEmailOtpResponseBody(message: $message, schema: $schema)';
}


}

/// @nodoc
abstract mixin class _$ResendEmailOtpResponseBodyCopyWith<$Res> implements $ResendEmailOtpResponseBodyCopyWith<$Res> {
  factory _$ResendEmailOtpResponseBodyCopyWith(_ResendEmailOtpResponseBody value, $Res Function(_ResendEmailOtpResponseBody) _then) = __$ResendEmailOtpResponseBodyCopyWithImpl;
@override @useResult
$Res call({
 String message,@JsonKey(name: '\$schema') String? schema
});




}
/// @nodoc
class __$ResendEmailOtpResponseBodyCopyWithImpl<$Res>
    implements _$ResendEmailOtpResponseBodyCopyWith<$Res> {
  __$ResendEmailOtpResponseBodyCopyWithImpl(this._self, this._then);

  final _ResendEmailOtpResponseBody _self;
  final $Res Function(_ResendEmailOtpResponseBody) _then;

/// Create a copy of ResendEmailOtpResponseBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? schema = freezed,}) {
  return _then(_ResendEmailOtpResponseBody(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,schema: freezed == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
