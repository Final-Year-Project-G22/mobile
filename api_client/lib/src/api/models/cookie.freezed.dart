// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cookie.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Cookie {

@JsonKey(name: 'Domain') String get domain;@JsonKey(name: 'Expires') DateTime get expires;@JsonKey(name: 'HttpOnly') bool get httpOnly;@JsonKey(name: 'MaxAge') int get maxAge;@JsonKey(name: 'Name') String get name;@JsonKey(name: 'Partitioned') bool get partitioned;@JsonKey(name: 'Path') String get path;@JsonKey(name: 'Quoted') bool get quoted;@JsonKey(name: 'Raw') String get raw;@JsonKey(name: 'RawExpires') String get rawExpires;@JsonKey(name: 'SameSite') int get sameSite;@JsonKey(name: 'Secure') bool get secure;@JsonKey(name: 'Unparsed') List<dynamic>? get unparsed;@JsonKey(name: 'Value') String get value;
/// Create a copy of Cookie
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CookieCopyWith<Cookie> get copyWith => _$CookieCopyWithImpl<Cookie>(this as Cookie, _$identity);

  /// Serializes this Cookie to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Cookie&&(identical(other.domain, domain) || other.domain == domain)&&(identical(other.expires, expires) || other.expires == expires)&&(identical(other.httpOnly, httpOnly) || other.httpOnly == httpOnly)&&(identical(other.maxAge, maxAge) || other.maxAge == maxAge)&&(identical(other.name, name) || other.name == name)&&(identical(other.partitioned, partitioned) || other.partitioned == partitioned)&&(identical(other.path, path) || other.path == path)&&(identical(other.quoted, quoted) || other.quoted == quoted)&&(identical(other.raw, raw) || other.raw == raw)&&(identical(other.rawExpires, rawExpires) || other.rawExpires == rawExpires)&&(identical(other.sameSite, sameSite) || other.sameSite == sameSite)&&(identical(other.secure, secure) || other.secure == secure)&&const DeepCollectionEquality().equals(other.unparsed, unparsed)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,domain,expires,httpOnly,maxAge,name,partitioned,path,quoted,raw,rawExpires,sameSite,secure,const DeepCollectionEquality().hash(unparsed),value);

@override
String toString() {
  return 'Cookie(domain: $domain, expires: $expires, httpOnly: $httpOnly, maxAge: $maxAge, name: $name, partitioned: $partitioned, path: $path, quoted: $quoted, raw: $raw, rawExpires: $rawExpires, sameSite: $sameSite, secure: $secure, unparsed: $unparsed, value: $value)';
}


}

/// @nodoc
abstract mixin class $CookieCopyWith<$Res>  {
  factory $CookieCopyWith(Cookie value, $Res Function(Cookie) _then) = _$CookieCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'Domain') String domain,@JsonKey(name: 'Expires') DateTime expires,@JsonKey(name: 'HttpOnly') bool httpOnly,@JsonKey(name: 'MaxAge') int maxAge,@JsonKey(name: 'Name') String name,@JsonKey(name: 'Partitioned') bool partitioned,@JsonKey(name: 'Path') String path,@JsonKey(name: 'Quoted') bool quoted,@JsonKey(name: 'Raw') String raw,@JsonKey(name: 'RawExpires') String rawExpires,@JsonKey(name: 'SameSite') int sameSite,@JsonKey(name: 'Secure') bool secure,@JsonKey(name: 'Unparsed') List<dynamic>? unparsed,@JsonKey(name: 'Value') String value
});




}
/// @nodoc
class _$CookieCopyWithImpl<$Res>
    implements $CookieCopyWith<$Res> {
  _$CookieCopyWithImpl(this._self, this._then);

  final Cookie _self;
  final $Res Function(Cookie) _then;

/// Create a copy of Cookie
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? domain = null,Object? expires = null,Object? httpOnly = null,Object? maxAge = null,Object? name = null,Object? partitioned = null,Object? path = null,Object? quoted = null,Object? raw = null,Object? rawExpires = null,Object? sameSite = null,Object? secure = null,Object? unparsed = freezed,Object? value = null,}) {
  return _then(_self.copyWith(
domain: null == domain ? _self.domain : domain // ignore: cast_nullable_to_non_nullable
as String,expires: null == expires ? _self.expires : expires // ignore: cast_nullable_to_non_nullable
as DateTime,httpOnly: null == httpOnly ? _self.httpOnly : httpOnly // ignore: cast_nullable_to_non_nullable
as bool,maxAge: null == maxAge ? _self.maxAge : maxAge // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,partitioned: null == partitioned ? _self.partitioned : partitioned // ignore: cast_nullable_to_non_nullable
as bool,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,quoted: null == quoted ? _self.quoted : quoted // ignore: cast_nullable_to_non_nullable
as bool,raw: null == raw ? _self.raw : raw // ignore: cast_nullable_to_non_nullable
as String,rawExpires: null == rawExpires ? _self.rawExpires : rawExpires // ignore: cast_nullable_to_non_nullable
as String,sameSite: null == sameSite ? _self.sameSite : sameSite // ignore: cast_nullable_to_non_nullable
as int,secure: null == secure ? _self.secure : secure // ignore: cast_nullable_to_non_nullable
as bool,unparsed: freezed == unparsed ? _self.unparsed : unparsed // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Cookie].
extension CookiePatterns on Cookie {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Cookie value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Cookie() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Cookie value)  $default,){
final _that = this;
switch (_that) {
case _Cookie():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Cookie value)?  $default,){
final _that = this;
switch (_that) {
case _Cookie() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'Domain')  String domain, @JsonKey(name: 'Expires')  DateTime expires, @JsonKey(name: 'HttpOnly')  bool httpOnly, @JsonKey(name: 'MaxAge')  int maxAge, @JsonKey(name: 'Name')  String name, @JsonKey(name: 'Partitioned')  bool partitioned, @JsonKey(name: 'Path')  String path, @JsonKey(name: 'Quoted')  bool quoted, @JsonKey(name: 'Raw')  String raw, @JsonKey(name: 'RawExpires')  String rawExpires, @JsonKey(name: 'SameSite')  int sameSite, @JsonKey(name: 'Secure')  bool secure, @JsonKey(name: 'Unparsed')  List<dynamic>? unparsed, @JsonKey(name: 'Value')  String value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Cookie() when $default != null:
return $default(_that.domain,_that.expires,_that.httpOnly,_that.maxAge,_that.name,_that.partitioned,_that.path,_that.quoted,_that.raw,_that.rawExpires,_that.sameSite,_that.secure,_that.unparsed,_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'Domain')  String domain, @JsonKey(name: 'Expires')  DateTime expires, @JsonKey(name: 'HttpOnly')  bool httpOnly, @JsonKey(name: 'MaxAge')  int maxAge, @JsonKey(name: 'Name')  String name, @JsonKey(name: 'Partitioned')  bool partitioned, @JsonKey(name: 'Path')  String path, @JsonKey(name: 'Quoted')  bool quoted, @JsonKey(name: 'Raw')  String raw, @JsonKey(name: 'RawExpires')  String rawExpires, @JsonKey(name: 'SameSite')  int sameSite, @JsonKey(name: 'Secure')  bool secure, @JsonKey(name: 'Unparsed')  List<dynamic>? unparsed, @JsonKey(name: 'Value')  String value)  $default,) {final _that = this;
switch (_that) {
case _Cookie():
return $default(_that.domain,_that.expires,_that.httpOnly,_that.maxAge,_that.name,_that.partitioned,_that.path,_that.quoted,_that.raw,_that.rawExpires,_that.sameSite,_that.secure,_that.unparsed,_that.value);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'Domain')  String domain, @JsonKey(name: 'Expires')  DateTime expires, @JsonKey(name: 'HttpOnly')  bool httpOnly, @JsonKey(name: 'MaxAge')  int maxAge, @JsonKey(name: 'Name')  String name, @JsonKey(name: 'Partitioned')  bool partitioned, @JsonKey(name: 'Path')  String path, @JsonKey(name: 'Quoted')  bool quoted, @JsonKey(name: 'Raw')  String raw, @JsonKey(name: 'RawExpires')  String rawExpires, @JsonKey(name: 'SameSite')  int sameSite, @JsonKey(name: 'Secure')  bool secure, @JsonKey(name: 'Unparsed')  List<dynamic>? unparsed, @JsonKey(name: 'Value')  String value)?  $default,) {final _that = this;
switch (_that) {
case _Cookie() when $default != null:
return $default(_that.domain,_that.expires,_that.httpOnly,_that.maxAge,_that.name,_that.partitioned,_that.path,_that.quoted,_that.raw,_that.rawExpires,_that.sameSite,_that.secure,_that.unparsed,_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Cookie implements Cookie {
  const _Cookie({@JsonKey(name: 'Domain') required this.domain, @JsonKey(name: 'Expires') required this.expires, @JsonKey(name: 'HttpOnly') required this.httpOnly, @JsonKey(name: 'MaxAge') required this.maxAge, @JsonKey(name: 'Name') required this.name, @JsonKey(name: 'Partitioned') required this.partitioned, @JsonKey(name: 'Path') required this.path, @JsonKey(name: 'Quoted') required this.quoted, @JsonKey(name: 'Raw') required this.raw, @JsonKey(name: 'RawExpires') required this.rawExpires, @JsonKey(name: 'SameSite') required this.sameSite, @JsonKey(name: 'Secure') required this.secure, @JsonKey(name: 'Unparsed') required final  List<dynamic>? unparsed, @JsonKey(name: 'Value') required this.value}): _unparsed = unparsed;
  factory _Cookie.fromJson(Map<String, dynamic> json) => _$CookieFromJson(json);

@override@JsonKey(name: 'Domain') final  String domain;
@override@JsonKey(name: 'Expires') final  DateTime expires;
@override@JsonKey(name: 'HttpOnly') final  bool httpOnly;
@override@JsonKey(name: 'MaxAge') final  int maxAge;
@override@JsonKey(name: 'Name') final  String name;
@override@JsonKey(name: 'Partitioned') final  bool partitioned;
@override@JsonKey(name: 'Path') final  String path;
@override@JsonKey(name: 'Quoted') final  bool quoted;
@override@JsonKey(name: 'Raw') final  String raw;
@override@JsonKey(name: 'RawExpires') final  String rawExpires;
@override@JsonKey(name: 'SameSite') final  int sameSite;
@override@JsonKey(name: 'Secure') final  bool secure;
 final  List<dynamic>? _unparsed;
@override@JsonKey(name: 'Unparsed') List<dynamic>? get unparsed {
  final value = _unparsed;
  if (value == null) return null;
  if (_unparsed is EqualUnmodifiableListView) return _unparsed;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'Value') final  String value;

/// Create a copy of Cookie
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CookieCopyWith<_Cookie> get copyWith => __$CookieCopyWithImpl<_Cookie>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CookieToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Cookie&&(identical(other.domain, domain) || other.domain == domain)&&(identical(other.expires, expires) || other.expires == expires)&&(identical(other.httpOnly, httpOnly) || other.httpOnly == httpOnly)&&(identical(other.maxAge, maxAge) || other.maxAge == maxAge)&&(identical(other.name, name) || other.name == name)&&(identical(other.partitioned, partitioned) || other.partitioned == partitioned)&&(identical(other.path, path) || other.path == path)&&(identical(other.quoted, quoted) || other.quoted == quoted)&&(identical(other.raw, raw) || other.raw == raw)&&(identical(other.rawExpires, rawExpires) || other.rawExpires == rawExpires)&&(identical(other.sameSite, sameSite) || other.sameSite == sameSite)&&(identical(other.secure, secure) || other.secure == secure)&&const DeepCollectionEquality().equals(other._unparsed, _unparsed)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,domain,expires,httpOnly,maxAge,name,partitioned,path,quoted,raw,rawExpires,sameSite,secure,const DeepCollectionEquality().hash(_unparsed),value);

@override
String toString() {
  return 'Cookie(domain: $domain, expires: $expires, httpOnly: $httpOnly, maxAge: $maxAge, name: $name, partitioned: $partitioned, path: $path, quoted: $quoted, raw: $raw, rawExpires: $rawExpires, sameSite: $sameSite, secure: $secure, unparsed: $unparsed, value: $value)';
}


}

/// @nodoc
abstract mixin class _$CookieCopyWith<$Res> implements $CookieCopyWith<$Res> {
  factory _$CookieCopyWith(_Cookie value, $Res Function(_Cookie) _then) = __$CookieCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'Domain') String domain,@JsonKey(name: 'Expires') DateTime expires,@JsonKey(name: 'HttpOnly') bool httpOnly,@JsonKey(name: 'MaxAge') int maxAge,@JsonKey(name: 'Name') String name,@JsonKey(name: 'Partitioned') bool partitioned,@JsonKey(name: 'Path') String path,@JsonKey(name: 'Quoted') bool quoted,@JsonKey(name: 'Raw') String raw,@JsonKey(name: 'RawExpires') String rawExpires,@JsonKey(name: 'SameSite') int sameSite,@JsonKey(name: 'Secure') bool secure,@JsonKey(name: 'Unparsed') List<dynamic>? unparsed,@JsonKey(name: 'Value') String value
});




}
/// @nodoc
class __$CookieCopyWithImpl<$Res>
    implements _$CookieCopyWith<$Res> {
  __$CookieCopyWithImpl(this._self, this._then);

  final _Cookie _self;
  final $Res Function(_Cookie) _then;

/// Create a copy of Cookie
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? domain = null,Object? expires = null,Object? httpOnly = null,Object? maxAge = null,Object? name = null,Object? partitioned = null,Object? path = null,Object? quoted = null,Object? raw = null,Object? rawExpires = null,Object? sameSite = null,Object? secure = null,Object? unparsed = freezed,Object? value = null,}) {
  return _then(_Cookie(
domain: null == domain ? _self.domain : domain // ignore: cast_nullable_to_non_nullable
as String,expires: null == expires ? _self.expires : expires // ignore: cast_nullable_to_non_nullable
as DateTime,httpOnly: null == httpOnly ? _self.httpOnly : httpOnly // ignore: cast_nullable_to_non_nullable
as bool,maxAge: null == maxAge ? _self.maxAge : maxAge // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,partitioned: null == partitioned ? _self.partitioned : partitioned // ignore: cast_nullable_to_non_nullable
as bool,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,quoted: null == quoted ? _self.quoted : quoted // ignore: cast_nullable_to_non_nullable
as bool,raw: null == raw ? _self.raw : raw // ignore: cast_nullable_to_non_nullable
as String,rawExpires: null == rawExpires ? _self.rawExpires : rawExpires // ignore: cast_nullable_to_non_nullable
as String,sameSite: null == sameSite ? _self.sameSite : sameSite // ignore: cast_nullable_to_non_nullable
as int,secure: null == secure ? _self.secure : secure // ignore: cast_nullable_to_non_nullable
as bool,unparsed: freezed == unparsed ? _self._unparsed : unparsed // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
