// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'error_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ErrorDetail {

/// Where the error occurred, e.g. 'body.items[3].tags' or 'path.thing-id'
 String? get location;/// Error message text
 String? get message;/// The value at the given location
 dynamic get value;
/// Create a copy of ErrorDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorDetailCopyWith<ErrorDetail> get copyWith => _$ErrorDetailCopyWithImpl<ErrorDetail>(this as ErrorDetail, _$identity);

  /// Serializes this ErrorDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorDetail&&(identical(other.location, location) || other.location == location)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.value, value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,location,message,const DeepCollectionEquality().hash(value));

@override
String toString() {
  return 'ErrorDetail(location: $location, message: $message, value: $value)';
}


}

/// @nodoc
abstract mixin class $ErrorDetailCopyWith<$Res>  {
  factory $ErrorDetailCopyWith(ErrorDetail value, $Res Function(ErrorDetail) _then) = _$ErrorDetailCopyWithImpl;
@useResult
$Res call({
 String? location, String? message, dynamic value
});




}
/// @nodoc
class _$ErrorDetailCopyWithImpl<$Res>
    implements $ErrorDetailCopyWith<$Res> {
  _$ErrorDetailCopyWithImpl(this._self, this._then);

  final ErrorDetail _self;
  final $Res Function(ErrorDetail) _then;

/// Create a copy of ErrorDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? location = freezed,Object? message = freezed,Object? value = freezed,}) {
  return _then(_self.copyWith(
location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// Adds pattern-matching-related methods to [ErrorDetail].
extension ErrorDetailPatterns on ErrorDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ErrorDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ErrorDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ErrorDetail value)  $default,){
final _that = this;
switch (_that) {
case _ErrorDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ErrorDetail value)?  $default,){
final _that = this;
switch (_that) {
case _ErrorDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? location,  String? message,  dynamic value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ErrorDetail() when $default != null:
return $default(_that.location,_that.message,_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? location,  String? message,  dynamic value)  $default,) {final _that = this;
switch (_that) {
case _ErrorDetail():
return $default(_that.location,_that.message,_that.value);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? location,  String? message,  dynamic value)?  $default,) {final _that = this;
switch (_that) {
case _ErrorDetail() when $default != null:
return $default(_that.location,_that.message,_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ErrorDetail implements ErrorDetail {
  const _ErrorDetail({this.location, this.message, this.value});
  factory _ErrorDetail.fromJson(Map<String, dynamic> json) => _$ErrorDetailFromJson(json);

/// Where the error occurred, e.g. 'body.items[3].tags' or 'path.thing-id'
@override final  String? location;
/// Error message text
@override final  String? message;
/// The value at the given location
@override final  dynamic value;

/// Create a copy of ErrorDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorDetailCopyWith<_ErrorDetail> get copyWith => __$ErrorDetailCopyWithImpl<_ErrorDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ErrorDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ErrorDetail&&(identical(other.location, location) || other.location == location)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.value, value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,location,message,const DeepCollectionEquality().hash(value));

@override
String toString() {
  return 'ErrorDetail(location: $location, message: $message, value: $value)';
}


}

/// @nodoc
abstract mixin class _$ErrorDetailCopyWith<$Res> implements $ErrorDetailCopyWith<$Res> {
  factory _$ErrorDetailCopyWith(_ErrorDetail value, $Res Function(_ErrorDetail) _then) = __$ErrorDetailCopyWithImpl;
@override @useResult
$Res call({
 String? location, String? message, dynamic value
});




}
/// @nodoc
class __$ErrorDetailCopyWithImpl<$Res>
    implements _$ErrorDetailCopyWith<$Res> {
  __$ErrorDetailCopyWithImpl(this._self, this._then);

  final _ErrorDetail _self;
  final $Res Function(_ErrorDetail) _then;

/// Create a copy of ErrorDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? location = freezed,Object? message = freezed,Object? value = freezed,}) {
  return _then(_ErrorDetail(
location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

// dart format on
