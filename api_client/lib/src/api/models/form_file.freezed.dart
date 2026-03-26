// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'form_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FormFile {

@JsonKey(name: 'ContentType') String get contentType;@JsonKey(name: 'Filename') String get filename;@JsonKey(name: 'IsSet') bool get isSet;@JsonKey(name: 'Size') int get size;
/// Create a copy of FormFile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormFileCopyWith<FormFile> get copyWith => _$FormFileCopyWithImpl<FormFile>(this as FormFile, _$identity);

  /// Serializes this FormFile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormFile&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.filename, filename) || other.filename == filename)&&(identical(other.isSet, isSet) || other.isSet == isSet)&&(identical(other.size, size) || other.size == size));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,contentType,filename,isSet,size);

@override
String toString() {
  return 'FormFile(contentType: $contentType, filename: $filename, isSet: $isSet, size: $size)';
}


}

/// @nodoc
abstract mixin class $FormFileCopyWith<$Res>  {
  factory $FormFileCopyWith(FormFile value, $Res Function(FormFile) _then) = _$FormFileCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'ContentType') String contentType,@JsonKey(name: 'Filename') String filename,@JsonKey(name: 'IsSet') bool isSet,@JsonKey(name: 'Size') int size
});




}
/// @nodoc
class _$FormFileCopyWithImpl<$Res>
    implements $FormFileCopyWith<$Res> {
  _$FormFileCopyWithImpl(this._self, this._then);

  final FormFile _self;
  final $Res Function(FormFile) _then;

/// Create a copy of FormFile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? contentType = null,Object? filename = null,Object? isSet = null,Object? size = null,}) {
  return _then(_self.copyWith(
contentType: null == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as String,filename: null == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String,isSet: null == isSet ? _self.isSet : isSet // ignore: cast_nullable_to_non_nullable
as bool,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FormFile].
extension FormFilePatterns on FormFile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FormFile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FormFile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FormFile value)  $default,){
final _that = this;
switch (_that) {
case _FormFile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FormFile value)?  $default,){
final _that = this;
switch (_that) {
case _FormFile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'ContentType')  String contentType, @JsonKey(name: 'Filename')  String filename, @JsonKey(name: 'IsSet')  bool isSet, @JsonKey(name: 'Size')  int size)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FormFile() when $default != null:
return $default(_that.contentType,_that.filename,_that.isSet,_that.size);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'ContentType')  String contentType, @JsonKey(name: 'Filename')  String filename, @JsonKey(name: 'IsSet')  bool isSet, @JsonKey(name: 'Size')  int size)  $default,) {final _that = this;
switch (_that) {
case _FormFile():
return $default(_that.contentType,_that.filename,_that.isSet,_that.size);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'ContentType')  String contentType, @JsonKey(name: 'Filename')  String filename, @JsonKey(name: 'IsSet')  bool isSet, @JsonKey(name: 'Size')  int size)?  $default,) {final _that = this;
switch (_that) {
case _FormFile() when $default != null:
return $default(_that.contentType,_that.filename,_that.isSet,_that.size);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FormFile implements FormFile {
  const _FormFile({@JsonKey(name: 'ContentType') required this.contentType, @JsonKey(name: 'Filename') required this.filename, @JsonKey(name: 'IsSet') required this.isSet, @JsonKey(name: 'Size') required this.size});
  factory _FormFile.fromJson(Map<String, dynamic> json) => _$FormFileFromJson(json);

@override@JsonKey(name: 'ContentType') final  String contentType;
@override@JsonKey(name: 'Filename') final  String filename;
@override@JsonKey(name: 'IsSet') final  bool isSet;
@override@JsonKey(name: 'Size') final  int size;

/// Create a copy of FormFile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FormFileCopyWith<_FormFile> get copyWith => __$FormFileCopyWithImpl<_FormFile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormFileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FormFile&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.filename, filename) || other.filename == filename)&&(identical(other.isSet, isSet) || other.isSet == isSet)&&(identical(other.size, size) || other.size == size));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,contentType,filename,isSet,size);

@override
String toString() {
  return 'FormFile(contentType: $contentType, filename: $filename, isSet: $isSet, size: $size)';
}


}

/// @nodoc
abstract mixin class _$FormFileCopyWith<$Res> implements $FormFileCopyWith<$Res> {
  factory _$FormFileCopyWith(_FormFile value, $Res Function(_FormFile) _then) = __$FormFileCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'ContentType') String contentType,@JsonKey(name: 'Filename') String filename,@JsonKey(name: 'IsSet') bool isSet,@JsonKey(name: 'Size') int size
});




}
/// @nodoc
class __$FormFileCopyWithImpl<$Res>
    implements _$FormFileCopyWith<$Res> {
  __$FormFileCopyWithImpl(this._self, this._then);

  final _FormFile _self;
  final $Res Function(_FormFile) _then;

/// Create a copy of FormFile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? contentType = null,Object? filename = null,Object? isSet = null,Object? size = null,}) {
  return _then(_FormFile(
contentType: null == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as String,filename: null == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String,isSet: null == isSet ? _self.isSet : isSet // ignore: cast_nullable_to_non_nullable
as bool,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
