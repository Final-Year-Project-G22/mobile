// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_value_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthValueFailure<T> {

 T get failedValue;
/// Create a copy of AuthValueFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthValueFailureCopyWith<T, AuthValueFailure<T>> get copyWith => _$AuthValueFailureCopyWithImpl<T, AuthValueFailure<T>>(this as AuthValueFailure<T>, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthValueFailure<T>&&const DeepCollectionEquality().equals(other.failedValue, failedValue));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(failedValue));

@override
String toString() {
  return 'AuthValueFailure<$T>(failedValue: $failedValue)';
}


}

/// @nodoc
abstract mixin class $AuthValueFailureCopyWith<T,$Res>  {
  factory $AuthValueFailureCopyWith(AuthValueFailure<T> value, $Res Function(AuthValueFailure<T>) _then) = _$AuthValueFailureCopyWithImpl;
@useResult
$Res call({
 T failedValue
});




}
/// @nodoc
class _$AuthValueFailureCopyWithImpl<T,$Res>
    implements $AuthValueFailureCopyWith<T, $Res> {
  _$AuthValueFailureCopyWithImpl(this._self, this._then);

  final AuthValueFailure<T> _self;
  final $Res Function(AuthValueFailure<T>) _then;

/// Create a copy of AuthValueFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? failedValue = freezed,}) {
  return _then(_self.copyWith(
failedValue: freezed == failedValue ? _self.failedValue : failedValue // ignore: cast_nullable_to_non_nullable
as T,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthValueFailure].
extension AuthValueFailurePatterns<T> on AuthValueFailure<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( EmptyField<T> value)?  emptyField,TResult Function( InvalidEmail<T> value)?  invalidEmail,TResult Function( InvalidPassword<T> value)?  invalidPassword,TResult Function( InvalidFirstName<T> value)?  invalidFirstName,TResult Function( InvalidLastName<T> value)?  invalidLastName,TResult Function( ShortName<T> value)?  shortName,required TResult orElse(),}){
final _that = this;
switch (_that) {
case EmptyField() when emptyField != null:
return emptyField(_that);case InvalidEmail() when invalidEmail != null:
return invalidEmail(_that);case InvalidPassword() when invalidPassword != null:
return invalidPassword(_that);case InvalidFirstName() when invalidFirstName != null:
return invalidFirstName(_that);case InvalidLastName() when invalidLastName != null:
return invalidLastName(_that);case ShortName() when shortName != null:
return shortName(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( EmptyField<T> value)  emptyField,required TResult Function( InvalidEmail<T> value)  invalidEmail,required TResult Function( InvalidPassword<T> value)  invalidPassword,required TResult Function( InvalidFirstName<T> value)  invalidFirstName,required TResult Function( InvalidLastName<T> value)  invalidLastName,required TResult Function( ShortName<T> value)  shortName,}){
final _that = this;
switch (_that) {
case EmptyField():
return emptyField(_that);case InvalidEmail():
return invalidEmail(_that);case InvalidPassword():
return invalidPassword(_that);case InvalidFirstName():
return invalidFirstName(_that);case InvalidLastName():
return invalidLastName(_that);case ShortName():
return shortName(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( EmptyField<T> value)?  emptyField,TResult? Function( InvalidEmail<T> value)?  invalidEmail,TResult? Function( InvalidPassword<T> value)?  invalidPassword,TResult? Function( InvalidFirstName<T> value)?  invalidFirstName,TResult? Function( InvalidLastName<T> value)?  invalidLastName,TResult? Function( ShortName<T> value)?  shortName,}){
final _that = this;
switch (_that) {
case EmptyField() when emptyField != null:
return emptyField(_that);case InvalidEmail() when invalidEmail != null:
return invalidEmail(_that);case InvalidPassword() when invalidPassword != null:
return invalidPassword(_that);case InvalidFirstName() when invalidFirstName != null:
return invalidFirstName(_that);case InvalidLastName() when invalidLastName != null:
return invalidLastName(_that);case ShortName() when shortName != null:
return shortName(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( T failedValue,  String fieldName)?  emptyField,TResult Function( T failedValue)?  invalidEmail,TResult Function( T failedValue)?  invalidPassword,TResult Function( T failedValue)?  invalidFirstName,TResult Function( T failedValue)?  invalidLastName,TResult Function( T failedValue,  String fieldName)?  shortName,required TResult orElse(),}) {final _that = this;
switch (_that) {
case EmptyField() when emptyField != null:
return emptyField(_that.failedValue,_that.fieldName);case InvalidEmail() when invalidEmail != null:
return invalidEmail(_that.failedValue);case InvalidPassword() when invalidPassword != null:
return invalidPassword(_that.failedValue);case InvalidFirstName() when invalidFirstName != null:
return invalidFirstName(_that.failedValue);case InvalidLastName() when invalidLastName != null:
return invalidLastName(_that.failedValue);case ShortName() when shortName != null:
return shortName(_that.failedValue,_that.fieldName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( T failedValue,  String fieldName)  emptyField,required TResult Function( T failedValue)  invalidEmail,required TResult Function( T failedValue)  invalidPassword,required TResult Function( T failedValue)  invalidFirstName,required TResult Function( T failedValue)  invalidLastName,required TResult Function( T failedValue,  String fieldName)  shortName,}) {final _that = this;
switch (_that) {
case EmptyField():
return emptyField(_that.failedValue,_that.fieldName);case InvalidEmail():
return invalidEmail(_that.failedValue);case InvalidPassword():
return invalidPassword(_that.failedValue);case InvalidFirstName():
return invalidFirstName(_that.failedValue);case InvalidLastName():
return invalidLastName(_that.failedValue);case ShortName():
return shortName(_that.failedValue,_that.fieldName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( T failedValue,  String fieldName)?  emptyField,TResult? Function( T failedValue)?  invalidEmail,TResult? Function( T failedValue)?  invalidPassword,TResult? Function( T failedValue)?  invalidFirstName,TResult? Function( T failedValue)?  invalidLastName,TResult? Function( T failedValue,  String fieldName)?  shortName,}) {final _that = this;
switch (_that) {
case EmptyField() when emptyField != null:
return emptyField(_that.failedValue,_that.fieldName);case InvalidEmail() when invalidEmail != null:
return invalidEmail(_that.failedValue);case InvalidPassword() when invalidPassword != null:
return invalidPassword(_that.failedValue);case InvalidFirstName() when invalidFirstName != null:
return invalidFirstName(_that.failedValue);case InvalidLastName() when invalidLastName != null:
return invalidLastName(_that.failedValue);case ShortName() when shortName != null:
return shortName(_that.failedValue,_that.fieldName);case _:
  return null;

}
}

}

/// @nodoc


class EmptyField<T> implements AuthValueFailure<T> {
  const EmptyField({required this.failedValue, required this.fieldName});
  

@override final  T failedValue;
 final  String fieldName;

/// Create a copy of AuthValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmptyFieldCopyWith<T, EmptyField<T>> get copyWith => _$EmptyFieldCopyWithImpl<T, EmptyField<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmptyField<T>&&const DeepCollectionEquality().equals(other.failedValue, failedValue)&&(identical(other.fieldName, fieldName) || other.fieldName == fieldName));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(failedValue),fieldName);

@override
String toString() {
  return 'AuthValueFailure<$T>.emptyField(failedValue: $failedValue, fieldName: $fieldName)';
}


}

/// @nodoc
abstract mixin class $EmptyFieldCopyWith<T,$Res> implements $AuthValueFailureCopyWith<T, $Res> {
  factory $EmptyFieldCopyWith(EmptyField<T> value, $Res Function(EmptyField<T>) _then) = _$EmptyFieldCopyWithImpl;
@override @useResult
$Res call({
 T failedValue, String fieldName
});




}
/// @nodoc
class _$EmptyFieldCopyWithImpl<T,$Res>
    implements $EmptyFieldCopyWith<T, $Res> {
  _$EmptyFieldCopyWithImpl(this._self, this._then);

  final EmptyField<T> _self;
  final $Res Function(EmptyField<T>) _then;

/// Create a copy of AuthValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? failedValue = freezed,Object? fieldName = null,}) {
  return _then(EmptyField<T>(
failedValue: freezed == failedValue ? _self.failedValue : failedValue // ignore: cast_nullable_to_non_nullable
as T,fieldName: null == fieldName ? _self.fieldName : fieldName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class InvalidEmail<T> implements AuthValueFailure<T> {
  const InvalidEmail({required this.failedValue});
  

@override final  T failedValue;

/// Create a copy of AuthValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvalidEmailCopyWith<T, InvalidEmail<T>> get copyWith => _$InvalidEmailCopyWithImpl<T, InvalidEmail<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidEmail<T>&&const DeepCollectionEquality().equals(other.failedValue, failedValue));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(failedValue));

@override
String toString() {
  return 'AuthValueFailure<$T>.invalidEmail(failedValue: $failedValue)';
}


}

/// @nodoc
abstract mixin class $InvalidEmailCopyWith<T,$Res> implements $AuthValueFailureCopyWith<T, $Res> {
  factory $InvalidEmailCopyWith(InvalidEmail<T> value, $Res Function(InvalidEmail<T>) _then) = _$InvalidEmailCopyWithImpl;
@override @useResult
$Res call({
 T failedValue
});




}
/// @nodoc
class _$InvalidEmailCopyWithImpl<T,$Res>
    implements $InvalidEmailCopyWith<T, $Res> {
  _$InvalidEmailCopyWithImpl(this._self, this._then);

  final InvalidEmail<T> _self;
  final $Res Function(InvalidEmail<T>) _then;

/// Create a copy of AuthValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? failedValue = freezed,}) {
  return _then(InvalidEmail<T>(
failedValue: freezed == failedValue ? _self.failedValue : failedValue // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

/// @nodoc


class InvalidPassword<T> implements AuthValueFailure<T> {
  const InvalidPassword({required this.failedValue});
  

@override final  T failedValue;

/// Create a copy of AuthValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvalidPasswordCopyWith<T, InvalidPassword<T>> get copyWith => _$InvalidPasswordCopyWithImpl<T, InvalidPassword<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidPassword<T>&&const DeepCollectionEquality().equals(other.failedValue, failedValue));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(failedValue));

@override
String toString() {
  return 'AuthValueFailure<$T>.invalidPassword(failedValue: $failedValue)';
}


}

/// @nodoc
abstract mixin class $InvalidPasswordCopyWith<T,$Res> implements $AuthValueFailureCopyWith<T, $Res> {
  factory $InvalidPasswordCopyWith(InvalidPassword<T> value, $Res Function(InvalidPassword<T>) _then) = _$InvalidPasswordCopyWithImpl;
@override @useResult
$Res call({
 T failedValue
});




}
/// @nodoc
class _$InvalidPasswordCopyWithImpl<T,$Res>
    implements $InvalidPasswordCopyWith<T, $Res> {
  _$InvalidPasswordCopyWithImpl(this._self, this._then);

  final InvalidPassword<T> _self;
  final $Res Function(InvalidPassword<T>) _then;

/// Create a copy of AuthValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? failedValue = freezed,}) {
  return _then(InvalidPassword<T>(
failedValue: freezed == failedValue ? _self.failedValue : failedValue // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

/// @nodoc


class InvalidFirstName<T> implements AuthValueFailure<T> {
  const InvalidFirstName({required this.failedValue});
  

@override final  T failedValue;

/// Create a copy of AuthValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvalidFirstNameCopyWith<T, InvalidFirstName<T>> get copyWith => _$InvalidFirstNameCopyWithImpl<T, InvalidFirstName<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidFirstName<T>&&const DeepCollectionEquality().equals(other.failedValue, failedValue));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(failedValue));

@override
String toString() {
  return 'AuthValueFailure<$T>.invalidFirstName(failedValue: $failedValue)';
}


}

/// @nodoc
abstract mixin class $InvalidFirstNameCopyWith<T,$Res> implements $AuthValueFailureCopyWith<T, $Res> {
  factory $InvalidFirstNameCopyWith(InvalidFirstName<T> value, $Res Function(InvalidFirstName<T>) _then) = _$InvalidFirstNameCopyWithImpl;
@override @useResult
$Res call({
 T failedValue
});




}
/// @nodoc
class _$InvalidFirstNameCopyWithImpl<T,$Res>
    implements $InvalidFirstNameCopyWith<T, $Res> {
  _$InvalidFirstNameCopyWithImpl(this._self, this._then);

  final InvalidFirstName<T> _self;
  final $Res Function(InvalidFirstName<T>) _then;

/// Create a copy of AuthValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? failedValue = freezed,}) {
  return _then(InvalidFirstName<T>(
failedValue: freezed == failedValue ? _self.failedValue : failedValue // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

/// @nodoc


class InvalidLastName<T> implements AuthValueFailure<T> {
  const InvalidLastName({required this.failedValue});
  

@override final  T failedValue;

/// Create a copy of AuthValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvalidLastNameCopyWith<T, InvalidLastName<T>> get copyWith => _$InvalidLastNameCopyWithImpl<T, InvalidLastName<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidLastName<T>&&const DeepCollectionEquality().equals(other.failedValue, failedValue));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(failedValue));

@override
String toString() {
  return 'AuthValueFailure<$T>.invalidLastName(failedValue: $failedValue)';
}


}

/// @nodoc
abstract mixin class $InvalidLastNameCopyWith<T,$Res> implements $AuthValueFailureCopyWith<T, $Res> {
  factory $InvalidLastNameCopyWith(InvalidLastName<T> value, $Res Function(InvalidLastName<T>) _then) = _$InvalidLastNameCopyWithImpl;
@override @useResult
$Res call({
 T failedValue
});




}
/// @nodoc
class _$InvalidLastNameCopyWithImpl<T,$Res>
    implements $InvalidLastNameCopyWith<T, $Res> {
  _$InvalidLastNameCopyWithImpl(this._self, this._then);

  final InvalidLastName<T> _self;
  final $Res Function(InvalidLastName<T>) _then;

/// Create a copy of AuthValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? failedValue = freezed,}) {
  return _then(InvalidLastName<T>(
failedValue: freezed == failedValue ? _self.failedValue : failedValue // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

/// @nodoc


class ShortName<T> implements AuthValueFailure<T> {
  const ShortName({required this.failedValue, required this.fieldName});
  

@override final  T failedValue;
 final  String fieldName;

/// Create a copy of AuthValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShortNameCopyWith<T, ShortName<T>> get copyWith => _$ShortNameCopyWithImpl<T, ShortName<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShortName<T>&&const DeepCollectionEquality().equals(other.failedValue, failedValue)&&(identical(other.fieldName, fieldName) || other.fieldName == fieldName));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(failedValue),fieldName);

@override
String toString() {
  return 'AuthValueFailure<$T>.shortName(failedValue: $failedValue, fieldName: $fieldName)';
}


}

/// @nodoc
abstract mixin class $ShortNameCopyWith<T,$Res> implements $AuthValueFailureCopyWith<T, $Res> {
  factory $ShortNameCopyWith(ShortName<T> value, $Res Function(ShortName<T>) _then) = _$ShortNameCopyWithImpl;
@override @useResult
$Res call({
 T failedValue, String fieldName
});




}
/// @nodoc
class _$ShortNameCopyWithImpl<T,$Res>
    implements $ShortNameCopyWith<T, $Res> {
  _$ShortNameCopyWithImpl(this._self, this._then);

  final ShortName<T> _self;
  final $Res Function(ShortName<T>) _then;

/// Create a copy of AuthValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? failedValue = freezed,Object? fieldName = null,}) {
  return _then(ShortName<T>(
failedValue: freezed == failedValue ? _self.failedValue : failedValue // ignore: cast_nullable_to_non_nullable
as T,fieldName: null == fieldName ? _self.fieldName : fieldName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
