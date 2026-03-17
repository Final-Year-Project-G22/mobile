// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthFailure {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure()';
}


}

/// @nodoc
class $AuthFailureCopyWith<$Res>  {
$AuthFailureCopyWith(AuthFailure _, $Res Function(AuthFailure) __);
}


/// Adds pattern-matching-related methods to [AuthFailure].
extension AuthFailurePatterns on AuthFailure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( EmailAlreadyInUse value)?  emailAlreadyInUse,TResult Function( InvalidEmailAndPasswordCombination value)?  invalidEmailAndPasswordCombination,TResult Function( ServerError value)?  serverError,TResult Function( NetworkError value)?  networkError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case EmailAlreadyInUse() when emailAlreadyInUse != null:
return emailAlreadyInUse(_that);case InvalidEmailAndPasswordCombination() when invalidEmailAndPasswordCombination != null:
return invalidEmailAndPasswordCombination(_that);case ServerError() when serverError != null:
return serverError(_that);case NetworkError() when networkError != null:
return networkError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( EmailAlreadyInUse value)  emailAlreadyInUse,required TResult Function( InvalidEmailAndPasswordCombination value)  invalidEmailAndPasswordCombination,required TResult Function( ServerError value)  serverError,required TResult Function( NetworkError value)  networkError,}){
final _that = this;
switch (_that) {
case EmailAlreadyInUse():
return emailAlreadyInUse(_that);case InvalidEmailAndPasswordCombination():
return invalidEmailAndPasswordCombination(_that);case ServerError():
return serverError(_that);case NetworkError():
return networkError(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( EmailAlreadyInUse value)?  emailAlreadyInUse,TResult? Function( InvalidEmailAndPasswordCombination value)?  invalidEmailAndPasswordCombination,TResult? Function( ServerError value)?  serverError,TResult? Function( NetworkError value)?  networkError,}){
final _that = this;
switch (_that) {
case EmailAlreadyInUse() when emailAlreadyInUse != null:
return emailAlreadyInUse(_that);case InvalidEmailAndPasswordCombination() when invalidEmailAndPasswordCombination != null:
return invalidEmailAndPasswordCombination(_that);case ServerError() when serverError != null:
return serverError(_that);case NetworkError() when networkError != null:
return networkError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  emailAlreadyInUse,TResult Function()?  invalidEmailAndPasswordCombination,TResult Function()?  serverError,TResult Function()?  networkError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case EmailAlreadyInUse() when emailAlreadyInUse != null:
return emailAlreadyInUse();case InvalidEmailAndPasswordCombination() when invalidEmailAndPasswordCombination != null:
return invalidEmailAndPasswordCombination();case ServerError() when serverError != null:
return serverError();case NetworkError() when networkError != null:
return networkError();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  emailAlreadyInUse,required TResult Function()  invalidEmailAndPasswordCombination,required TResult Function()  serverError,required TResult Function()  networkError,}) {final _that = this;
switch (_that) {
case EmailAlreadyInUse():
return emailAlreadyInUse();case InvalidEmailAndPasswordCombination():
return invalidEmailAndPasswordCombination();case ServerError():
return serverError();case NetworkError():
return networkError();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  emailAlreadyInUse,TResult? Function()?  invalidEmailAndPasswordCombination,TResult? Function()?  serverError,TResult? Function()?  networkError,}) {final _that = this;
switch (_that) {
case EmailAlreadyInUse() when emailAlreadyInUse != null:
return emailAlreadyInUse();case InvalidEmailAndPasswordCombination() when invalidEmailAndPasswordCombination != null:
return invalidEmailAndPasswordCombination();case ServerError() when serverError != null:
return serverError();case NetworkError() when networkError != null:
return networkError();case _:
  return null;

}
}

}

/// @nodoc


class EmailAlreadyInUse implements AuthFailure {
  const EmailAlreadyInUse();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailAlreadyInUse);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure.emailAlreadyInUse()';
}


}




/// @nodoc


class InvalidEmailAndPasswordCombination implements AuthFailure {
  const InvalidEmailAndPasswordCombination();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidEmailAndPasswordCombination);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure.invalidEmailAndPasswordCombination()';
}


}




/// @nodoc


class ServerError implements AuthFailure {
  const ServerError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure.serverError()';
}


}




/// @nodoc


class NetworkError implements AuthFailure {
  const NetworkError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure.networkError()';
}


}




// dart format on
