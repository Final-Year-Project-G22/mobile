// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileFailure {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileFailure()';
}


}

/// @nodoc
class $ProfileFailureCopyWith<$Res>  {
$ProfileFailureCopyWith(ProfileFailure _, $Res Function(ProfileFailure) __);
}


/// Adds pattern-matching-related methods to [ProfileFailure].
extension ProfileFailurePatterns on ProfileFailure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _UnableToUpdate value)?  unableToUpdate,TResult Function( _ServerError value)?  serverError,TResult Function( _UnableToUpload value)?  unableToUpload,TResult Function( _InvalidProfileData value)?  invalidProfileData,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UnableToUpdate() when unableToUpdate != null:
return unableToUpdate(_that);case _ServerError() when serverError != null:
return serverError(_that);case _UnableToUpload() when unableToUpload != null:
return unableToUpload(_that);case _InvalidProfileData() when invalidProfileData != null:
return invalidProfileData(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _UnableToUpdate value)  unableToUpdate,required TResult Function( _ServerError value)  serverError,required TResult Function( _UnableToUpload value)  unableToUpload,required TResult Function( _InvalidProfileData value)  invalidProfileData,}){
final _that = this;
switch (_that) {
case _UnableToUpdate():
return unableToUpdate(_that);case _ServerError():
return serverError(_that);case _UnableToUpload():
return unableToUpload(_that);case _InvalidProfileData():
return invalidProfileData(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _UnableToUpdate value)?  unableToUpdate,TResult? Function( _ServerError value)?  serverError,TResult? Function( _UnableToUpload value)?  unableToUpload,TResult? Function( _InvalidProfileData value)?  invalidProfileData,}){
final _that = this;
switch (_that) {
case _UnableToUpdate() when unableToUpdate != null:
return unableToUpdate(_that);case _ServerError() when serverError != null:
return serverError(_that);case _UnableToUpload() when unableToUpload != null:
return unableToUpload(_that);case _InvalidProfileData() when invalidProfileData != null:
return invalidProfileData(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  unableToUpdate,TResult Function()?  serverError,TResult Function()?  unableToUpload,TResult Function()?  invalidProfileData,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UnableToUpdate() when unableToUpdate != null:
return unableToUpdate();case _ServerError() when serverError != null:
return serverError();case _UnableToUpload() when unableToUpload != null:
return unableToUpload();case _InvalidProfileData() when invalidProfileData != null:
return invalidProfileData();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  unableToUpdate,required TResult Function()  serverError,required TResult Function()  unableToUpload,required TResult Function()  invalidProfileData,}) {final _that = this;
switch (_that) {
case _UnableToUpdate():
return unableToUpdate();case _ServerError():
return serverError();case _UnableToUpload():
return unableToUpload();case _InvalidProfileData():
return invalidProfileData();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  unableToUpdate,TResult? Function()?  serverError,TResult? Function()?  unableToUpload,TResult? Function()?  invalidProfileData,}) {final _that = this;
switch (_that) {
case _UnableToUpdate() when unableToUpdate != null:
return unableToUpdate();case _ServerError() when serverError != null:
return serverError();case _UnableToUpload() when unableToUpload != null:
return unableToUpload();case _InvalidProfileData() when invalidProfileData != null:
return invalidProfileData();case _:
  return null;

}
}

}

/// @nodoc


class _UnableToUpdate implements ProfileFailure {
  const _UnableToUpdate();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnableToUpdate);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileFailure.unableToUpdate()';
}


}




/// @nodoc


class _ServerError implements ProfileFailure {
  const _ServerError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServerError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileFailure.serverError()';
}


}




/// @nodoc


class _UnableToUpload implements ProfileFailure {
  const _UnableToUpload();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnableToUpload);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileFailure.unableToUpload()';
}


}




/// @nodoc


class _InvalidProfileData implements ProfileFailure {
  const _InvalidProfileData();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InvalidProfileData);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileFailure.invalidProfileData()';
}


}




// dart format on
