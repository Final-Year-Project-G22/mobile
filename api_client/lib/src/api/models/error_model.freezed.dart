// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'error_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ErrorModel {

/// A URI reference to human-readable documentation for the error.
 String get type;/// A URL to the JSON Schema for this object.
@JsonKey(name: '\$schema') String? get schema;/// A human-readable explanation specific to this occurrence of the problem.
 String? get detail;/// Optional list of individual error details
 List<dynamic>? get errors;/// A URI reference that identifies the specific occurrence of the problem.
 String? get instance;/// HTTP status code
 int? get status;/// A short, human-readable summary of the problem type. This value should not change between occurrences of the error.
 String? get title;
/// Create a copy of ErrorModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorModelCopyWith<ErrorModel> get copyWith => _$ErrorModelCopyWithImpl<ErrorModel>(this as ErrorModel, _$identity);

  /// Serializes this ErrorModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorModel&&(identical(other.type, type) || other.type == type)&&(identical(other.schema, schema) || other.schema == schema)&&(identical(other.detail, detail) || other.detail == detail)&&const DeepCollectionEquality().equals(other.errors, errors)&&(identical(other.instance, instance) || other.instance == instance)&&(identical(other.status, status) || other.status == status)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,schema,detail,const DeepCollectionEquality().hash(errors),instance,status,title);

@override
String toString() {
  return 'ErrorModel(type: $type, schema: $schema, detail: $detail, errors: $errors, instance: $instance, status: $status, title: $title)';
}


}

/// @nodoc
abstract mixin class $ErrorModelCopyWith<$Res>  {
  factory $ErrorModelCopyWith(ErrorModel value, $Res Function(ErrorModel) _then) = _$ErrorModelCopyWithImpl;
@useResult
$Res call({
 String type,@JsonKey(name: '\$schema') String? schema, String? detail, List<dynamic>? errors, String? instance, int? status, String? title
});




}
/// @nodoc
class _$ErrorModelCopyWithImpl<$Res>
    implements $ErrorModelCopyWith<$Res> {
  _$ErrorModelCopyWithImpl(this._self, this._then);

  final ErrorModel _self;
  final $Res Function(ErrorModel) _then;

/// Create a copy of ErrorModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? schema = freezed,Object? detail = freezed,Object? errors = freezed,Object? instance = freezed,Object? status = freezed,Object? title = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,schema: freezed == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String?,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String?,errors: freezed == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,instance: freezed == instance ? _self.instance : instance // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ErrorModel].
extension ErrorModelPatterns on ErrorModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ErrorModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ErrorModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ErrorModel value)  $default,){
final _that = this;
switch (_that) {
case _ErrorModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ErrorModel value)?  $default,){
final _that = this;
switch (_that) {
case _ErrorModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type, @JsonKey(name: '\$schema')  String? schema,  String? detail,  List<dynamic>? errors,  String? instance,  int? status,  String? title)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ErrorModel() when $default != null:
return $default(_that.type,_that.schema,_that.detail,_that.errors,_that.instance,_that.status,_that.title);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type, @JsonKey(name: '\$schema')  String? schema,  String? detail,  List<dynamic>? errors,  String? instance,  int? status,  String? title)  $default,) {final _that = this;
switch (_that) {
case _ErrorModel():
return $default(_that.type,_that.schema,_that.detail,_that.errors,_that.instance,_that.status,_that.title);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type, @JsonKey(name: '\$schema')  String? schema,  String? detail,  List<dynamic>? errors,  String? instance,  int? status,  String? title)?  $default,) {final _that = this;
switch (_that) {
case _ErrorModel() when $default != null:
return $default(_that.type,_that.schema,_that.detail,_that.errors,_that.instance,_that.status,_that.title);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ErrorModel implements ErrorModel {
  const _ErrorModel({this.type = 'about:blank', @JsonKey(name: '\$schema') this.schema, this.detail, final  List<dynamic>? errors, this.instance, this.status, this.title}): _errors = errors;
  factory _ErrorModel.fromJson(Map<String, dynamic> json) => _$ErrorModelFromJson(json);

/// A URI reference to human-readable documentation for the error.
@override@JsonKey() final  String type;
/// A URL to the JSON Schema for this object.
@override@JsonKey(name: '\$schema') final  String? schema;
/// A human-readable explanation specific to this occurrence of the problem.
@override final  String? detail;
/// Optional list of individual error details
 final  List<dynamic>? _errors;
/// Optional list of individual error details
@override List<dynamic>? get errors {
  final value = _errors;
  if (value == null) return null;
  if (_errors is EqualUnmodifiableListView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// A URI reference that identifies the specific occurrence of the problem.
@override final  String? instance;
/// HTTP status code
@override final  int? status;
/// A short, human-readable summary of the problem type. This value should not change between occurrences of the error.
@override final  String? title;

/// Create a copy of ErrorModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorModelCopyWith<_ErrorModel> get copyWith => __$ErrorModelCopyWithImpl<_ErrorModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ErrorModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ErrorModel&&(identical(other.type, type) || other.type == type)&&(identical(other.schema, schema) || other.schema == schema)&&(identical(other.detail, detail) || other.detail == detail)&&const DeepCollectionEquality().equals(other._errors, _errors)&&(identical(other.instance, instance) || other.instance == instance)&&(identical(other.status, status) || other.status == status)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,schema,detail,const DeepCollectionEquality().hash(_errors),instance,status,title);

@override
String toString() {
  return 'ErrorModel(type: $type, schema: $schema, detail: $detail, errors: $errors, instance: $instance, status: $status, title: $title)';
}


}

/// @nodoc
abstract mixin class _$ErrorModelCopyWith<$Res> implements $ErrorModelCopyWith<$Res> {
  factory _$ErrorModelCopyWith(_ErrorModel value, $Res Function(_ErrorModel) _then) = __$ErrorModelCopyWithImpl;
@override @useResult
$Res call({
 String type,@JsonKey(name: '\$schema') String? schema, String? detail, List<dynamic>? errors, String? instance, int? status, String? title
});




}
/// @nodoc
class __$ErrorModelCopyWithImpl<$Res>
    implements _$ErrorModelCopyWith<$Res> {
  __$ErrorModelCopyWithImpl(this._self, this._then);

  final _ErrorModel _self;
  final $Res Function(_ErrorModel) _then;

/// Create a copy of ErrorModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? schema = freezed,Object? detail = freezed,Object? errors = freezed,Object? instance = freezed,Object? status = freezed,Object? title = freezed,}) {
  return _then(_ErrorModel(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,schema: freezed == schema ? _self.schema : schema // ignore: cast_nullable_to_non_nullable
as String?,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String?,errors: freezed == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,instance: freezed == instance ? _self.instance : instance // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
