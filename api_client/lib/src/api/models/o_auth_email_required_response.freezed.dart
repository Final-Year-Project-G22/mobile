// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'o_auth_email_required_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OAuthEmailRequiredResponse {

 String get firstName; String get lastName; String get name; String get provider; String get state; String get subject; String? get pictureUrl;
/// Create a copy of OAuthEmailRequiredResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OAuthEmailRequiredResponseCopyWith<OAuthEmailRequiredResponse> get copyWith => _$OAuthEmailRequiredResponseCopyWithImpl<OAuthEmailRequiredResponse>(this as OAuthEmailRequiredResponse, _$identity);

  /// Serializes this OAuthEmailRequiredResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OAuthEmailRequiredResponse&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.name, name) || other.name == name)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.state, state) || other.state == state)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.pictureUrl, pictureUrl) || other.pictureUrl == pictureUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstName,lastName,name,provider,state,subject,pictureUrl);

@override
String toString() {
  return 'OAuthEmailRequiredResponse(firstName: $firstName, lastName: $lastName, name: $name, provider: $provider, state: $state, subject: $subject, pictureUrl: $pictureUrl)';
}


}

/// @nodoc
abstract mixin class $OAuthEmailRequiredResponseCopyWith<$Res>  {
  factory $OAuthEmailRequiredResponseCopyWith(OAuthEmailRequiredResponse value, $Res Function(OAuthEmailRequiredResponse) _then) = _$OAuthEmailRequiredResponseCopyWithImpl;
@useResult
$Res call({
 String firstName, String lastName, String name, String provider, String state, String subject, String? pictureUrl
});




}
/// @nodoc
class _$OAuthEmailRequiredResponseCopyWithImpl<$Res>
    implements $OAuthEmailRequiredResponseCopyWith<$Res> {
  _$OAuthEmailRequiredResponseCopyWithImpl(this._self, this._then);

  final OAuthEmailRequiredResponse _self;
  final $Res Function(OAuthEmailRequiredResponse) _then;

/// Create a copy of OAuthEmailRequiredResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstName = null,Object? lastName = null,Object? name = null,Object? provider = null,Object? state = null,Object? subject = null,Object? pictureUrl = freezed,}) {
  return _then(_self.copyWith(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,pictureUrl: freezed == pictureUrl ? _self.pictureUrl : pictureUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OAuthEmailRequiredResponse].
extension OAuthEmailRequiredResponsePatterns on OAuthEmailRequiredResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OAuthEmailRequiredResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OAuthEmailRequiredResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OAuthEmailRequiredResponse value)  $default,){
final _that = this;
switch (_that) {
case _OAuthEmailRequiredResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OAuthEmailRequiredResponse value)?  $default,){
final _that = this;
switch (_that) {
case _OAuthEmailRequiredResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String firstName,  String lastName,  String name,  String provider,  String state,  String subject,  String? pictureUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OAuthEmailRequiredResponse() when $default != null:
return $default(_that.firstName,_that.lastName,_that.name,_that.provider,_that.state,_that.subject,_that.pictureUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String firstName,  String lastName,  String name,  String provider,  String state,  String subject,  String? pictureUrl)  $default,) {final _that = this;
switch (_that) {
case _OAuthEmailRequiredResponse():
return $default(_that.firstName,_that.lastName,_that.name,_that.provider,_that.state,_that.subject,_that.pictureUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String firstName,  String lastName,  String name,  String provider,  String state,  String subject,  String? pictureUrl)?  $default,) {final _that = this;
switch (_that) {
case _OAuthEmailRequiredResponse() when $default != null:
return $default(_that.firstName,_that.lastName,_that.name,_that.provider,_that.state,_that.subject,_that.pictureUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OAuthEmailRequiredResponse implements OAuthEmailRequiredResponse {
  const _OAuthEmailRequiredResponse({required this.firstName, required this.lastName, required this.name, required this.provider, required this.state, required this.subject, this.pictureUrl});
  factory _OAuthEmailRequiredResponse.fromJson(Map<String, dynamic> json) => _$OAuthEmailRequiredResponseFromJson(json);

@override final  String firstName;
@override final  String lastName;
@override final  String name;
@override final  String provider;
@override final  String state;
@override final  String subject;
@override final  String? pictureUrl;

/// Create a copy of OAuthEmailRequiredResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OAuthEmailRequiredResponseCopyWith<_OAuthEmailRequiredResponse> get copyWith => __$OAuthEmailRequiredResponseCopyWithImpl<_OAuthEmailRequiredResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OAuthEmailRequiredResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OAuthEmailRequiredResponse&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.name, name) || other.name == name)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.state, state) || other.state == state)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.pictureUrl, pictureUrl) || other.pictureUrl == pictureUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstName,lastName,name,provider,state,subject,pictureUrl);

@override
String toString() {
  return 'OAuthEmailRequiredResponse(firstName: $firstName, lastName: $lastName, name: $name, provider: $provider, state: $state, subject: $subject, pictureUrl: $pictureUrl)';
}


}

/// @nodoc
abstract mixin class _$OAuthEmailRequiredResponseCopyWith<$Res> implements $OAuthEmailRequiredResponseCopyWith<$Res> {
  factory _$OAuthEmailRequiredResponseCopyWith(_OAuthEmailRequiredResponse value, $Res Function(_OAuthEmailRequiredResponse) _then) = __$OAuthEmailRequiredResponseCopyWithImpl;
@override @useResult
$Res call({
 String firstName, String lastName, String name, String provider, String state, String subject, String? pictureUrl
});




}
/// @nodoc
class __$OAuthEmailRequiredResponseCopyWithImpl<$Res>
    implements _$OAuthEmailRequiredResponseCopyWith<$Res> {
  __$OAuthEmailRequiredResponseCopyWithImpl(this._self, this._then);

  final _OAuthEmailRequiredResponse _self;
  final $Res Function(_OAuthEmailRequiredResponse) _then;

/// Create a copy of OAuthEmailRequiredResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstName = null,Object? lastName = null,Object? name = null,Object? provider = null,Object? state = null,Object? subject = null,Object? pictureUrl = freezed,}) {
  return _then(_OAuthEmailRequiredResponse(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,pictureUrl: freezed == pictureUrl ? _self.pictureUrl : pictureUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
