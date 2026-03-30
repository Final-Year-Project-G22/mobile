// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'o_auth_complete_email_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OAuthCompleteEmailRequest {

/// Email address
 String get email;/// State token
 String get state;/// A URL to the JSON Schema for this object.
@JsonKey(name: '\$schema') String? get schema;
/// Create a copy of OAuthCompleteEmailRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OAuthCompleteEmailRequestCopyWith<OAuthCompleteEmailRequest> get copyWith => _$OAuthCompleteEmailRequestCopyWithImpl<OAuthCompleteEmailRequest>(this as OAuthCompleteEmailRequest, _$identity);

  /// Serializes this OAuthCompleteEmailRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OAuthCompleteEmailRequest&&(identical(other.email, email) || other.email == email)&&(identical(other.state, state) || other.state == state)&&(identical(other.schema, schema) || other.schema == schema));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,state,schema);

@override
String toString() {
  return 'OAuthCompleteEmailRequest(email: $email, state: $state, schema: $schema)';
}


}

/// @nodoc
abstract mixin class $OAuthCompleteEmailRequestCopyWith<$Res>  {
  factory $OAuthCompleteEmailRequestCopyWith(OAuthCompleteEmailRequest value, $Res Function(OAuthCompleteEmailRequest) _then) = _$OAuthCompleteEmailRequestCopyWithImpl;
@useResult
$Res call({
 String email, String state,@JsonKey(name: '\$schema') String? schema
});




}
/// @nodoc
class _$OAuthCompleteEmailRequestCopyWithImpl<$Res>
    implements $OAuthCompleteEmailRequestCopyWith<$Res> {
  _$OAuthCompleteEmailRequestCopyWithImpl(this._self, this._then);

  final OAuthCompleteEmailRequest _self;
  final $Res Function(OAuthCompleteEmailRequest) _then;

/// Create a copy of OAuthCompleteEmailRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? state = null,Object? schema = freezed,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,schema: freezed == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OAuthCompleteEmailRequest].
extension OAuthCompleteEmailRequestPatterns on OAuthCompleteEmailRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OAuthCompleteEmailRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OAuthCompleteEmailRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OAuthCompleteEmailRequest value)  $default,){
final _that = this;
switch (_that) {
case _OAuthCompleteEmailRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OAuthCompleteEmailRequest value)?  $default,){
final _that = this;
switch (_that) {
case _OAuthCompleteEmailRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String state, @JsonKey(name: '\$schema')  String? schema)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OAuthCompleteEmailRequest() when $default != null:
return $default(_that.email,_that.state,_that.schema);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String state, @JsonKey(name: '\$schema')  String? schema)  $default,) {final _that = this;
switch (_that) {
case _OAuthCompleteEmailRequest():
return $default(_that.email,_that.state,_that.schema);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String state, @JsonKey(name: '\$schema')  String? schema)?  $default,) {final _that = this;
switch (_that) {
case _OAuthCompleteEmailRequest() when $default != null:
return $default(_that.email,_that.state,_that.schema);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OAuthCompleteEmailRequest implements OAuthCompleteEmailRequest {
  const _OAuthCompleteEmailRequest({required this.email, required this.state, @JsonKey(name: '\$schema') this.schema});
  factory _OAuthCompleteEmailRequest.fromJson(Map<String, dynamic> json) => _$OAuthCompleteEmailRequestFromJson(json);

/// Email address
@override final  String email;
/// State token
@override final  String state;
/// A URL to the JSON Schema for this object.
@override@JsonKey(name: '\$schema') final  String? schema;

/// Create a copy of OAuthCompleteEmailRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OAuthCompleteEmailRequestCopyWith<_OAuthCompleteEmailRequest> get copyWith => __$OAuthCompleteEmailRequestCopyWithImpl<_OAuthCompleteEmailRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OAuthCompleteEmailRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OAuthCompleteEmailRequest&&(identical(other.email, email) || other.email == email)&&(identical(other.state, state) || other.state == state)&&(identical(other.schema, schema) || other.schema == schema));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,state,schema);

@override
String toString() {
  return 'OAuthCompleteEmailRequest(email: $email, state: $state, schema: $schema)';
}


}

/// @nodoc
abstract mixin class _$OAuthCompleteEmailRequestCopyWith<$Res> implements $OAuthCompleteEmailRequestCopyWith<$Res> {
  factory _$OAuthCompleteEmailRequestCopyWith(_OAuthCompleteEmailRequest value, $Res Function(_OAuthCompleteEmailRequest) _then) = __$OAuthCompleteEmailRequestCopyWithImpl;
@override @useResult
$Res call({
 String email, String state,@JsonKey(name: '\$schema') String? schema
});




}
/// @nodoc
class __$OAuthCompleteEmailRequestCopyWithImpl<$Res>
    implements _$OAuthCompleteEmailRequestCopyWith<$Res> {
  __$OAuthCompleteEmailRequestCopyWithImpl(this._self, this._then);

  final _OAuthCompleteEmailRequest _self;
  final $Res Function(_OAuthCompleteEmailRequest) _then;

/// Create a copy of OAuthCompleteEmailRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? state = null,Object? schema = freezed,}) {
  return _then(_OAuthCompleteEmailRequest(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,schema: freezed == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
