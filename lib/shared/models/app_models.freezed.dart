// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PageResult<T> {

 List<T> get records; int get total; int get pageNo; int get pageSize;
/// Create a copy of PageResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PageResultCopyWith<T, PageResult<T>> get copyWith => _$PageResultCopyWithImpl<T, PageResult<T>>(this as PageResult<T>, _$identity);

  /// Serializes this PageResult to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT);


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PageResult<T>&&const DeepCollectionEquality().equals(other.records, records)&&(identical(other.total, total) || other.total == total)&&(identical(other.pageNo, pageNo) || other.pageNo == pageNo)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(records),total,pageNo,pageSize);

@override
String toString() {
  return 'PageResult<$T>(records: $records, total: $total, pageNo: $pageNo, pageSize: $pageSize)';
}


}

/// @nodoc
abstract mixin class $PageResultCopyWith<T,$Res>  {
  factory $PageResultCopyWith(PageResult<T> value, $Res Function(PageResult<T>) _then) = _$PageResultCopyWithImpl;
@useResult
$Res call({
 List<T> records, int total, int pageNo, int pageSize
});




}
/// @nodoc
class _$PageResultCopyWithImpl<T,$Res>
    implements $PageResultCopyWith<T, $Res> {
  _$PageResultCopyWithImpl(this._self, this._then);

  final PageResult<T> _self;
  final $Res Function(PageResult<T>) _then;

/// Create a copy of PageResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? records = null,Object? total = null,Object? pageNo = null,Object? pageSize = null,}) {
  return _then(_self.copyWith(
records: null == records ? _self.records : records // ignore: cast_nullable_to_non_nullable
as List<T>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,pageNo: null == pageNo ? _self.pageNo : pageNo // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PageResult].
extension PageResultPatterns<T> on PageResult<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PageResult<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PageResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PageResult<T> value)  $default,){
final _that = this;
switch (_that) {
case _PageResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PageResult<T> value)?  $default,){
final _that = this;
switch (_that) {
case _PageResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<T> records,  int total,  int pageNo,  int pageSize)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PageResult() when $default != null:
return $default(_that.records,_that.total,_that.pageNo,_that.pageSize);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<T> records,  int total,  int pageNo,  int pageSize)  $default,) {final _that = this;
switch (_that) {
case _PageResult():
return $default(_that.records,_that.total,_that.pageNo,_that.pageSize);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<T> records,  int total,  int pageNo,  int pageSize)?  $default,) {final _that = this;
switch (_that) {
case _PageResult() when $default != null:
return $default(_that.records,_that.total,_that.pageNo,_that.pageSize);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)

class _PageResult<T> implements PageResult<T> {
  const _PageResult({final  List<T> records = const [], this.total = 0, this.pageNo = 1, this.pageSize = 20}): _records = records;
  factory _PageResult.fromJson(Map<String, dynamic> json,T Function(Object?) fromJsonT) => _$PageResultFromJson(json,fromJsonT);

 final  List<T> _records;
@override@JsonKey() List<T> get records {
  if (_records is EqualUnmodifiableListView) return _records;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_records);
}

@override@JsonKey() final  int total;
@override@JsonKey() final  int pageNo;
@override@JsonKey() final  int pageSize;

/// Create a copy of PageResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PageResultCopyWith<T, _PageResult<T>> get copyWith => __$PageResultCopyWithImpl<T, _PageResult<T>>(this, _$identity);

@override
Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
  return _$PageResultToJson<T>(this, toJsonT);
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PageResult<T>&&const DeepCollectionEquality().equals(other._records, _records)&&(identical(other.total, total) || other.total == total)&&(identical(other.pageNo, pageNo) || other.pageNo == pageNo)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_records),total,pageNo,pageSize);

@override
String toString() {
  return 'PageResult<$T>(records: $records, total: $total, pageNo: $pageNo, pageSize: $pageSize)';
}


}

/// @nodoc
abstract mixin class _$PageResultCopyWith<T,$Res> implements $PageResultCopyWith<T, $Res> {
  factory _$PageResultCopyWith(_PageResult<T> value, $Res Function(_PageResult<T>) _then) = __$PageResultCopyWithImpl;
@override @useResult
$Res call({
 List<T> records, int total, int pageNo, int pageSize
});




}
/// @nodoc
class __$PageResultCopyWithImpl<T,$Res>
    implements _$PageResultCopyWith<T, $Res> {
  __$PageResultCopyWithImpl(this._self, this._then);

  final _PageResult<T> _self;
  final $Res Function(_PageResult<T>) _then;

/// Create a copy of PageResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? records = null,Object? total = null,Object? pageNo = null,Object? pageSize = null,}) {
  return _then(_PageResult<T>(
records: null == records ? _self._records : records // ignore: cast_nullable_to_non_nullable
as List<T>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,pageNo: null == pageNo ? _self.pageNo : pageNo // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$AuthSession {

 String get accessToken; String? get tokenType; UserProfile? get user;
/// Create a copy of AuthSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthSessionCopyWith<AuthSession> get copyWith => _$AuthSessionCopyWithImpl<AuthSession>(this as AuthSession, _$identity);

  /// Serializes this AuthSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthSession&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.tokenType, tokenType) || other.tokenType == tokenType)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,tokenType,user);

@override
String toString() {
  return 'AuthSession(accessToken: $accessToken, tokenType: $tokenType, user: $user)';
}


}

/// @nodoc
abstract mixin class $AuthSessionCopyWith<$Res>  {
  factory $AuthSessionCopyWith(AuthSession value, $Res Function(AuthSession) _then) = _$AuthSessionCopyWithImpl;
@useResult
$Res call({
 String accessToken, String? tokenType, UserProfile? user
});


$UserProfileCopyWith<$Res>? get user;

}
/// @nodoc
class _$AuthSessionCopyWithImpl<$Res>
    implements $AuthSessionCopyWith<$Res> {
  _$AuthSessionCopyWithImpl(this._self, this._then);

  final AuthSession _self;
  final $Res Function(AuthSession) _then;

/// Create a copy of AuthSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accessToken = null,Object? tokenType = freezed,Object? user = freezed,}) {
  return _then(_self.copyWith(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,tokenType: freezed == tokenType ? _self.tokenType : tokenType // ignore: cast_nullable_to_non_nullable
as String?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserProfile?,
  ));
}
/// Create a copy of AuthSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserProfileCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserProfileCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [AuthSession].
extension AuthSessionPatterns on AuthSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthSession value)  $default,){
final _that = this;
switch (_that) {
case _AuthSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthSession value)?  $default,){
final _that = this;
switch (_that) {
case _AuthSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String accessToken,  String? tokenType,  UserProfile? user)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthSession() when $default != null:
return $default(_that.accessToken,_that.tokenType,_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String accessToken,  String? tokenType,  UserProfile? user)  $default,) {final _that = this;
switch (_that) {
case _AuthSession():
return $default(_that.accessToken,_that.tokenType,_that.user);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String accessToken,  String? tokenType,  UserProfile? user)?  $default,) {final _that = this;
switch (_that) {
case _AuthSession() when $default != null:
return $default(_that.accessToken,_that.tokenType,_that.user);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthSession implements AuthSession {
  const _AuthSession({required this.accessToken, this.tokenType, this.user});
  factory _AuthSession.fromJson(Map<String, dynamic> json) => _$AuthSessionFromJson(json);

@override final  String accessToken;
@override final  String? tokenType;
@override final  UserProfile? user;

/// Create a copy of AuthSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthSessionCopyWith<_AuthSession> get copyWith => __$AuthSessionCopyWithImpl<_AuthSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthSessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthSession&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.tokenType, tokenType) || other.tokenType == tokenType)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,tokenType,user);

@override
String toString() {
  return 'AuthSession(accessToken: $accessToken, tokenType: $tokenType, user: $user)';
}


}

/// @nodoc
abstract mixin class _$AuthSessionCopyWith<$Res> implements $AuthSessionCopyWith<$Res> {
  factory _$AuthSessionCopyWith(_AuthSession value, $Res Function(_AuthSession) _then) = __$AuthSessionCopyWithImpl;
@override @useResult
$Res call({
 String accessToken, String? tokenType, UserProfile? user
});


@override $UserProfileCopyWith<$Res>? get user;

}
/// @nodoc
class __$AuthSessionCopyWithImpl<$Res>
    implements _$AuthSessionCopyWith<$Res> {
  __$AuthSessionCopyWithImpl(this._self, this._then);

  final _AuthSession _self;
  final $Res Function(_AuthSession) _then;

/// Create a copy of AuthSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accessToken = null,Object? tokenType = freezed,Object? user = freezed,}) {
  return _then(_AuthSession(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,tokenType: freezed == tokenType ? _self.tokenType : tokenType // ignore: cast_nullable_to_non_nullable
as String?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserProfile?,
  ));
}

/// Create a copy of AuthSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserProfileCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserProfileCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// @nodoc
mixin _$UserProfile {

 String? get email; String? get userName; String? get avatarKey; String? get inviteCode; int? get status; String? get createdAt;
/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileCopyWith<UserProfile> get copyWith => _$UserProfileCopyWithImpl<UserProfile>(this as UserProfile, _$identity);

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfile&&(identical(other.email, email) || other.email == email)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.avatarKey, avatarKey) || other.avatarKey == avatarKey)&&(identical(other.inviteCode, inviteCode) || other.inviteCode == inviteCode)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,userName,avatarKey,inviteCode,status,createdAt);

@override
String toString() {
  return 'UserProfile(email: $email, userName: $userName, avatarKey: $avatarKey, inviteCode: $inviteCode, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $UserProfileCopyWith<$Res>  {
  factory $UserProfileCopyWith(UserProfile value, $Res Function(UserProfile) _then) = _$UserProfileCopyWithImpl;
@useResult
$Res call({
 String? email, String? userName, String? avatarKey, String? inviteCode, int? status, String? createdAt
});




}
/// @nodoc
class _$UserProfileCopyWithImpl<$Res>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._self, this._then);

  final UserProfile _self;
  final $Res Function(UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = freezed,Object? userName = freezed,Object? avatarKey = freezed,Object? inviteCode = freezed,Object? status = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,avatarKey: freezed == avatarKey ? _self.avatarKey : avatarKey // ignore: cast_nullable_to_non_nullable
as String?,inviteCode: freezed == inviteCode ? _self.inviteCode : inviteCode // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserProfile].
extension UserProfilePatterns on UserProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfile value)  $default,){
final _that = this;
switch (_that) {
case _UserProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfile value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? email,  String? userName,  String? avatarKey,  String? inviteCode,  int? status,  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.email,_that.userName,_that.avatarKey,_that.inviteCode,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? email,  String? userName,  String? avatarKey,  String? inviteCode,  int? status,  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that.email,_that.userName,_that.avatarKey,_that.inviteCode,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? email,  String? userName,  String? avatarKey,  String? inviteCode,  int? status,  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.email,_that.userName,_that.avatarKey,_that.inviteCode,_that.status,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfile implements UserProfile {
  const _UserProfile({this.email, this.userName, this.avatarKey, this.inviteCode, this.status, this.createdAt});
  factory _UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);

@override final  String? email;
@override final  String? userName;
@override final  String? avatarKey;
@override final  String? inviteCode;
@override final  int? status;
@override final  String? createdAt;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileCopyWith<_UserProfile> get copyWith => __$UserProfileCopyWithImpl<_UserProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfile&&(identical(other.email, email) || other.email == email)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.avatarKey, avatarKey) || other.avatarKey == avatarKey)&&(identical(other.inviteCode, inviteCode) || other.inviteCode == inviteCode)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,userName,avatarKey,inviteCode,status,createdAt);

@override
String toString() {
  return 'UserProfile(email: $email, userName: $userName, avatarKey: $avatarKey, inviteCode: $inviteCode, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$UserProfileCopyWith<$Res> implements $UserProfileCopyWith<$Res> {
  factory _$UserProfileCopyWith(_UserProfile value, $Res Function(_UserProfile) _then) = __$UserProfileCopyWithImpl;
@override @useResult
$Res call({
 String? email, String? userName, String? avatarKey, String? inviteCode, int? status, String? createdAt
});




}
/// @nodoc
class __$UserProfileCopyWithImpl<$Res>
    implements _$UserProfileCopyWith<$Res> {
  __$UserProfileCopyWithImpl(this._self, this._then);

  final _UserProfile _self;
  final $Res Function(_UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = freezed,Object? userName = freezed,Object? avatarKey = freezed,Object? inviteCode = freezed,Object? status = freezed,Object? createdAt = freezed,}) {
  return _then(_UserProfile(
email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,avatarKey: freezed == avatarKey ? _self.avatarKey : avatarKey // ignore: cast_nullable_to_non_nullable
as String?,inviteCode: freezed == inviteCode ? _self.inviteCode : inviteCode // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$BusinessConfig {

@JsonKey(fromJson: _stringFromJson) String? get withdrawFeeFreeThreshold;@JsonKey(fromJson: _stringFromJson) String? get withdrawFeeRate;@JsonKey(fromJson: _stringFromJson) String? get withdrawMinAmount;@JsonKey(fromJson: _stringFromJson) String? get rechargeMinAmount;
/// Create a copy of BusinessConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessConfigCopyWith<BusinessConfig> get copyWith => _$BusinessConfigCopyWithImpl<BusinessConfig>(this as BusinessConfig, _$identity);

  /// Serializes this BusinessConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessConfig&&(identical(other.withdrawFeeFreeThreshold, withdrawFeeFreeThreshold) || other.withdrawFeeFreeThreshold == withdrawFeeFreeThreshold)&&(identical(other.withdrawFeeRate, withdrawFeeRate) || other.withdrawFeeRate == withdrawFeeRate)&&(identical(other.withdrawMinAmount, withdrawMinAmount) || other.withdrawMinAmount == withdrawMinAmount)&&(identical(other.rechargeMinAmount, rechargeMinAmount) || other.rechargeMinAmount == rechargeMinAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,withdrawFeeFreeThreshold,withdrawFeeRate,withdrawMinAmount,rechargeMinAmount);

@override
String toString() {
  return 'BusinessConfig(withdrawFeeFreeThreshold: $withdrawFeeFreeThreshold, withdrawFeeRate: $withdrawFeeRate, withdrawMinAmount: $withdrawMinAmount, rechargeMinAmount: $rechargeMinAmount)';
}


}

/// @nodoc
abstract mixin class $BusinessConfigCopyWith<$Res>  {
  factory $BusinessConfigCopyWith(BusinessConfig value, $Res Function(BusinessConfig) _then) = _$BusinessConfigCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _stringFromJson) String? withdrawFeeFreeThreshold,@JsonKey(fromJson: _stringFromJson) String? withdrawFeeRate,@JsonKey(fromJson: _stringFromJson) String? withdrawMinAmount,@JsonKey(fromJson: _stringFromJson) String? rechargeMinAmount
});




}
/// @nodoc
class _$BusinessConfigCopyWithImpl<$Res>
    implements $BusinessConfigCopyWith<$Res> {
  _$BusinessConfigCopyWithImpl(this._self, this._then);

  final BusinessConfig _self;
  final $Res Function(BusinessConfig) _then;

/// Create a copy of BusinessConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? withdrawFeeFreeThreshold = freezed,Object? withdrawFeeRate = freezed,Object? withdrawMinAmount = freezed,Object? rechargeMinAmount = freezed,}) {
  return _then(_self.copyWith(
withdrawFeeFreeThreshold: freezed == withdrawFeeFreeThreshold ? _self.withdrawFeeFreeThreshold : withdrawFeeFreeThreshold // ignore: cast_nullable_to_non_nullable
as String?,withdrawFeeRate: freezed == withdrawFeeRate ? _self.withdrawFeeRate : withdrawFeeRate // ignore: cast_nullable_to_non_nullable
as String?,withdrawMinAmount: freezed == withdrawMinAmount ? _self.withdrawMinAmount : withdrawMinAmount // ignore: cast_nullable_to_non_nullable
as String?,rechargeMinAmount: freezed == rechargeMinAmount ? _self.rechargeMinAmount : rechargeMinAmount // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BusinessConfig].
extension BusinessConfigPatterns on BusinessConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BusinessConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BusinessConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BusinessConfig value)  $default,){
final _that = this;
switch (_that) {
case _BusinessConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BusinessConfig value)?  $default,){
final _that = this;
switch (_that) {
case _BusinessConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _stringFromJson)  String? withdrawFeeFreeThreshold, @JsonKey(fromJson: _stringFromJson)  String? withdrawFeeRate, @JsonKey(fromJson: _stringFromJson)  String? withdrawMinAmount, @JsonKey(fromJson: _stringFromJson)  String? rechargeMinAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BusinessConfig() when $default != null:
return $default(_that.withdrawFeeFreeThreshold,_that.withdrawFeeRate,_that.withdrawMinAmount,_that.rechargeMinAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _stringFromJson)  String? withdrawFeeFreeThreshold, @JsonKey(fromJson: _stringFromJson)  String? withdrawFeeRate, @JsonKey(fromJson: _stringFromJson)  String? withdrawMinAmount, @JsonKey(fromJson: _stringFromJson)  String? rechargeMinAmount)  $default,) {final _that = this;
switch (_that) {
case _BusinessConfig():
return $default(_that.withdrawFeeFreeThreshold,_that.withdrawFeeRate,_that.withdrawMinAmount,_that.rechargeMinAmount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: _stringFromJson)  String? withdrawFeeFreeThreshold, @JsonKey(fromJson: _stringFromJson)  String? withdrawFeeRate, @JsonKey(fromJson: _stringFromJson)  String? withdrawMinAmount, @JsonKey(fromJson: _stringFromJson)  String? rechargeMinAmount)?  $default,) {final _that = this;
switch (_that) {
case _BusinessConfig() when $default != null:
return $default(_that.withdrawFeeFreeThreshold,_that.withdrawFeeRate,_that.withdrawMinAmount,_that.rechargeMinAmount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BusinessConfig implements BusinessConfig {
  const _BusinessConfig({@JsonKey(fromJson: _stringFromJson) this.withdrawFeeFreeThreshold, @JsonKey(fromJson: _stringFromJson) this.withdrawFeeRate, @JsonKey(fromJson: _stringFromJson) this.withdrawMinAmount, @JsonKey(fromJson: _stringFromJson) this.rechargeMinAmount});
  factory _BusinessConfig.fromJson(Map<String, dynamic> json) => _$BusinessConfigFromJson(json);

@override@JsonKey(fromJson: _stringFromJson) final  String? withdrawFeeFreeThreshold;
@override@JsonKey(fromJson: _stringFromJson) final  String? withdrawFeeRate;
@override@JsonKey(fromJson: _stringFromJson) final  String? withdrawMinAmount;
@override@JsonKey(fromJson: _stringFromJson) final  String? rechargeMinAmount;

/// Create a copy of BusinessConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusinessConfigCopyWith<_BusinessConfig> get copyWith => __$BusinessConfigCopyWithImpl<_BusinessConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BusinessConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessConfig&&(identical(other.withdrawFeeFreeThreshold, withdrawFeeFreeThreshold) || other.withdrawFeeFreeThreshold == withdrawFeeFreeThreshold)&&(identical(other.withdrawFeeRate, withdrawFeeRate) || other.withdrawFeeRate == withdrawFeeRate)&&(identical(other.withdrawMinAmount, withdrawMinAmount) || other.withdrawMinAmount == withdrawMinAmount)&&(identical(other.rechargeMinAmount, rechargeMinAmount) || other.rechargeMinAmount == rechargeMinAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,withdrawFeeFreeThreshold,withdrawFeeRate,withdrawMinAmount,rechargeMinAmount);

@override
String toString() {
  return 'BusinessConfig(withdrawFeeFreeThreshold: $withdrawFeeFreeThreshold, withdrawFeeRate: $withdrawFeeRate, withdrawMinAmount: $withdrawMinAmount, rechargeMinAmount: $rechargeMinAmount)';
}


}

/// @nodoc
abstract mixin class _$BusinessConfigCopyWith<$Res> implements $BusinessConfigCopyWith<$Res> {
  factory _$BusinessConfigCopyWith(_BusinessConfig value, $Res Function(_BusinessConfig) _then) = __$BusinessConfigCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _stringFromJson) String? withdrawFeeFreeThreshold,@JsonKey(fromJson: _stringFromJson) String? withdrawFeeRate,@JsonKey(fromJson: _stringFromJson) String? withdrawMinAmount,@JsonKey(fromJson: _stringFromJson) String? rechargeMinAmount
});




}
/// @nodoc
class __$BusinessConfigCopyWithImpl<$Res>
    implements _$BusinessConfigCopyWith<$Res> {
  __$BusinessConfigCopyWithImpl(this._self, this._then);

  final _BusinessConfig _self;
  final $Res Function(_BusinessConfig) _then;

/// Create a copy of BusinessConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? withdrawFeeFreeThreshold = freezed,Object? withdrawFeeRate = freezed,Object? withdrawMinAmount = freezed,Object? rechargeMinAmount = freezed,}) {
  return _then(_BusinessConfig(
withdrawFeeFreeThreshold: freezed == withdrawFeeFreeThreshold ? _self.withdrawFeeFreeThreshold : withdrawFeeFreeThreshold // ignore: cast_nullable_to_non_nullable
as String?,withdrawFeeRate: freezed == withdrawFeeRate ? _self.withdrawFeeRate : withdrawFeeRate // ignore: cast_nullable_to_non_nullable
as String?,withdrawMinAmount: freezed == withdrawMinAmount ? _self.withdrawMinAmount : withdrawMinAmount // ignore: cast_nullable_to_non_nullable
as String?,rechargeMinAmount: freezed == rechargeMinAmount ? _self.rechargeMinAmount : rechargeMinAmount // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$WalletInfo {

 String? get currency;@JsonKey(fromJson: _stringFromJson) String? get availableBalance;@JsonKey(fromJson: _stringFromJson) String? get frozenBalance;@JsonKey(fromJson: _stringFromJson) String? get totalRecharge;@JsonKey(fromJson: _stringFromJson) String? get totalWithdraw;@JsonKey(fromJson: _stringFromJson) String? get totalProfit;@JsonKey(fromJson: _stringFromJson) String? get totalCommission;
/// Create a copy of WalletInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletInfoCopyWith<WalletInfo> get copyWith => _$WalletInfoCopyWithImpl<WalletInfo>(this as WalletInfo, _$identity);

  /// Serializes this WalletInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletInfo&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.availableBalance, availableBalance) || other.availableBalance == availableBalance)&&(identical(other.frozenBalance, frozenBalance) || other.frozenBalance == frozenBalance)&&(identical(other.totalRecharge, totalRecharge) || other.totalRecharge == totalRecharge)&&(identical(other.totalWithdraw, totalWithdraw) || other.totalWithdraw == totalWithdraw)&&(identical(other.totalProfit, totalProfit) || other.totalProfit == totalProfit)&&(identical(other.totalCommission, totalCommission) || other.totalCommission == totalCommission));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currency,availableBalance,frozenBalance,totalRecharge,totalWithdraw,totalProfit,totalCommission);

@override
String toString() {
  return 'WalletInfo(currency: $currency, availableBalance: $availableBalance, frozenBalance: $frozenBalance, totalRecharge: $totalRecharge, totalWithdraw: $totalWithdraw, totalProfit: $totalProfit, totalCommission: $totalCommission)';
}


}

/// @nodoc
abstract mixin class $WalletInfoCopyWith<$Res>  {
  factory $WalletInfoCopyWith(WalletInfo value, $Res Function(WalletInfo) _then) = _$WalletInfoCopyWithImpl;
@useResult
$Res call({
 String? currency,@JsonKey(fromJson: _stringFromJson) String? availableBalance,@JsonKey(fromJson: _stringFromJson) String? frozenBalance,@JsonKey(fromJson: _stringFromJson) String? totalRecharge,@JsonKey(fromJson: _stringFromJson) String? totalWithdraw,@JsonKey(fromJson: _stringFromJson) String? totalProfit,@JsonKey(fromJson: _stringFromJson) String? totalCommission
});




}
/// @nodoc
class _$WalletInfoCopyWithImpl<$Res>
    implements $WalletInfoCopyWith<$Res> {
  _$WalletInfoCopyWithImpl(this._self, this._then);

  final WalletInfo _self;
  final $Res Function(WalletInfo) _then;

/// Create a copy of WalletInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currency = freezed,Object? availableBalance = freezed,Object? frozenBalance = freezed,Object? totalRecharge = freezed,Object? totalWithdraw = freezed,Object? totalProfit = freezed,Object? totalCommission = freezed,}) {
  return _then(_self.copyWith(
currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,availableBalance: freezed == availableBalance ? _self.availableBalance : availableBalance // ignore: cast_nullable_to_non_nullable
as String?,frozenBalance: freezed == frozenBalance ? _self.frozenBalance : frozenBalance // ignore: cast_nullable_to_non_nullable
as String?,totalRecharge: freezed == totalRecharge ? _self.totalRecharge : totalRecharge // ignore: cast_nullable_to_non_nullable
as String?,totalWithdraw: freezed == totalWithdraw ? _self.totalWithdraw : totalWithdraw // ignore: cast_nullable_to_non_nullable
as String?,totalProfit: freezed == totalProfit ? _self.totalProfit : totalProfit // ignore: cast_nullable_to_non_nullable
as String?,totalCommission: freezed == totalCommission ? _self.totalCommission : totalCommission // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WalletInfo].
extension WalletInfoPatterns on WalletInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WalletInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WalletInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WalletInfo value)  $default,){
final _that = this;
switch (_that) {
case _WalletInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WalletInfo value)?  $default,){
final _that = this;
switch (_that) {
case _WalletInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? currency, @JsonKey(fromJson: _stringFromJson)  String? availableBalance, @JsonKey(fromJson: _stringFromJson)  String? frozenBalance, @JsonKey(fromJson: _stringFromJson)  String? totalRecharge, @JsonKey(fromJson: _stringFromJson)  String? totalWithdraw, @JsonKey(fromJson: _stringFromJson)  String? totalProfit, @JsonKey(fromJson: _stringFromJson)  String? totalCommission)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WalletInfo() when $default != null:
return $default(_that.currency,_that.availableBalance,_that.frozenBalance,_that.totalRecharge,_that.totalWithdraw,_that.totalProfit,_that.totalCommission);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? currency, @JsonKey(fromJson: _stringFromJson)  String? availableBalance, @JsonKey(fromJson: _stringFromJson)  String? frozenBalance, @JsonKey(fromJson: _stringFromJson)  String? totalRecharge, @JsonKey(fromJson: _stringFromJson)  String? totalWithdraw, @JsonKey(fromJson: _stringFromJson)  String? totalProfit, @JsonKey(fromJson: _stringFromJson)  String? totalCommission)  $default,) {final _that = this;
switch (_that) {
case _WalletInfo():
return $default(_that.currency,_that.availableBalance,_that.frozenBalance,_that.totalRecharge,_that.totalWithdraw,_that.totalProfit,_that.totalCommission);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? currency, @JsonKey(fromJson: _stringFromJson)  String? availableBalance, @JsonKey(fromJson: _stringFromJson)  String? frozenBalance, @JsonKey(fromJson: _stringFromJson)  String? totalRecharge, @JsonKey(fromJson: _stringFromJson)  String? totalWithdraw, @JsonKey(fromJson: _stringFromJson)  String? totalProfit, @JsonKey(fromJson: _stringFromJson)  String? totalCommission)?  $default,) {final _that = this;
switch (_that) {
case _WalletInfo() when $default != null:
return $default(_that.currency,_that.availableBalance,_that.frozenBalance,_that.totalRecharge,_that.totalWithdraw,_that.totalProfit,_that.totalCommission);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WalletInfo implements WalletInfo {
  const _WalletInfo({this.currency, @JsonKey(fromJson: _stringFromJson) this.availableBalance, @JsonKey(fromJson: _stringFromJson) this.frozenBalance, @JsonKey(fromJson: _stringFromJson) this.totalRecharge, @JsonKey(fromJson: _stringFromJson) this.totalWithdraw, @JsonKey(fromJson: _stringFromJson) this.totalProfit, @JsonKey(fromJson: _stringFromJson) this.totalCommission});
  factory _WalletInfo.fromJson(Map<String, dynamic> json) => _$WalletInfoFromJson(json);

@override final  String? currency;
@override@JsonKey(fromJson: _stringFromJson) final  String? availableBalance;
@override@JsonKey(fromJson: _stringFromJson) final  String? frozenBalance;
@override@JsonKey(fromJson: _stringFromJson) final  String? totalRecharge;
@override@JsonKey(fromJson: _stringFromJson) final  String? totalWithdraw;
@override@JsonKey(fromJson: _stringFromJson) final  String? totalProfit;
@override@JsonKey(fromJson: _stringFromJson) final  String? totalCommission;

/// Create a copy of WalletInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletInfoCopyWith<_WalletInfo> get copyWith => __$WalletInfoCopyWithImpl<_WalletInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WalletInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalletInfo&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.availableBalance, availableBalance) || other.availableBalance == availableBalance)&&(identical(other.frozenBalance, frozenBalance) || other.frozenBalance == frozenBalance)&&(identical(other.totalRecharge, totalRecharge) || other.totalRecharge == totalRecharge)&&(identical(other.totalWithdraw, totalWithdraw) || other.totalWithdraw == totalWithdraw)&&(identical(other.totalProfit, totalProfit) || other.totalProfit == totalProfit)&&(identical(other.totalCommission, totalCommission) || other.totalCommission == totalCommission));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currency,availableBalance,frozenBalance,totalRecharge,totalWithdraw,totalProfit,totalCommission);

@override
String toString() {
  return 'WalletInfo(currency: $currency, availableBalance: $availableBalance, frozenBalance: $frozenBalance, totalRecharge: $totalRecharge, totalWithdraw: $totalWithdraw, totalProfit: $totalProfit, totalCommission: $totalCommission)';
}


}

/// @nodoc
abstract mixin class _$WalletInfoCopyWith<$Res> implements $WalletInfoCopyWith<$Res> {
  factory _$WalletInfoCopyWith(_WalletInfo value, $Res Function(_WalletInfo) _then) = __$WalletInfoCopyWithImpl;
@override @useResult
$Res call({
 String? currency,@JsonKey(fromJson: _stringFromJson) String? availableBalance,@JsonKey(fromJson: _stringFromJson) String? frozenBalance,@JsonKey(fromJson: _stringFromJson) String? totalRecharge,@JsonKey(fromJson: _stringFromJson) String? totalWithdraw,@JsonKey(fromJson: _stringFromJson) String? totalProfit,@JsonKey(fromJson: _stringFromJson) String? totalCommission
});




}
/// @nodoc
class __$WalletInfoCopyWithImpl<$Res>
    implements _$WalletInfoCopyWith<$Res> {
  __$WalletInfoCopyWithImpl(this._self, this._then);

  final _WalletInfo _self;
  final $Res Function(_WalletInfo) _then;

/// Create a copy of WalletInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currency = freezed,Object? availableBalance = freezed,Object? frozenBalance = freezed,Object? totalRecharge = freezed,Object? totalWithdraw = freezed,Object? totalProfit = freezed,Object? totalCommission = freezed,}) {
  return _then(_WalletInfo(
currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,availableBalance: freezed == availableBalance ? _self.availableBalance : availableBalance // ignore: cast_nullable_to_non_nullable
as String?,frozenBalance: freezed == frozenBalance ? _self.frozenBalance : frozenBalance // ignore: cast_nullable_to_non_nullable
as String?,totalRecharge: freezed == totalRecharge ? _self.totalRecharge : totalRecharge // ignore: cast_nullable_to_non_nullable
as String?,totalWithdraw: freezed == totalWithdraw ? _self.totalWithdraw : totalWithdraw // ignore: cast_nullable_to_non_nullable
as String?,totalProfit: freezed == totalProfit ? _self.totalProfit : totalProfit // ignore: cast_nullable_to_non_nullable
as String?,totalCommission: freezed == totalCommission ? _self.totalCommission : totalCommission // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TokenWalletInfo {

 String? get assetCode;@JsonKey(fromJson: _stringFromJson) String? get availableBalance;@JsonKey(fromJson: _stringFromJson) String? get totalEarned;@JsonKey(fromJson: _stringFromJson) String? get totalConsumed;
/// Create a copy of TokenWalletInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TokenWalletInfoCopyWith<TokenWalletInfo> get copyWith => _$TokenWalletInfoCopyWithImpl<TokenWalletInfo>(this as TokenWalletInfo, _$identity);

  /// Serializes this TokenWalletInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TokenWalletInfo&&(identical(other.assetCode, assetCode) || other.assetCode == assetCode)&&(identical(other.availableBalance, availableBalance) || other.availableBalance == availableBalance)&&(identical(other.totalEarned, totalEarned) || other.totalEarned == totalEarned)&&(identical(other.totalConsumed, totalConsumed) || other.totalConsumed == totalConsumed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,assetCode,availableBalance,totalEarned,totalConsumed);

@override
String toString() {
  return 'TokenWalletInfo(assetCode: $assetCode, availableBalance: $availableBalance, totalEarned: $totalEarned, totalConsumed: $totalConsumed)';
}


}

/// @nodoc
abstract mixin class $TokenWalletInfoCopyWith<$Res>  {
  factory $TokenWalletInfoCopyWith(TokenWalletInfo value, $Res Function(TokenWalletInfo) _then) = _$TokenWalletInfoCopyWithImpl;
@useResult
$Res call({
 String? assetCode,@JsonKey(fromJson: _stringFromJson) String? availableBalance,@JsonKey(fromJson: _stringFromJson) String? totalEarned,@JsonKey(fromJson: _stringFromJson) String? totalConsumed
});




}
/// @nodoc
class _$TokenWalletInfoCopyWithImpl<$Res>
    implements $TokenWalletInfoCopyWith<$Res> {
  _$TokenWalletInfoCopyWithImpl(this._self, this._then);

  final TokenWalletInfo _self;
  final $Res Function(TokenWalletInfo) _then;

/// Create a copy of TokenWalletInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? assetCode = freezed,Object? availableBalance = freezed,Object? totalEarned = freezed,Object? totalConsumed = freezed,}) {
  return _then(_self.copyWith(
assetCode: freezed == assetCode ? _self.assetCode : assetCode // ignore: cast_nullable_to_non_nullable
as String?,availableBalance: freezed == availableBalance ? _self.availableBalance : availableBalance // ignore: cast_nullable_to_non_nullable
as String?,totalEarned: freezed == totalEarned ? _self.totalEarned : totalEarned // ignore: cast_nullable_to_non_nullable
as String?,totalConsumed: freezed == totalConsumed ? _self.totalConsumed : totalConsumed // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TokenWalletInfo].
extension TokenWalletInfoPatterns on TokenWalletInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TokenWalletInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TokenWalletInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TokenWalletInfo value)  $default,){
final _that = this;
switch (_that) {
case _TokenWalletInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TokenWalletInfo value)?  $default,){
final _that = this;
switch (_that) {
case _TokenWalletInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? assetCode, @JsonKey(fromJson: _stringFromJson)  String? availableBalance, @JsonKey(fromJson: _stringFromJson)  String? totalEarned, @JsonKey(fromJson: _stringFromJson)  String? totalConsumed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TokenWalletInfo() when $default != null:
return $default(_that.assetCode,_that.availableBalance,_that.totalEarned,_that.totalConsumed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? assetCode, @JsonKey(fromJson: _stringFromJson)  String? availableBalance, @JsonKey(fromJson: _stringFromJson)  String? totalEarned, @JsonKey(fromJson: _stringFromJson)  String? totalConsumed)  $default,) {final _that = this;
switch (_that) {
case _TokenWalletInfo():
return $default(_that.assetCode,_that.availableBalance,_that.totalEarned,_that.totalConsumed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? assetCode, @JsonKey(fromJson: _stringFromJson)  String? availableBalance, @JsonKey(fromJson: _stringFromJson)  String? totalEarned, @JsonKey(fromJson: _stringFromJson)  String? totalConsumed)?  $default,) {final _that = this;
switch (_that) {
case _TokenWalletInfo() when $default != null:
return $default(_that.assetCode,_that.availableBalance,_that.totalEarned,_that.totalConsumed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TokenWalletInfo implements TokenWalletInfo {
  const _TokenWalletInfo({this.assetCode, @JsonKey(fromJson: _stringFromJson) this.availableBalance, @JsonKey(fromJson: _stringFromJson) this.totalEarned, @JsonKey(fromJson: _stringFromJson) this.totalConsumed});
  factory _TokenWalletInfo.fromJson(Map<String, dynamic> json) => _$TokenWalletInfoFromJson(json);

@override final  String? assetCode;
@override@JsonKey(fromJson: _stringFromJson) final  String? availableBalance;
@override@JsonKey(fromJson: _stringFromJson) final  String? totalEarned;
@override@JsonKey(fromJson: _stringFromJson) final  String? totalConsumed;

/// Create a copy of TokenWalletInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TokenWalletInfoCopyWith<_TokenWalletInfo> get copyWith => __$TokenWalletInfoCopyWithImpl<_TokenWalletInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TokenWalletInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TokenWalletInfo&&(identical(other.assetCode, assetCode) || other.assetCode == assetCode)&&(identical(other.availableBalance, availableBalance) || other.availableBalance == availableBalance)&&(identical(other.totalEarned, totalEarned) || other.totalEarned == totalEarned)&&(identical(other.totalConsumed, totalConsumed) || other.totalConsumed == totalConsumed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,assetCode,availableBalance,totalEarned,totalConsumed);

@override
String toString() {
  return 'TokenWalletInfo(assetCode: $assetCode, availableBalance: $availableBalance, totalEarned: $totalEarned, totalConsumed: $totalConsumed)';
}


}

/// @nodoc
abstract mixin class _$TokenWalletInfoCopyWith<$Res> implements $TokenWalletInfoCopyWith<$Res> {
  factory _$TokenWalletInfoCopyWith(_TokenWalletInfo value, $Res Function(_TokenWalletInfo) _then) = __$TokenWalletInfoCopyWithImpl;
@override @useResult
$Res call({
 String? assetCode,@JsonKey(fromJson: _stringFromJson) String? availableBalance,@JsonKey(fromJson: _stringFromJson) String? totalEarned,@JsonKey(fromJson: _stringFromJson) String? totalConsumed
});




}
/// @nodoc
class __$TokenWalletInfoCopyWithImpl<$Res>
    implements _$TokenWalletInfoCopyWith<$Res> {
  __$TokenWalletInfoCopyWithImpl(this._self, this._then);

  final _TokenWalletInfo _self;
  final $Res Function(_TokenWalletInfo) _then;

/// Create a copy of TokenWalletInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? assetCode = freezed,Object? availableBalance = freezed,Object? totalEarned = freezed,Object? totalConsumed = freezed,}) {
  return _then(_TokenWalletInfo(
assetCode: freezed == assetCode ? _self.assetCode : assetCode // ignore: cast_nullable_to_non_nullable
as String?,availableBalance: freezed == availableBalance ? _self.availableBalance : availableBalance // ignore: cast_nullable_to_non_nullable
as String?,totalEarned: freezed == totalEarned ? _self.totalEarned : totalEarned // ignore: cast_nullable_to_non_nullable
as String?,totalConsumed: freezed == totalConsumed ? _self.totalConsumed : totalConsumed // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$WalletTransaction {

 String? get txNo; String? get walletTxNo; String? get assetCode; String? get businessType; String? get bizType; String? get txType;@JsonKey(fromJson: _stringFromJson) String? get amount;@JsonKey(fromJson: _stringFromJson) String? get beforeAvailableBalance;@JsonKey(fromJson: _stringFromJson) String? get balanceAfter;@JsonKey(fromJson: _stringFromJson) String? get afterAvailableBalance;@JsonKey(fromJson: _stringFromJson) String? get beforeFrozenBalance;@JsonKey(fromJson: _stringFromJson) String? get afterFrozenBalance; String? get bizOrderNo; String? get remark; String? get createdAt;
/// Create a copy of WalletTransaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletTransactionCopyWith<WalletTransaction> get copyWith => _$WalletTransactionCopyWithImpl<WalletTransaction>(this as WalletTransaction, _$identity);

  /// Serializes this WalletTransaction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletTransaction&&(identical(other.txNo, txNo) || other.txNo == txNo)&&(identical(other.walletTxNo, walletTxNo) || other.walletTxNo == walletTxNo)&&(identical(other.assetCode, assetCode) || other.assetCode == assetCode)&&(identical(other.businessType, businessType) || other.businessType == businessType)&&(identical(other.bizType, bizType) || other.bizType == bizType)&&(identical(other.txType, txType) || other.txType == txType)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.beforeAvailableBalance, beforeAvailableBalance) || other.beforeAvailableBalance == beforeAvailableBalance)&&(identical(other.balanceAfter, balanceAfter) || other.balanceAfter == balanceAfter)&&(identical(other.afterAvailableBalance, afterAvailableBalance) || other.afterAvailableBalance == afterAvailableBalance)&&(identical(other.beforeFrozenBalance, beforeFrozenBalance) || other.beforeFrozenBalance == beforeFrozenBalance)&&(identical(other.afterFrozenBalance, afterFrozenBalance) || other.afterFrozenBalance == afterFrozenBalance)&&(identical(other.bizOrderNo, bizOrderNo) || other.bizOrderNo == bizOrderNo)&&(identical(other.remark, remark) || other.remark == remark)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,txNo,walletTxNo,assetCode,businessType,bizType,txType,amount,beforeAvailableBalance,balanceAfter,afterAvailableBalance,beforeFrozenBalance,afterFrozenBalance,bizOrderNo,remark,createdAt);

@override
String toString() {
  return 'WalletTransaction(txNo: $txNo, walletTxNo: $walletTxNo, assetCode: $assetCode, businessType: $businessType, bizType: $bizType, txType: $txType, amount: $amount, beforeAvailableBalance: $beforeAvailableBalance, balanceAfter: $balanceAfter, afterAvailableBalance: $afterAvailableBalance, beforeFrozenBalance: $beforeFrozenBalance, afterFrozenBalance: $afterFrozenBalance, bizOrderNo: $bizOrderNo, remark: $remark, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $WalletTransactionCopyWith<$Res>  {
  factory $WalletTransactionCopyWith(WalletTransaction value, $Res Function(WalletTransaction) _then) = _$WalletTransactionCopyWithImpl;
@useResult
$Res call({
 String? txNo, String? walletTxNo, String? assetCode, String? businessType, String? bizType, String? txType,@JsonKey(fromJson: _stringFromJson) String? amount,@JsonKey(fromJson: _stringFromJson) String? beforeAvailableBalance,@JsonKey(fromJson: _stringFromJson) String? balanceAfter,@JsonKey(fromJson: _stringFromJson) String? afterAvailableBalance,@JsonKey(fromJson: _stringFromJson) String? beforeFrozenBalance,@JsonKey(fromJson: _stringFromJson) String? afterFrozenBalance, String? bizOrderNo, String? remark, String? createdAt
});




}
/// @nodoc
class _$WalletTransactionCopyWithImpl<$Res>
    implements $WalletTransactionCopyWith<$Res> {
  _$WalletTransactionCopyWithImpl(this._self, this._then);

  final WalletTransaction _self;
  final $Res Function(WalletTransaction) _then;

/// Create a copy of WalletTransaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? txNo = freezed,Object? walletTxNo = freezed,Object? assetCode = freezed,Object? businessType = freezed,Object? bizType = freezed,Object? txType = freezed,Object? amount = freezed,Object? beforeAvailableBalance = freezed,Object? balanceAfter = freezed,Object? afterAvailableBalance = freezed,Object? beforeFrozenBalance = freezed,Object? afterFrozenBalance = freezed,Object? bizOrderNo = freezed,Object? remark = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
txNo: freezed == txNo ? _self.txNo : txNo // ignore: cast_nullable_to_non_nullable
as String?,walletTxNo: freezed == walletTxNo ? _self.walletTxNo : walletTxNo // ignore: cast_nullable_to_non_nullable
as String?,assetCode: freezed == assetCode ? _self.assetCode : assetCode // ignore: cast_nullable_to_non_nullable
as String?,businessType: freezed == businessType ? _self.businessType : businessType // ignore: cast_nullable_to_non_nullable
as String?,bizType: freezed == bizType ? _self.bizType : bizType // ignore: cast_nullable_to_non_nullable
as String?,txType: freezed == txType ? _self.txType : txType // ignore: cast_nullable_to_non_nullable
as String?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String?,beforeAvailableBalance: freezed == beforeAvailableBalance ? _self.beforeAvailableBalance : beforeAvailableBalance // ignore: cast_nullable_to_non_nullable
as String?,balanceAfter: freezed == balanceAfter ? _self.balanceAfter : balanceAfter // ignore: cast_nullable_to_non_nullable
as String?,afterAvailableBalance: freezed == afterAvailableBalance ? _self.afterAvailableBalance : afterAvailableBalance // ignore: cast_nullable_to_non_nullable
as String?,beforeFrozenBalance: freezed == beforeFrozenBalance ? _self.beforeFrozenBalance : beforeFrozenBalance // ignore: cast_nullable_to_non_nullable
as String?,afterFrozenBalance: freezed == afterFrozenBalance ? _self.afterFrozenBalance : afterFrozenBalance // ignore: cast_nullable_to_non_nullable
as String?,bizOrderNo: freezed == bizOrderNo ? _self.bizOrderNo : bizOrderNo // ignore: cast_nullable_to_non_nullable
as String?,remark: freezed == remark ? _self.remark : remark // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WalletTransaction].
extension WalletTransactionPatterns on WalletTransaction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WalletTransaction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WalletTransaction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WalletTransaction value)  $default,){
final _that = this;
switch (_that) {
case _WalletTransaction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WalletTransaction value)?  $default,){
final _that = this;
switch (_that) {
case _WalletTransaction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? txNo,  String? walletTxNo,  String? assetCode,  String? businessType,  String? bizType,  String? txType, @JsonKey(fromJson: _stringFromJson)  String? amount, @JsonKey(fromJson: _stringFromJson)  String? beforeAvailableBalance, @JsonKey(fromJson: _stringFromJson)  String? balanceAfter, @JsonKey(fromJson: _stringFromJson)  String? afterAvailableBalance, @JsonKey(fromJson: _stringFromJson)  String? beforeFrozenBalance, @JsonKey(fromJson: _stringFromJson)  String? afterFrozenBalance,  String? bizOrderNo,  String? remark,  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WalletTransaction() when $default != null:
return $default(_that.txNo,_that.walletTxNo,_that.assetCode,_that.businessType,_that.bizType,_that.txType,_that.amount,_that.beforeAvailableBalance,_that.balanceAfter,_that.afterAvailableBalance,_that.beforeFrozenBalance,_that.afterFrozenBalance,_that.bizOrderNo,_that.remark,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? txNo,  String? walletTxNo,  String? assetCode,  String? businessType,  String? bizType,  String? txType, @JsonKey(fromJson: _stringFromJson)  String? amount, @JsonKey(fromJson: _stringFromJson)  String? beforeAvailableBalance, @JsonKey(fromJson: _stringFromJson)  String? balanceAfter, @JsonKey(fromJson: _stringFromJson)  String? afterAvailableBalance, @JsonKey(fromJson: _stringFromJson)  String? beforeFrozenBalance, @JsonKey(fromJson: _stringFromJson)  String? afterFrozenBalance,  String? bizOrderNo,  String? remark,  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _WalletTransaction():
return $default(_that.txNo,_that.walletTxNo,_that.assetCode,_that.businessType,_that.bizType,_that.txType,_that.amount,_that.beforeAvailableBalance,_that.balanceAfter,_that.afterAvailableBalance,_that.beforeFrozenBalance,_that.afterFrozenBalance,_that.bizOrderNo,_that.remark,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? txNo,  String? walletTxNo,  String? assetCode,  String? businessType,  String? bizType,  String? txType, @JsonKey(fromJson: _stringFromJson)  String? amount, @JsonKey(fromJson: _stringFromJson)  String? beforeAvailableBalance, @JsonKey(fromJson: _stringFromJson)  String? balanceAfter, @JsonKey(fromJson: _stringFromJson)  String? afterAvailableBalance, @JsonKey(fromJson: _stringFromJson)  String? beforeFrozenBalance, @JsonKey(fromJson: _stringFromJson)  String? afterFrozenBalance,  String? bizOrderNo,  String? remark,  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _WalletTransaction() when $default != null:
return $default(_that.txNo,_that.walletTxNo,_that.assetCode,_that.businessType,_that.bizType,_that.txType,_that.amount,_that.beforeAvailableBalance,_that.balanceAfter,_that.afterAvailableBalance,_that.beforeFrozenBalance,_that.afterFrozenBalance,_that.bizOrderNo,_that.remark,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WalletTransaction implements WalletTransaction {
  const _WalletTransaction({this.txNo, this.walletTxNo, this.assetCode, this.businessType, this.bizType, this.txType, @JsonKey(fromJson: _stringFromJson) this.amount, @JsonKey(fromJson: _stringFromJson) this.beforeAvailableBalance, @JsonKey(fromJson: _stringFromJson) this.balanceAfter, @JsonKey(fromJson: _stringFromJson) this.afterAvailableBalance, @JsonKey(fromJson: _stringFromJson) this.beforeFrozenBalance, @JsonKey(fromJson: _stringFromJson) this.afterFrozenBalance, this.bizOrderNo, this.remark, this.createdAt});
  factory _WalletTransaction.fromJson(Map<String, dynamic> json) => _$WalletTransactionFromJson(json);

@override final  String? txNo;
@override final  String? walletTxNo;
@override final  String? assetCode;
@override final  String? businessType;
@override final  String? bizType;
@override final  String? txType;
@override@JsonKey(fromJson: _stringFromJson) final  String? amount;
@override@JsonKey(fromJson: _stringFromJson) final  String? beforeAvailableBalance;
@override@JsonKey(fromJson: _stringFromJson) final  String? balanceAfter;
@override@JsonKey(fromJson: _stringFromJson) final  String? afterAvailableBalance;
@override@JsonKey(fromJson: _stringFromJson) final  String? beforeFrozenBalance;
@override@JsonKey(fromJson: _stringFromJson) final  String? afterFrozenBalance;
@override final  String? bizOrderNo;
@override final  String? remark;
@override final  String? createdAt;

/// Create a copy of WalletTransaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletTransactionCopyWith<_WalletTransaction> get copyWith => __$WalletTransactionCopyWithImpl<_WalletTransaction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WalletTransactionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalletTransaction&&(identical(other.txNo, txNo) || other.txNo == txNo)&&(identical(other.walletTxNo, walletTxNo) || other.walletTxNo == walletTxNo)&&(identical(other.assetCode, assetCode) || other.assetCode == assetCode)&&(identical(other.businessType, businessType) || other.businessType == businessType)&&(identical(other.bizType, bizType) || other.bizType == bizType)&&(identical(other.txType, txType) || other.txType == txType)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.beforeAvailableBalance, beforeAvailableBalance) || other.beforeAvailableBalance == beforeAvailableBalance)&&(identical(other.balanceAfter, balanceAfter) || other.balanceAfter == balanceAfter)&&(identical(other.afterAvailableBalance, afterAvailableBalance) || other.afterAvailableBalance == afterAvailableBalance)&&(identical(other.beforeFrozenBalance, beforeFrozenBalance) || other.beforeFrozenBalance == beforeFrozenBalance)&&(identical(other.afterFrozenBalance, afterFrozenBalance) || other.afterFrozenBalance == afterFrozenBalance)&&(identical(other.bizOrderNo, bizOrderNo) || other.bizOrderNo == bizOrderNo)&&(identical(other.remark, remark) || other.remark == remark)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,txNo,walletTxNo,assetCode,businessType,bizType,txType,amount,beforeAvailableBalance,balanceAfter,afterAvailableBalance,beforeFrozenBalance,afterFrozenBalance,bizOrderNo,remark,createdAt);

@override
String toString() {
  return 'WalletTransaction(txNo: $txNo, walletTxNo: $walletTxNo, assetCode: $assetCode, businessType: $businessType, bizType: $bizType, txType: $txType, amount: $amount, beforeAvailableBalance: $beforeAvailableBalance, balanceAfter: $balanceAfter, afterAvailableBalance: $afterAvailableBalance, beforeFrozenBalance: $beforeFrozenBalance, afterFrozenBalance: $afterFrozenBalance, bizOrderNo: $bizOrderNo, remark: $remark, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$WalletTransactionCopyWith<$Res> implements $WalletTransactionCopyWith<$Res> {
  factory _$WalletTransactionCopyWith(_WalletTransaction value, $Res Function(_WalletTransaction) _then) = __$WalletTransactionCopyWithImpl;
@override @useResult
$Res call({
 String? txNo, String? walletTxNo, String? assetCode, String? businessType, String? bizType, String? txType,@JsonKey(fromJson: _stringFromJson) String? amount,@JsonKey(fromJson: _stringFromJson) String? beforeAvailableBalance,@JsonKey(fromJson: _stringFromJson) String? balanceAfter,@JsonKey(fromJson: _stringFromJson) String? afterAvailableBalance,@JsonKey(fromJson: _stringFromJson) String? beforeFrozenBalance,@JsonKey(fromJson: _stringFromJson) String? afterFrozenBalance, String? bizOrderNo, String? remark, String? createdAt
});




}
/// @nodoc
class __$WalletTransactionCopyWithImpl<$Res>
    implements _$WalletTransactionCopyWith<$Res> {
  __$WalletTransactionCopyWithImpl(this._self, this._then);

  final _WalletTransaction _self;
  final $Res Function(_WalletTransaction) _then;

/// Create a copy of WalletTransaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? txNo = freezed,Object? walletTxNo = freezed,Object? assetCode = freezed,Object? businessType = freezed,Object? bizType = freezed,Object? txType = freezed,Object? amount = freezed,Object? beforeAvailableBalance = freezed,Object? balanceAfter = freezed,Object? afterAvailableBalance = freezed,Object? beforeFrozenBalance = freezed,Object? afterFrozenBalance = freezed,Object? bizOrderNo = freezed,Object? remark = freezed,Object? createdAt = freezed,}) {
  return _then(_WalletTransaction(
txNo: freezed == txNo ? _self.txNo : txNo // ignore: cast_nullable_to_non_nullable
as String?,walletTxNo: freezed == walletTxNo ? _self.walletTxNo : walletTxNo // ignore: cast_nullable_to_non_nullable
as String?,assetCode: freezed == assetCode ? _self.assetCode : assetCode // ignore: cast_nullable_to_non_nullable
as String?,businessType: freezed == businessType ? _self.businessType : businessType // ignore: cast_nullable_to_non_nullable
as String?,bizType: freezed == bizType ? _self.bizType : bizType // ignore: cast_nullable_to_non_nullable
as String?,txType: freezed == txType ? _self.txType : txType // ignore: cast_nullable_to_non_nullable
as String?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String?,beforeAvailableBalance: freezed == beforeAvailableBalance ? _self.beforeAvailableBalance : beforeAvailableBalance // ignore: cast_nullable_to_non_nullable
as String?,balanceAfter: freezed == balanceAfter ? _self.balanceAfter : balanceAfter // ignore: cast_nullable_to_non_nullable
as String?,afterAvailableBalance: freezed == afterAvailableBalance ? _self.afterAvailableBalance : afterAvailableBalance // ignore: cast_nullable_to_non_nullable
as String?,beforeFrozenBalance: freezed == beforeFrozenBalance ? _self.beforeFrozenBalance : beforeFrozenBalance // ignore: cast_nullable_to_non_nullable
as String?,afterFrozenBalance: freezed == afterFrozenBalance ? _self.afterFrozenBalance : afterFrozenBalance // ignore: cast_nullable_to_non_nullable
as String?,bizOrderNo: freezed == bizOrderNo ? _self.bizOrderNo : bizOrderNo // ignore: cast_nullable_to_non_nullable
as String?,remark: freezed == remark ? _self.remark : remark // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$DashboardOverview {

 WalletInfo? get wallet; RentalOverview? get rental; ProfitOverview? get profit; TeamSummary? get team;
/// Create a copy of DashboardOverview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardOverviewCopyWith<DashboardOverview> get copyWith => _$DashboardOverviewCopyWithImpl<DashboardOverview>(this as DashboardOverview, _$identity);

  /// Serializes this DashboardOverview to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardOverview&&(identical(other.wallet, wallet) || other.wallet == wallet)&&(identical(other.rental, rental) || other.rental == rental)&&(identical(other.profit, profit) || other.profit == profit)&&(identical(other.team, team) || other.team == team));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,wallet,rental,profit,team);

@override
String toString() {
  return 'DashboardOverview(wallet: $wallet, rental: $rental, profit: $profit, team: $team)';
}


}

/// @nodoc
abstract mixin class $DashboardOverviewCopyWith<$Res>  {
  factory $DashboardOverviewCopyWith(DashboardOverview value, $Res Function(DashboardOverview) _then) = _$DashboardOverviewCopyWithImpl;
@useResult
$Res call({
 WalletInfo? wallet, RentalOverview? rental, ProfitOverview? profit, TeamSummary? team
});


$WalletInfoCopyWith<$Res>? get wallet;$RentalOverviewCopyWith<$Res>? get rental;$ProfitOverviewCopyWith<$Res>? get profit;$TeamSummaryCopyWith<$Res>? get team;

}
/// @nodoc
class _$DashboardOverviewCopyWithImpl<$Res>
    implements $DashboardOverviewCopyWith<$Res> {
  _$DashboardOverviewCopyWithImpl(this._self, this._then);

  final DashboardOverview _self;
  final $Res Function(DashboardOverview) _then;

/// Create a copy of DashboardOverview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? wallet = freezed,Object? rental = freezed,Object? profit = freezed,Object? team = freezed,}) {
  return _then(_self.copyWith(
wallet: freezed == wallet ? _self.wallet : wallet // ignore: cast_nullable_to_non_nullable
as WalletInfo?,rental: freezed == rental ? _self.rental : rental // ignore: cast_nullable_to_non_nullable
as RentalOverview?,profit: freezed == profit ? _self.profit : profit // ignore: cast_nullable_to_non_nullable
as ProfitOverview?,team: freezed == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as TeamSummary?,
  ));
}
/// Create a copy of DashboardOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WalletInfoCopyWith<$Res>? get wallet {
    if (_self.wallet == null) {
    return null;
  }

  return $WalletInfoCopyWith<$Res>(_self.wallet!, (value) {
    return _then(_self.copyWith(wallet: value));
  });
}/// Create a copy of DashboardOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RentalOverviewCopyWith<$Res>? get rental {
    if (_self.rental == null) {
    return null;
  }

  return $RentalOverviewCopyWith<$Res>(_self.rental!, (value) {
    return _then(_self.copyWith(rental: value));
  });
}/// Create a copy of DashboardOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfitOverviewCopyWith<$Res>? get profit {
    if (_self.profit == null) {
    return null;
  }

  return $ProfitOverviewCopyWith<$Res>(_self.profit!, (value) {
    return _then(_self.copyWith(profit: value));
  });
}/// Create a copy of DashboardOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamSummaryCopyWith<$Res>? get team {
    if (_self.team == null) {
    return null;
  }

  return $TeamSummaryCopyWith<$Res>(_self.team!, (value) {
    return _then(_self.copyWith(team: value));
  });
}
}


/// Adds pattern-matching-related methods to [DashboardOverview].
extension DashboardOverviewPatterns on DashboardOverview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardOverview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardOverview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardOverview value)  $default,){
final _that = this;
switch (_that) {
case _DashboardOverview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardOverview value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardOverview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( WalletInfo? wallet,  RentalOverview? rental,  ProfitOverview? profit,  TeamSummary? team)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardOverview() when $default != null:
return $default(_that.wallet,_that.rental,_that.profit,_that.team);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( WalletInfo? wallet,  RentalOverview? rental,  ProfitOverview? profit,  TeamSummary? team)  $default,) {final _that = this;
switch (_that) {
case _DashboardOverview():
return $default(_that.wallet,_that.rental,_that.profit,_that.team);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( WalletInfo? wallet,  RentalOverview? rental,  ProfitOverview? profit,  TeamSummary? team)?  $default,) {final _that = this;
switch (_that) {
case _DashboardOverview() when $default != null:
return $default(_that.wallet,_that.rental,_that.profit,_that.team);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DashboardOverview implements DashboardOverview {
  const _DashboardOverview({this.wallet, this.rental, this.profit, this.team});
  factory _DashboardOverview.fromJson(Map<String, dynamic> json) => _$DashboardOverviewFromJson(json);

@override final  WalletInfo? wallet;
@override final  RentalOverview? rental;
@override final  ProfitOverview? profit;
@override final  TeamSummary? team;

/// Create a copy of DashboardOverview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardOverviewCopyWith<_DashboardOverview> get copyWith => __$DashboardOverviewCopyWithImpl<_DashboardOverview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DashboardOverviewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardOverview&&(identical(other.wallet, wallet) || other.wallet == wallet)&&(identical(other.rental, rental) || other.rental == rental)&&(identical(other.profit, profit) || other.profit == profit)&&(identical(other.team, team) || other.team == team));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,wallet,rental,profit,team);

@override
String toString() {
  return 'DashboardOverview(wallet: $wallet, rental: $rental, profit: $profit, team: $team)';
}


}

/// @nodoc
abstract mixin class _$DashboardOverviewCopyWith<$Res> implements $DashboardOverviewCopyWith<$Res> {
  factory _$DashboardOverviewCopyWith(_DashboardOverview value, $Res Function(_DashboardOverview) _then) = __$DashboardOverviewCopyWithImpl;
@override @useResult
$Res call({
 WalletInfo? wallet, RentalOverview? rental, ProfitOverview? profit, TeamSummary? team
});


@override $WalletInfoCopyWith<$Res>? get wallet;@override $RentalOverviewCopyWith<$Res>? get rental;@override $ProfitOverviewCopyWith<$Res>? get profit;@override $TeamSummaryCopyWith<$Res>? get team;

}
/// @nodoc
class __$DashboardOverviewCopyWithImpl<$Res>
    implements _$DashboardOverviewCopyWith<$Res> {
  __$DashboardOverviewCopyWithImpl(this._self, this._then);

  final _DashboardOverview _self;
  final $Res Function(_DashboardOverview) _then;

/// Create a copy of DashboardOverview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? wallet = freezed,Object? rental = freezed,Object? profit = freezed,Object? team = freezed,}) {
  return _then(_DashboardOverview(
wallet: freezed == wallet ? _self.wallet : wallet // ignore: cast_nullable_to_non_nullable
as WalletInfo?,rental: freezed == rental ? _self.rental : rental // ignore: cast_nullable_to_non_nullable
as RentalOverview?,profit: freezed == profit ? _self.profit : profit // ignore: cast_nullable_to_non_nullable
as ProfitOverview?,team: freezed == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as TeamSummary?,
  ));
}

/// Create a copy of DashboardOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WalletInfoCopyWith<$Res>? get wallet {
    if (_self.wallet == null) {
    return null;
  }

  return $WalletInfoCopyWith<$Res>(_self.wallet!, (value) {
    return _then(_self.copyWith(wallet: value));
  });
}/// Create a copy of DashboardOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RentalOverviewCopyWith<$Res>? get rental {
    if (_self.rental == null) {
    return null;
  }

  return $RentalOverviewCopyWith<$Res>(_self.rental!, (value) {
    return _then(_self.copyWith(rental: value));
  });
}/// Create a copy of DashboardOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfitOverviewCopyWith<$Res>? get profit {
    if (_self.profit == null) {
    return null;
  }

  return $ProfitOverviewCopyWith<$Res>(_self.profit!, (value) {
    return _then(_self.copyWith(profit: value));
  });
}/// Create a copy of DashboardOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamSummaryCopyWith<$Res>? get team {
    if (_self.team == null) {
    return null;
  }

  return $TeamSummaryCopyWith<$Res>(_self.team!, (value) {
    return _then(_self.copyWith(team: value));
  });
}
}


/// @nodoc
mixin _$RentalOverview {

 int get runningOrderCount; int get pendingPayOrderCount; List<RentalOrder> get recentOrders;
/// Create a copy of RentalOverview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RentalOverviewCopyWith<RentalOverview> get copyWith => _$RentalOverviewCopyWithImpl<RentalOverview>(this as RentalOverview, _$identity);

  /// Serializes this RentalOverview to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RentalOverview&&(identical(other.runningOrderCount, runningOrderCount) || other.runningOrderCount == runningOrderCount)&&(identical(other.pendingPayOrderCount, pendingPayOrderCount) || other.pendingPayOrderCount == pendingPayOrderCount)&&const DeepCollectionEquality().equals(other.recentOrders, recentOrders));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,runningOrderCount,pendingPayOrderCount,const DeepCollectionEquality().hash(recentOrders));

@override
String toString() {
  return 'RentalOverview(runningOrderCount: $runningOrderCount, pendingPayOrderCount: $pendingPayOrderCount, recentOrders: $recentOrders)';
}


}

/// @nodoc
abstract mixin class $RentalOverviewCopyWith<$Res>  {
  factory $RentalOverviewCopyWith(RentalOverview value, $Res Function(RentalOverview) _then) = _$RentalOverviewCopyWithImpl;
@useResult
$Res call({
 int runningOrderCount, int pendingPayOrderCount, List<RentalOrder> recentOrders
});




}
/// @nodoc
class _$RentalOverviewCopyWithImpl<$Res>
    implements $RentalOverviewCopyWith<$Res> {
  _$RentalOverviewCopyWithImpl(this._self, this._then);

  final RentalOverview _self;
  final $Res Function(RentalOverview) _then;

/// Create a copy of RentalOverview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? runningOrderCount = null,Object? pendingPayOrderCount = null,Object? recentOrders = null,}) {
  return _then(_self.copyWith(
runningOrderCount: null == runningOrderCount ? _self.runningOrderCount : runningOrderCount // ignore: cast_nullable_to_non_nullable
as int,pendingPayOrderCount: null == pendingPayOrderCount ? _self.pendingPayOrderCount : pendingPayOrderCount // ignore: cast_nullable_to_non_nullable
as int,recentOrders: null == recentOrders ? _self.recentOrders : recentOrders // ignore: cast_nullable_to_non_nullable
as List<RentalOrder>,
  ));
}

}


/// Adds pattern-matching-related methods to [RentalOverview].
extension RentalOverviewPatterns on RentalOverview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RentalOverview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RentalOverview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RentalOverview value)  $default,){
final _that = this;
switch (_that) {
case _RentalOverview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RentalOverview value)?  $default,){
final _that = this;
switch (_that) {
case _RentalOverview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int runningOrderCount,  int pendingPayOrderCount,  List<RentalOrder> recentOrders)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RentalOverview() when $default != null:
return $default(_that.runningOrderCount,_that.pendingPayOrderCount,_that.recentOrders);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int runningOrderCount,  int pendingPayOrderCount,  List<RentalOrder> recentOrders)  $default,) {final _that = this;
switch (_that) {
case _RentalOverview():
return $default(_that.runningOrderCount,_that.pendingPayOrderCount,_that.recentOrders);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int runningOrderCount,  int pendingPayOrderCount,  List<RentalOrder> recentOrders)?  $default,) {final _that = this;
switch (_that) {
case _RentalOverview() when $default != null:
return $default(_that.runningOrderCount,_that.pendingPayOrderCount,_that.recentOrders);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RentalOverview implements RentalOverview {
  const _RentalOverview({this.runningOrderCount = 0, this.pendingPayOrderCount = 0, final  List<RentalOrder> recentOrders = const <RentalOrder>[]}): _recentOrders = recentOrders;
  factory _RentalOverview.fromJson(Map<String, dynamic> json) => _$RentalOverviewFromJson(json);

@override@JsonKey() final  int runningOrderCount;
@override@JsonKey() final  int pendingPayOrderCount;
 final  List<RentalOrder> _recentOrders;
@override@JsonKey() List<RentalOrder> get recentOrders {
  if (_recentOrders is EqualUnmodifiableListView) return _recentOrders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentOrders);
}


/// Create a copy of RentalOverview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RentalOverviewCopyWith<_RentalOverview> get copyWith => __$RentalOverviewCopyWithImpl<_RentalOverview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RentalOverviewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RentalOverview&&(identical(other.runningOrderCount, runningOrderCount) || other.runningOrderCount == runningOrderCount)&&(identical(other.pendingPayOrderCount, pendingPayOrderCount) || other.pendingPayOrderCount == pendingPayOrderCount)&&const DeepCollectionEquality().equals(other._recentOrders, _recentOrders));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,runningOrderCount,pendingPayOrderCount,const DeepCollectionEquality().hash(_recentOrders));

@override
String toString() {
  return 'RentalOverview(runningOrderCount: $runningOrderCount, pendingPayOrderCount: $pendingPayOrderCount, recentOrders: $recentOrders)';
}


}

/// @nodoc
abstract mixin class _$RentalOverviewCopyWith<$Res> implements $RentalOverviewCopyWith<$Res> {
  factory _$RentalOverviewCopyWith(_RentalOverview value, $Res Function(_RentalOverview) _then) = __$RentalOverviewCopyWithImpl;
@override @useResult
$Res call({
 int runningOrderCount, int pendingPayOrderCount, List<RentalOrder> recentOrders
});




}
/// @nodoc
class __$RentalOverviewCopyWithImpl<$Res>
    implements _$RentalOverviewCopyWith<$Res> {
  __$RentalOverviewCopyWithImpl(this._self, this._then);

  final _RentalOverview _self;
  final $Res Function(_RentalOverview) _then;

/// Create a copy of RentalOverview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? runningOrderCount = null,Object? pendingPayOrderCount = null,Object? recentOrders = null,}) {
  return _then(_RentalOverview(
runningOrderCount: null == runningOrderCount ? _self.runningOrderCount : runningOrderCount // ignore: cast_nullable_to_non_nullable
as int,pendingPayOrderCount: null == pendingPayOrderCount ? _self.pendingPayOrderCount : pendingPayOrderCount // ignore: cast_nullable_to_non_nullable
as int,recentOrders: null == recentOrders ? _self._recentOrders : recentOrders // ignore: cast_nullable_to_non_nullable
as List<RentalOrder>,
  ));
}


}


/// @nodoc
mixin _$ProfitOverview {

 ProfitSummary? get summary;
/// Create a copy of ProfitOverview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfitOverviewCopyWith<ProfitOverview> get copyWith => _$ProfitOverviewCopyWithImpl<ProfitOverview>(this as ProfitOverview, _$identity);

  /// Serializes this ProfitOverview to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfitOverview&&(identical(other.summary, summary) || other.summary == summary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,summary);

@override
String toString() {
  return 'ProfitOverview(summary: $summary)';
}


}

/// @nodoc
abstract mixin class $ProfitOverviewCopyWith<$Res>  {
  factory $ProfitOverviewCopyWith(ProfitOverview value, $Res Function(ProfitOverview) _then) = _$ProfitOverviewCopyWithImpl;
@useResult
$Res call({
 ProfitSummary? summary
});


$ProfitSummaryCopyWith<$Res>? get summary;

}
/// @nodoc
class _$ProfitOverviewCopyWithImpl<$Res>
    implements $ProfitOverviewCopyWith<$Res> {
  _$ProfitOverviewCopyWithImpl(this._self, this._then);

  final ProfitOverview _self;
  final $Res Function(ProfitOverview) _then;

/// Create a copy of ProfitOverview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? summary = freezed,}) {
  return _then(_self.copyWith(
summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as ProfitSummary?,
  ));
}
/// Create a copy of ProfitOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfitSummaryCopyWith<$Res>? get summary {
    if (_self.summary == null) {
    return null;
  }

  return $ProfitSummaryCopyWith<$Res>(_self.summary!, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProfitOverview].
extension ProfitOverviewPatterns on ProfitOverview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfitOverview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfitOverview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfitOverview value)  $default,){
final _that = this;
switch (_that) {
case _ProfitOverview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfitOverview value)?  $default,){
final _that = this;
switch (_that) {
case _ProfitOverview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ProfitSummary? summary)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfitOverview() when $default != null:
return $default(_that.summary);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ProfitSummary? summary)  $default,) {final _that = this;
switch (_that) {
case _ProfitOverview():
return $default(_that.summary);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ProfitSummary? summary)?  $default,) {final _that = this;
switch (_that) {
case _ProfitOverview() when $default != null:
return $default(_that.summary);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfitOverview implements ProfitOverview {
  const _ProfitOverview({this.summary});
  factory _ProfitOverview.fromJson(Map<String, dynamic> json) => _$ProfitOverviewFromJson(json);

@override final  ProfitSummary? summary;

/// Create a copy of ProfitOverview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfitOverviewCopyWith<_ProfitOverview> get copyWith => __$ProfitOverviewCopyWithImpl<_ProfitOverview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfitOverviewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfitOverview&&(identical(other.summary, summary) || other.summary == summary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,summary);

@override
String toString() {
  return 'ProfitOverview(summary: $summary)';
}


}

/// @nodoc
abstract mixin class _$ProfitOverviewCopyWith<$Res> implements $ProfitOverviewCopyWith<$Res> {
  factory _$ProfitOverviewCopyWith(_ProfitOverview value, $Res Function(_ProfitOverview) _then) = __$ProfitOverviewCopyWithImpl;
@override @useResult
$Res call({
 ProfitSummary? summary
});


@override $ProfitSummaryCopyWith<$Res>? get summary;

}
/// @nodoc
class __$ProfitOverviewCopyWithImpl<$Res>
    implements _$ProfitOverviewCopyWith<$Res> {
  __$ProfitOverviewCopyWithImpl(this._self, this._then);

  final _ProfitOverview _self;
  final $Res Function(_ProfitOverview) _then;

/// Create a copy of ProfitOverview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? summary = freezed,}) {
  return _then(_ProfitOverview(
summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as ProfitSummary?,
  ));
}

/// Create a copy of ProfitOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfitSummaryCopyWith<$Res>? get summary {
    if (_self.summary == null) {
    return null;
  }

  return $ProfitSummaryCopyWith<$Res>(_self.summary!, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// @nodoc
mixin _$ProductItem {

 int? get id; String? get productCode; String? get productName; String? get machineAlias; String? get regionName; String? get gpuModelName; int? get gpuMemoryGb;@JsonKey(fromJson: _stringFromJson) String? get gpuPowerTops;@JsonKey(fromJson: _stringFromJson) String? get rentPrice;@JsonKey(fromJson: _stringFromJson) String? get tokenOutputPerDay;@JsonKey(fromJson: _stringFromJson) String? get yieldRate; String? get rentableUntil; String? get cpuModel; int? get cpuCores; int? get memoryGb; int? get systemDiskGb; int? get dataDiskGb; String? get driverVersion; String? get cudaVersion; int? get hasCacheOptimization;
/// Create a copy of ProductItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductItemCopyWith<ProductItem> get copyWith => _$ProductItemCopyWithImpl<ProductItem>(this as ProductItem, _$identity);

  /// Serializes this ProductItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductItem&&(identical(other.id, id) || other.id == id)&&(identical(other.productCode, productCode) || other.productCode == productCode)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.machineAlias, machineAlias) || other.machineAlias == machineAlias)&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.gpuModelName, gpuModelName) || other.gpuModelName == gpuModelName)&&(identical(other.gpuMemoryGb, gpuMemoryGb) || other.gpuMemoryGb == gpuMemoryGb)&&(identical(other.gpuPowerTops, gpuPowerTops) || other.gpuPowerTops == gpuPowerTops)&&(identical(other.rentPrice, rentPrice) || other.rentPrice == rentPrice)&&(identical(other.tokenOutputPerDay, tokenOutputPerDay) || other.tokenOutputPerDay == tokenOutputPerDay)&&(identical(other.yieldRate, yieldRate) || other.yieldRate == yieldRate)&&(identical(other.rentableUntil, rentableUntil) || other.rentableUntil == rentableUntil)&&(identical(other.cpuModel, cpuModel) || other.cpuModel == cpuModel)&&(identical(other.cpuCores, cpuCores) || other.cpuCores == cpuCores)&&(identical(other.memoryGb, memoryGb) || other.memoryGb == memoryGb)&&(identical(other.systemDiskGb, systemDiskGb) || other.systemDiskGb == systemDiskGb)&&(identical(other.dataDiskGb, dataDiskGb) || other.dataDiskGb == dataDiskGb)&&(identical(other.driverVersion, driverVersion) || other.driverVersion == driverVersion)&&(identical(other.cudaVersion, cudaVersion) || other.cudaVersion == cudaVersion)&&(identical(other.hasCacheOptimization, hasCacheOptimization) || other.hasCacheOptimization == hasCacheOptimization));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,productCode,productName,machineAlias,regionName,gpuModelName,gpuMemoryGb,gpuPowerTops,rentPrice,tokenOutputPerDay,yieldRate,rentableUntil,cpuModel,cpuCores,memoryGb,systemDiskGb,dataDiskGb,driverVersion,cudaVersion,hasCacheOptimization]);

@override
String toString() {
  return 'ProductItem(id: $id, productCode: $productCode, productName: $productName, machineAlias: $machineAlias, regionName: $regionName, gpuModelName: $gpuModelName, gpuMemoryGb: $gpuMemoryGb, gpuPowerTops: $gpuPowerTops, rentPrice: $rentPrice, tokenOutputPerDay: $tokenOutputPerDay, yieldRate: $yieldRate, rentableUntil: $rentableUntil, cpuModel: $cpuModel, cpuCores: $cpuCores, memoryGb: $memoryGb, systemDiskGb: $systemDiskGb, dataDiskGb: $dataDiskGb, driverVersion: $driverVersion, cudaVersion: $cudaVersion, hasCacheOptimization: $hasCacheOptimization)';
}


}

/// @nodoc
abstract mixin class $ProductItemCopyWith<$Res>  {
  factory $ProductItemCopyWith(ProductItem value, $Res Function(ProductItem) _then) = _$ProductItemCopyWithImpl;
@useResult
$Res call({
 int? id, String? productCode, String? productName, String? machineAlias, String? regionName, String? gpuModelName, int? gpuMemoryGb,@JsonKey(fromJson: _stringFromJson) String? gpuPowerTops,@JsonKey(fromJson: _stringFromJson) String? rentPrice,@JsonKey(fromJson: _stringFromJson) String? tokenOutputPerDay,@JsonKey(fromJson: _stringFromJson) String? yieldRate, String? rentableUntil, String? cpuModel, int? cpuCores, int? memoryGb, int? systemDiskGb, int? dataDiskGb, String? driverVersion, String? cudaVersion, int? hasCacheOptimization
});




}
/// @nodoc
class _$ProductItemCopyWithImpl<$Res>
    implements $ProductItemCopyWith<$Res> {
  _$ProductItemCopyWithImpl(this._self, this._then);

  final ProductItem _self;
  final $Res Function(ProductItem) _then;

/// Create a copy of ProductItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? productCode = freezed,Object? productName = freezed,Object? machineAlias = freezed,Object? regionName = freezed,Object? gpuModelName = freezed,Object? gpuMemoryGb = freezed,Object? gpuPowerTops = freezed,Object? rentPrice = freezed,Object? tokenOutputPerDay = freezed,Object? yieldRate = freezed,Object? rentableUntil = freezed,Object? cpuModel = freezed,Object? cpuCores = freezed,Object? memoryGb = freezed,Object? systemDiskGb = freezed,Object? dataDiskGb = freezed,Object? driverVersion = freezed,Object? cudaVersion = freezed,Object? hasCacheOptimization = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,productCode: freezed == productCode ? _self.productCode : productCode // ignore: cast_nullable_to_non_nullable
as String?,productName: freezed == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String?,machineAlias: freezed == machineAlias ? _self.machineAlias : machineAlias // ignore: cast_nullable_to_non_nullable
as String?,regionName: freezed == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String?,gpuModelName: freezed == gpuModelName ? _self.gpuModelName : gpuModelName // ignore: cast_nullable_to_non_nullable
as String?,gpuMemoryGb: freezed == gpuMemoryGb ? _self.gpuMemoryGb : gpuMemoryGb // ignore: cast_nullable_to_non_nullable
as int?,gpuPowerTops: freezed == gpuPowerTops ? _self.gpuPowerTops : gpuPowerTops // ignore: cast_nullable_to_non_nullable
as String?,rentPrice: freezed == rentPrice ? _self.rentPrice : rentPrice // ignore: cast_nullable_to_non_nullable
as String?,tokenOutputPerDay: freezed == tokenOutputPerDay ? _self.tokenOutputPerDay : tokenOutputPerDay // ignore: cast_nullable_to_non_nullable
as String?,yieldRate: freezed == yieldRate ? _self.yieldRate : yieldRate // ignore: cast_nullable_to_non_nullable
as String?,rentableUntil: freezed == rentableUntil ? _self.rentableUntil : rentableUntil // ignore: cast_nullable_to_non_nullable
as String?,cpuModel: freezed == cpuModel ? _self.cpuModel : cpuModel // ignore: cast_nullable_to_non_nullable
as String?,cpuCores: freezed == cpuCores ? _self.cpuCores : cpuCores // ignore: cast_nullable_to_non_nullable
as int?,memoryGb: freezed == memoryGb ? _self.memoryGb : memoryGb // ignore: cast_nullable_to_non_nullable
as int?,systemDiskGb: freezed == systemDiskGb ? _self.systemDiskGb : systemDiskGb // ignore: cast_nullable_to_non_nullable
as int?,dataDiskGb: freezed == dataDiskGb ? _self.dataDiskGb : dataDiskGb // ignore: cast_nullable_to_non_nullable
as int?,driverVersion: freezed == driverVersion ? _self.driverVersion : driverVersion // ignore: cast_nullable_to_non_nullable
as String?,cudaVersion: freezed == cudaVersion ? _self.cudaVersion : cudaVersion // ignore: cast_nullable_to_non_nullable
as String?,hasCacheOptimization: freezed == hasCacheOptimization ? _self.hasCacheOptimization : hasCacheOptimization // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductItem].
extension ProductItemPatterns on ProductItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductItem value)  $default,){
final _that = this;
switch (_that) {
case _ProductItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductItem value)?  $default,){
final _that = this;
switch (_that) {
case _ProductItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String? productCode,  String? productName,  String? machineAlias,  String? regionName,  String? gpuModelName,  int? gpuMemoryGb, @JsonKey(fromJson: _stringFromJson)  String? gpuPowerTops, @JsonKey(fromJson: _stringFromJson)  String? rentPrice, @JsonKey(fromJson: _stringFromJson)  String? tokenOutputPerDay, @JsonKey(fromJson: _stringFromJson)  String? yieldRate,  String? rentableUntil,  String? cpuModel,  int? cpuCores,  int? memoryGb,  int? systemDiskGb,  int? dataDiskGb,  String? driverVersion,  String? cudaVersion,  int? hasCacheOptimization)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductItem() when $default != null:
return $default(_that.id,_that.productCode,_that.productName,_that.machineAlias,_that.regionName,_that.gpuModelName,_that.gpuMemoryGb,_that.gpuPowerTops,_that.rentPrice,_that.tokenOutputPerDay,_that.yieldRate,_that.rentableUntil,_that.cpuModel,_that.cpuCores,_that.memoryGb,_that.systemDiskGb,_that.dataDiskGb,_that.driverVersion,_that.cudaVersion,_that.hasCacheOptimization);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String? productCode,  String? productName,  String? machineAlias,  String? regionName,  String? gpuModelName,  int? gpuMemoryGb, @JsonKey(fromJson: _stringFromJson)  String? gpuPowerTops, @JsonKey(fromJson: _stringFromJson)  String? rentPrice, @JsonKey(fromJson: _stringFromJson)  String? tokenOutputPerDay, @JsonKey(fromJson: _stringFromJson)  String? yieldRate,  String? rentableUntil,  String? cpuModel,  int? cpuCores,  int? memoryGb,  int? systemDiskGb,  int? dataDiskGb,  String? driverVersion,  String? cudaVersion,  int? hasCacheOptimization)  $default,) {final _that = this;
switch (_that) {
case _ProductItem():
return $default(_that.id,_that.productCode,_that.productName,_that.machineAlias,_that.regionName,_that.gpuModelName,_that.gpuMemoryGb,_that.gpuPowerTops,_that.rentPrice,_that.tokenOutputPerDay,_that.yieldRate,_that.rentableUntil,_that.cpuModel,_that.cpuCores,_that.memoryGb,_that.systemDiskGb,_that.dataDiskGb,_that.driverVersion,_that.cudaVersion,_that.hasCacheOptimization);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String? productCode,  String? productName,  String? machineAlias,  String? regionName,  String? gpuModelName,  int? gpuMemoryGb, @JsonKey(fromJson: _stringFromJson)  String? gpuPowerTops, @JsonKey(fromJson: _stringFromJson)  String? rentPrice, @JsonKey(fromJson: _stringFromJson)  String? tokenOutputPerDay, @JsonKey(fromJson: _stringFromJson)  String? yieldRate,  String? rentableUntil,  String? cpuModel,  int? cpuCores,  int? memoryGb,  int? systemDiskGb,  int? dataDiskGb,  String? driverVersion,  String? cudaVersion,  int? hasCacheOptimization)?  $default,) {final _that = this;
switch (_that) {
case _ProductItem() when $default != null:
return $default(_that.id,_that.productCode,_that.productName,_that.machineAlias,_that.regionName,_that.gpuModelName,_that.gpuMemoryGb,_that.gpuPowerTops,_that.rentPrice,_that.tokenOutputPerDay,_that.yieldRate,_that.rentableUntil,_that.cpuModel,_that.cpuCores,_that.memoryGb,_that.systemDiskGb,_that.dataDiskGb,_that.driverVersion,_that.cudaVersion,_that.hasCacheOptimization);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductItem implements ProductItem {
  const _ProductItem({this.id, this.productCode, this.productName, this.machineAlias, this.regionName, this.gpuModelName, this.gpuMemoryGb, @JsonKey(fromJson: _stringFromJson) this.gpuPowerTops, @JsonKey(fromJson: _stringFromJson) this.rentPrice, @JsonKey(fromJson: _stringFromJson) this.tokenOutputPerDay, @JsonKey(fromJson: _stringFromJson) this.yieldRate, this.rentableUntil, this.cpuModel, this.cpuCores, this.memoryGb, this.systemDiskGb, this.dataDiskGb, this.driverVersion, this.cudaVersion, this.hasCacheOptimization});
  factory _ProductItem.fromJson(Map<String, dynamic> json) => _$ProductItemFromJson(json);

@override final  int? id;
@override final  String? productCode;
@override final  String? productName;
@override final  String? machineAlias;
@override final  String? regionName;
@override final  String? gpuModelName;
@override final  int? gpuMemoryGb;
@override@JsonKey(fromJson: _stringFromJson) final  String? gpuPowerTops;
@override@JsonKey(fromJson: _stringFromJson) final  String? rentPrice;
@override@JsonKey(fromJson: _stringFromJson) final  String? tokenOutputPerDay;
@override@JsonKey(fromJson: _stringFromJson) final  String? yieldRate;
@override final  String? rentableUntil;
@override final  String? cpuModel;
@override final  int? cpuCores;
@override final  int? memoryGb;
@override final  int? systemDiskGb;
@override final  int? dataDiskGb;
@override final  String? driverVersion;
@override final  String? cudaVersion;
@override final  int? hasCacheOptimization;

/// Create a copy of ProductItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductItemCopyWith<_ProductItem> get copyWith => __$ProductItemCopyWithImpl<_ProductItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductItem&&(identical(other.id, id) || other.id == id)&&(identical(other.productCode, productCode) || other.productCode == productCode)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.machineAlias, machineAlias) || other.machineAlias == machineAlias)&&(identical(other.regionName, regionName) || other.regionName == regionName)&&(identical(other.gpuModelName, gpuModelName) || other.gpuModelName == gpuModelName)&&(identical(other.gpuMemoryGb, gpuMemoryGb) || other.gpuMemoryGb == gpuMemoryGb)&&(identical(other.gpuPowerTops, gpuPowerTops) || other.gpuPowerTops == gpuPowerTops)&&(identical(other.rentPrice, rentPrice) || other.rentPrice == rentPrice)&&(identical(other.tokenOutputPerDay, tokenOutputPerDay) || other.tokenOutputPerDay == tokenOutputPerDay)&&(identical(other.yieldRate, yieldRate) || other.yieldRate == yieldRate)&&(identical(other.rentableUntil, rentableUntil) || other.rentableUntil == rentableUntil)&&(identical(other.cpuModel, cpuModel) || other.cpuModel == cpuModel)&&(identical(other.cpuCores, cpuCores) || other.cpuCores == cpuCores)&&(identical(other.memoryGb, memoryGb) || other.memoryGb == memoryGb)&&(identical(other.systemDiskGb, systemDiskGb) || other.systemDiskGb == systemDiskGb)&&(identical(other.dataDiskGb, dataDiskGb) || other.dataDiskGb == dataDiskGb)&&(identical(other.driverVersion, driverVersion) || other.driverVersion == driverVersion)&&(identical(other.cudaVersion, cudaVersion) || other.cudaVersion == cudaVersion)&&(identical(other.hasCacheOptimization, hasCacheOptimization) || other.hasCacheOptimization == hasCacheOptimization));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,productCode,productName,machineAlias,regionName,gpuModelName,gpuMemoryGb,gpuPowerTops,rentPrice,tokenOutputPerDay,yieldRate,rentableUntil,cpuModel,cpuCores,memoryGb,systemDiskGb,dataDiskGb,driverVersion,cudaVersion,hasCacheOptimization]);

@override
String toString() {
  return 'ProductItem(id: $id, productCode: $productCode, productName: $productName, machineAlias: $machineAlias, regionName: $regionName, gpuModelName: $gpuModelName, gpuMemoryGb: $gpuMemoryGb, gpuPowerTops: $gpuPowerTops, rentPrice: $rentPrice, tokenOutputPerDay: $tokenOutputPerDay, yieldRate: $yieldRate, rentableUntil: $rentableUntil, cpuModel: $cpuModel, cpuCores: $cpuCores, memoryGb: $memoryGb, systemDiskGb: $systemDiskGb, dataDiskGb: $dataDiskGb, driverVersion: $driverVersion, cudaVersion: $cudaVersion, hasCacheOptimization: $hasCacheOptimization)';
}


}

/// @nodoc
abstract mixin class _$ProductItemCopyWith<$Res> implements $ProductItemCopyWith<$Res> {
  factory _$ProductItemCopyWith(_ProductItem value, $Res Function(_ProductItem) _then) = __$ProductItemCopyWithImpl;
@override @useResult
$Res call({
 int? id, String? productCode, String? productName, String? machineAlias, String? regionName, String? gpuModelName, int? gpuMemoryGb,@JsonKey(fromJson: _stringFromJson) String? gpuPowerTops,@JsonKey(fromJson: _stringFromJson) String? rentPrice,@JsonKey(fromJson: _stringFromJson) String? tokenOutputPerDay,@JsonKey(fromJson: _stringFromJson) String? yieldRate, String? rentableUntil, String? cpuModel, int? cpuCores, int? memoryGb, int? systemDiskGb, int? dataDiskGb, String? driverVersion, String? cudaVersion, int? hasCacheOptimization
});




}
/// @nodoc
class __$ProductItemCopyWithImpl<$Res>
    implements _$ProductItemCopyWith<$Res> {
  __$ProductItemCopyWithImpl(this._self, this._then);

  final _ProductItem _self;
  final $Res Function(_ProductItem) _then;

/// Create a copy of ProductItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? productCode = freezed,Object? productName = freezed,Object? machineAlias = freezed,Object? regionName = freezed,Object? gpuModelName = freezed,Object? gpuMemoryGb = freezed,Object? gpuPowerTops = freezed,Object? rentPrice = freezed,Object? tokenOutputPerDay = freezed,Object? yieldRate = freezed,Object? rentableUntil = freezed,Object? cpuModel = freezed,Object? cpuCores = freezed,Object? memoryGb = freezed,Object? systemDiskGb = freezed,Object? dataDiskGb = freezed,Object? driverVersion = freezed,Object? cudaVersion = freezed,Object? hasCacheOptimization = freezed,}) {
  return _then(_ProductItem(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,productCode: freezed == productCode ? _self.productCode : productCode // ignore: cast_nullable_to_non_nullable
as String?,productName: freezed == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String?,machineAlias: freezed == machineAlias ? _self.machineAlias : machineAlias // ignore: cast_nullable_to_non_nullable
as String?,regionName: freezed == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String?,gpuModelName: freezed == gpuModelName ? _self.gpuModelName : gpuModelName // ignore: cast_nullable_to_non_nullable
as String?,gpuMemoryGb: freezed == gpuMemoryGb ? _self.gpuMemoryGb : gpuMemoryGb // ignore: cast_nullable_to_non_nullable
as int?,gpuPowerTops: freezed == gpuPowerTops ? _self.gpuPowerTops : gpuPowerTops // ignore: cast_nullable_to_non_nullable
as String?,rentPrice: freezed == rentPrice ? _self.rentPrice : rentPrice // ignore: cast_nullable_to_non_nullable
as String?,tokenOutputPerDay: freezed == tokenOutputPerDay ? _self.tokenOutputPerDay : tokenOutputPerDay // ignore: cast_nullable_to_non_nullable
as String?,yieldRate: freezed == yieldRate ? _self.yieldRate : yieldRate // ignore: cast_nullable_to_non_nullable
as String?,rentableUntil: freezed == rentableUntil ? _self.rentableUntil : rentableUntil // ignore: cast_nullable_to_non_nullable
as String?,cpuModel: freezed == cpuModel ? _self.cpuModel : cpuModel // ignore: cast_nullable_to_non_nullable
as String?,cpuCores: freezed == cpuCores ? _self.cpuCores : cpuCores // ignore: cast_nullable_to_non_nullable
as int?,memoryGb: freezed == memoryGb ? _self.memoryGb : memoryGb // ignore: cast_nullable_to_non_nullable
as int?,systemDiskGb: freezed == systemDiskGb ? _self.systemDiskGb : systemDiskGb // ignore: cast_nullable_to_non_nullable
as int?,dataDiskGb: freezed == dataDiskGb ? _self.dataDiskGb : dataDiskGb // ignore: cast_nullable_to_non_nullable
as int?,driverVersion: freezed == driverVersion ? _self.driverVersion : driverVersion // ignore: cast_nullable_to_non_nullable
as String?,cudaVersion: freezed == cudaVersion ? _self.cudaVersion : cudaVersion // ignore: cast_nullable_to_non_nullable
as String?,hasCacheOptimization: freezed == hasCacheOptimization ? _self.hasCacheOptimization : hasCacheOptimization // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$AiModelItem {

 int? get id; String? get modelCode; String? get modelName; String? get vendorName; String? get logoUrl;@JsonKey(fromJson: _stringFromJson) String? get monthlyTokenConsumptionTrillion;@JsonKey(fromJson: _stringFromJson) String? get tokenUnitPrice;@JsonKey(fromJson: _stringFromJson) String? get deployTechFee;
/// Create a copy of AiModelItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiModelItemCopyWith<AiModelItem> get copyWith => _$AiModelItemCopyWithImpl<AiModelItem>(this as AiModelItem, _$identity);

  /// Serializes this AiModelItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiModelItem&&(identical(other.id, id) || other.id == id)&&(identical(other.modelCode, modelCode) || other.modelCode == modelCode)&&(identical(other.modelName, modelName) || other.modelName == modelName)&&(identical(other.vendorName, vendorName) || other.vendorName == vendorName)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.monthlyTokenConsumptionTrillion, monthlyTokenConsumptionTrillion) || other.monthlyTokenConsumptionTrillion == monthlyTokenConsumptionTrillion)&&(identical(other.tokenUnitPrice, tokenUnitPrice) || other.tokenUnitPrice == tokenUnitPrice)&&(identical(other.deployTechFee, deployTechFee) || other.deployTechFee == deployTechFee));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,modelCode,modelName,vendorName,logoUrl,monthlyTokenConsumptionTrillion,tokenUnitPrice,deployTechFee);

@override
String toString() {
  return 'AiModelItem(id: $id, modelCode: $modelCode, modelName: $modelName, vendorName: $vendorName, logoUrl: $logoUrl, monthlyTokenConsumptionTrillion: $monthlyTokenConsumptionTrillion, tokenUnitPrice: $tokenUnitPrice, deployTechFee: $deployTechFee)';
}


}

/// @nodoc
abstract mixin class $AiModelItemCopyWith<$Res>  {
  factory $AiModelItemCopyWith(AiModelItem value, $Res Function(AiModelItem) _then) = _$AiModelItemCopyWithImpl;
@useResult
$Res call({
 int? id, String? modelCode, String? modelName, String? vendorName, String? logoUrl,@JsonKey(fromJson: _stringFromJson) String? monthlyTokenConsumptionTrillion,@JsonKey(fromJson: _stringFromJson) String? tokenUnitPrice,@JsonKey(fromJson: _stringFromJson) String? deployTechFee
});




}
/// @nodoc
class _$AiModelItemCopyWithImpl<$Res>
    implements $AiModelItemCopyWith<$Res> {
  _$AiModelItemCopyWithImpl(this._self, this._then);

  final AiModelItem _self;
  final $Res Function(AiModelItem) _then;

/// Create a copy of AiModelItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? modelCode = freezed,Object? modelName = freezed,Object? vendorName = freezed,Object? logoUrl = freezed,Object? monthlyTokenConsumptionTrillion = freezed,Object? tokenUnitPrice = freezed,Object? deployTechFee = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,modelCode: freezed == modelCode ? _self.modelCode : modelCode // ignore: cast_nullable_to_non_nullable
as String?,modelName: freezed == modelName ? _self.modelName : modelName // ignore: cast_nullable_to_non_nullable
as String?,vendorName: freezed == vendorName ? _self.vendorName : vendorName // ignore: cast_nullable_to_non_nullable
as String?,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,monthlyTokenConsumptionTrillion: freezed == monthlyTokenConsumptionTrillion ? _self.monthlyTokenConsumptionTrillion : monthlyTokenConsumptionTrillion // ignore: cast_nullable_to_non_nullable
as String?,tokenUnitPrice: freezed == tokenUnitPrice ? _self.tokenUnitPrice : tokenUnitPrice // ignore: cast_nullable_to_non_nullable
as String?,deployTechFee: freezed == deployTechFee ? _self.deployTechFee : deployTechFee // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AiModelItem].
extension AiModelItemPatterns on AiModelItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiModelItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiModelItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiModelItem value)  $default,){
final _that = this;
switch (_that) {
case _AiModelItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiModelItem value)?  $default,){
final _that = this;
switch (_that) {
case _AiModelItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String? modelCode,  String? modelName,  String? vendorName,  String? logoUrl, @JsonKey(fromJson: _stringFromJson)  String? monthlyTokenConsumptionTrillion, @JsonKey(fromJson: _stringFromJson)  String? tokenUnitPrice, @JsonKey(fromJson: _stringFromJson)  String? deployTechFee)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiModelItem() when $default != null:
return $default(_that.id,_that.modelCode,_that.modelName,_that.vendorName,_that.logoUrl,_that.monthlyTokenConsumptionTrillion,_that.tokenUnitPrice,_that.deployTechFee);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String? modelCode,  String? modelName,  String? vendorName,  String? logoUrl, @JsonKey(fromJson: _stringFromJson)  String? monthlyTokenConsumptionTrillion, @JsonKey(fromJson: _stringFromJson)  String? tokenUnitPrice, @JsonKey(fromJson: _stringFromJson)  String? deployTechFee)  $default,) {final _that = this;
switch (_that) {
case _AiModelItem():
return $default(_that.id,_that.modelCode,_that.modelName,_that.vendorName,_that.logoUrl,_that.monthlyTokenConsumptionTrillion,_that.tokenUnitPrice,_that.deployTechFee);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String? modelCode,  String? modelName,  String? vendorName,  String? logoUrl, @JsonKey(fromJson: _stringFromJson)  String? monthlyTokenConsumptionTrillion, @JsonKey(fromJson: _stringFromJson)  String? tokenUnitPrice, @JsonKey(fromJson: _stringFromJson)  String? deployTechFee)?  $default,) {final _that = this;
switch (_that) {
case _AiModelItem() when $default != null:
return $default(_that.id,_that.modelCode,_that.modelName,_that.vendorName,_that.logoUrl,_that.monthlyTokenConsumptionTrillion,_that.tokenUnitPrice,_that.deployTechFee);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiModelItem implements AiModelItem {
  const _AiModelItem({this.id, this.modelCode, this.modelName, this.vendorName, this.logoUrl, @JsonKey(fromJson: _stringFromJson) this.monthlyTokenConsumptionTrillion, @JsonKey(fromJson: _stringFromJson) this.tokenUnitPrice, @JsonKey(fromJson: _stringFromJson) this.deployTechFee});
  factory _AiModelItem.fromJson(Map<String, dynamic> json) => _$AiModelItemFromJson(json);

@override final  int? id;
@override final  String? modelCode;
@override final  String? modelName;
@override final  String? vendorName;
@override final  String? logoUrl;
@override@JsonKey(fromJson: _stringFromJson) final  String? monthlyTokenConsumptionTrillion;
@override@JsonKey(fromJson: _stringFromJson) final  String? tokenUnitPrice;
@override@JsonKey(fromJson: _stringFromJson) final  String? deployTechFee;

/// Create a copy of AiModelItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiModelItemCopyWith<_AiModelItem> get copyWith => __$AiModelItemCopyWithImpl<_AiModelItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiModelItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiModelItem&&(identical(other.id, id) || other.id == id)&&(identical(other.modelCode, modelCode) || other.modelCode == modelCode)&&(identical(other.modelName, modelName) || other.modelName == modelName)&&(identical(other.vendorName, vendorName) || other.vendorName == vendorName)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.monthlyTokenConsumptionTrillion, monthlyTokenConsumptionTrillion) || other.monthlyTokenConsumptionTrillion == monthlyTokenConsumptionTrillion)&&(identical(other.tokenUnitPrice, tokenUnitPrice) || other.tokenUnitPrice == tokenUnitPrice)&&(identical(other.deployTechFee, deployTechFee) || other.deployTechFee == deployTechFee));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,modelCode,modelName,vendorName,logoUrl,monthlyTokenConsumptionTrillion,tokenUnitPrice,deployTechFee);

@override
String toString() {
  return 'AiModelItem(id: $id, modelCode: $modelCode, modelName: $modelName, vendorName: $vendorName, logoUrl: $logoUrl, monthlyTokenConsumptionTrillion: $monthlyTokenConsumptionTrillion, tokenUnitPrice: $tokenUnitPrice, deployTechFee: $deployTechFee)';
}


}

/// @nodoc
abstract mixin class _$AiModelItemCopyWith<$Res> implements $AiModelItemCopyWith<$Res> {
  factory _$AiModelItemCopyWith(_AiModelItem value, $Res Function(_AiModelItem) _then) = __$AiModelItemCopyWithImpl;
@override @useResult
$Res call({
 int? id, String? modelCode, String? modelName, String? vendorName, String? logoUrl,@JsonKey(fromJson: _stringFromJson) String? monthlyTokenConsumptionTrillion,@JsonKey(fromJson: _stringFromJson) String? tokenUnitPrice,@JsonKey(fromJson: _stringFromJson) String? deployTechFee
});




}
/// @nodoc
class __$AiModelItemCopyWithImpl<$Res>
    implements _$AiModelItemCopyWith<$Res> {
  __$AiModelItemCopyWithImpl(this._self, this._then);

  final _AiModelItem _self;
  final $Res Function(_AiModelItem) _then;

/// Create a copy of AiModelItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? modelCode = freezed,Object? modelName = freezed,Object? vendorName = freezed,Object? logoUrl = freezed,Object? monthlyTokenConsumptionTrillion = freezed,Object? tokenUnitPrice = freezed,Object? deployTechFee = freezed,}) {
  return _then(_AiModelItem(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,modelCode: freezed == modelCode ? _self.modelCode : modelCode // ignore: cast_nullable_to_non_nullable
as String?,modelName: freezed == modelName ? _self.modelName : modelName // ignore: cast_nullable_to_non_nullable
as String?,vendorName: freezed == vendorName ? _self.vendorName : vendorName // ignore: cast_nullable_to_non_nullable
as String?,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,monthlyTokenConsumptionTrillion: freezed == monthlyTokenConsumptionTrillion ? _self.monthlyTokenConsumptionTrillion : monthlyTokenConsumptionTrillion // ignore: cast_nullable_to_non_nullable
as String?,tokenUnitPrice: freezed == tokenUnitPrice ? _self.tokenUnitPrice : tokenUnitPrice // ignore: cast_nullable_to_non_nullable
as String?,deployTechFee: freezed == deployTechFee ? _self.deployTechFee : deployTechFee // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$RegionItem {

 int? get id; String? get regionCode; String? get regionName;
/// Create a copy of RegionItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegionItemCopyWith<RegionItem> get copyWith => _$RegionItemCopyWithImpl<RegionItem>(this as RegionItem, _$identity);

  /// Serializes this RegionItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegionItem&&(identical(other.id, id) || other.id == id)&&(identical(other.regionCode, regionCode) || other.regionCode == regionCode)&&(identical(other.regionName, regionName) || other.regionName == regionName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,regionCode,regionName);

@override
String toString() {
  return 'RegionItem(id: $id, regionCode: $regionCode, regionName: $regionName)';
}


}

/// @nodoc
abstract mixin class $RegionItemCopyWith<$Res>  {
  factory $RegionItemCopyWith(RegionItem value, $Res Function(RegionItem) _then) = _$RegionItemCopyWithImpl;
@useResult
$Res call({
 int? id, String? regionCode, String? regionName
});




}
/// @nodoc
class _$RegionItemCopyWithImpl<$Res>
    implements $RegionItemCopyWith<$Res> {
  _$RegionItemCopyWithImpl(this._self, this._then);

  final RegionItem _self;
  final $Res Function(RegionItem) _then;

/// Create a copy of RegionItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? regionCode = freezed,Object? regionName = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,regionCode: freezed == regionCode ? _self.regionCode : regionCode // ignore: cast_nullable_to_non_nullable
as String?,regionName: freezed == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RegionItem].
extension RegionItemPatterns on RegionItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegionItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegionItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegionItem value)  $default,){
final _that = this;
switch (_that) {
case _RegionItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegionItem value)?  $default,){
final _that = this;
switch (_that) {
case _RegionItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String? regionCode,  String? regionName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegionItem() when $default != null:
return $default(_that.id,_that.regionCode,_that.regionName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String? regionCode,  String? regionName)  $default,) {final _that = this;
switch (_that) {
case _RegionItem():
return $default(_that.id,_that.regionCode,_that.regionName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String? regionCode,  String? regionName)?  $default,) {final _that = this;
switch (_that) {
case _RegionItem() when $default != null:
return $default(_that.id,_that.regionCode,_that.regionName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegionItem implements RegionItem {
  const _RegionItem({this.id, this.regionCode, this.regionName});
  factory _RegionItem.fromJson(Map<String, dynamic> json) => _$RegionItemFromJson(json);

@override final  int? id;
@override final  String? regionCode;
@override final  String? regionName;

/// Create a copy of RegionItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegionItemCopyWith<_RegionItem> get copyWith => __$RegionItemCopyWithImpl<_RegionItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegionItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegionItem&&(identical(other.id, id) || other.id == id)&&(identical(other.regionCode, regionCode) || other.regionCode == regionCode)&&(identical(other.regionName, regionName) || other.regionName == regionName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,regionCode,regionName);

@override
String toString() {
  return 'RegionItem(id: $id, regionCode: $regionCode, regionName: $regionName)';
}


}

/// @nodoc
abstract mixin class _$RegionItemCopyWith<$Res> implements $RegionItemCopyWith<$Res> {
  factory _$RegionItemCopyWith(_RegionItem value, $Res Function(_RegionItem) _then) = __$RegionItemCopyWithImpl;
@override @useResult
$Res call({
 int? id, String? regionCode, String? regionName
});




}
/// @nodoc
class __$RegionItemCopyWithImpl<$Res>
    implements _$RegionItemCopyWith<$Res> {
  __$RegionItemCopyWithImpl(this._self, this._then);

  final _RegionItem _self;
  final $Res Function(_RegionItem) _then;

/// Create a copy of RegionItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? regionCode = freezed,Object? regionName = freezed,}) {
  return _then(_RegionItem(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,regionCode: freezed == regionCode ? _self.regionCode : regionCode // ignore: cast_nullable_to_non_nullable
as String?,regionName: freezed == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$GpuModelItem {

 int? get id; String? get modelCode; String? get modelName;
/// Create a copy of GpuModelItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GpuModelItemCopyWith<GpuModelItem> get copyWith => _$GpuModelItemCopyWithImpl<GpuModelItem>(this as GpuModelItem, _$identity);

  /// Serializes this GpuModelItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GpuModelItem&&(identical(other.id, id) || other.id == id)&&(identical(other.modelCode, modelCode) || other.modelCode == modelCode)&&(identical(other.modelName, modelName) || other.modelName == modelName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,modelCode,modelName);

@override
String toString() {
  return 'GpuModelItem(id: $id, modelCode: $modelCode, modelName: $modelName)';
}


}

/// @nodoc
abstract mixin class $GpuModelItemCopyWith<$Res>  {
  factory $GpuModelItemCopyWith(GpuModelItem value, $Res Function(GpuModelItem) _then) = _$GpuModelItemCopyWithImpl;
@useResult
$Res call({
 int? id, String? modelCode, String? modelName
});




}
/// @nodoc
class _$GpuModelItemCopyWithImpl<$Res>
    implements $GpuModelItemCopyWith<$Res> {
  _$GpuModelItemCopyWithImpl(this._self, this._then);

  final GpuModelItem _self;
  final $Res Function(GpuModelItem) _then;

/// Create a copy of GpuModelItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? modelCode = freezed,Object? modelName = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,modelCode: freezed == modelCode ? _self.modelCode : modelCode // ignore: cast_nullable_to_non_nullable
as String?,modelName: freezed == modelName ? _self.modelName : modelName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GpuModelItem].
extension GpuModelItemPatterns on GpuModelItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GpuModelItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GpuModelItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GpuModelItem value)  $default,){
final _that = this;
switch (_that) {
case _GpuModelItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GpuModelItem value)?  $default,){
final _that = this;
switch (_that) {
case _GpuModelItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String? modelCode,  String? modelName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GpuModelItem() when $default != null:
return $default(_that.id,_that.modelCode,_that.modelName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String? modelCode,  String? modelName)  $default,) {final _that = this;
switch (_that) {
case _GpuModelItem():
return $default(_that.id,_that.modelCode,_that.modelName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String? modelCode,  String? modelName)?  $default,) {final _that = this;
switch (_that) {
case _GpuModelItem() when $default != null:
return $default(_that.id,_that.modelCode,_that.modelName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GpuModelItem implements GpuModelItem {
  const _GpuModelItem({this.id, this.modelCode, this.modelName});
  factory _GpuModelItem.fromJson(Map<String, dynamic> json) => _$GpuModelItemFromJson(json);

@override final  int? id;
@override final  String? modelCode;
@override final  String? modelName;

/// Create a copy of GpuModelItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GpuModelItemCopyWith<_GpuModelItem> get copyWith => __$GpuModelItemCopyWithImpl<_GpuModelItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GpuModelItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GpuModelItem&&(identical(other.id, id) || other.id == id)&&(identical(other.modelCode, modelCode) || other.modelCode == modelCode)&&(identical(other.modelName, modelName) || other.modelName == modelName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,modelCode,modelName);

@override
String toString() {
  return 'GpuModelItem(id: $id, modelCode: $modelCode, modelName: $modelName)';
}


}

/// @nodoc
abstract mixin class _$GpuModelItemCopyWith<$Res> implements $GpuModelItemCopyWith<$Res> {
  factory _$GpuModelItemCopyWith(_GpuModelItem value, $Res Function(_GpuModelItem) _then) = __$GpuModelItemCopyWithImpl;
@override @useResult
$Res call({
 int? id, String? modelCode, String? modelName
});




}
/// @nodoc
class __$GpuModelItemCopyWithImpl<$Res>
    implements _$GpuModelItemCopyWith<$Res> {
  __$GpuModelItemCopyWithImpl(this._self, this._then);

  final _GpuModelItem _self;
  final $Res Function(_GpuModelItem) _then;

/// Create a copy of GpuModelItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? modelCode = freezed,Object? modelName = freezed,}) {
  return _then(_GpuModelItem(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,modelCode: freezed == modelCode ? _self.modelCode : modelCode // ignore: cast_nullable_to_non_nullable
as String?,modelName: freezed == modelName ? _self.modelName : modelName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CycleRule {

 int? get id; String? get cycleCode; String? get cycleName; int? get cycleDays;@JsonKey(fromJson: _stringFromJson) String? get yieldMultiplier;@JsonKey(fromJson: _stringFromJson) String? get earlyPenaltyRate;
/// Create a copy of CycleRule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CycleRuleCopyWith<CycleRule> get copyWith => _$CycleRuleCopyWithImpl<CycleRule>(this as CycleRule, _$identity);

  /// Serializes this CycleRule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CycleRule&&(identical(other.id, id) || other.id == id)&&(identical(other.cycleCode, cycleCode) || other.cycleCode == cycleCode)&&(identical(other.cycleName, cycleName) || other.cycleName == cycleName)&&(identical(other.cycleDays, cycleDays) || other.cycleDays == cycleDays)&&(identical(other.yieldMultiplier, yieldMultiplier) || other.yieldMultiplier == yieldMultiplier)&&(identical(other.earlyPenaltyRate, earlyPenaltyRate) || other.earlyPenaltyRate == earlyPenaltyRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,cycleCode,cycleName,cycleDays,yieldMultiplier,earlyPenaltyRate);

@override
String toString() {
  return 'CycleRule(id: $id, cycleCode: $cycleCode, cycleName: $cycleName, cycleDays: $cycleDays, yieldMultiplier: $yieldMultiplier, earlyPenaltyRate: $earlyPenaltyRate)';
}


}

/// @nodoc
abstract mixin class $CycleRuleCopyWith<$Res>  {
  factory $CycleRuleCopyWith(CycleRule value, $Res Function(CycleRule) _then) = _$CycleRuleCopyWithImpl;
@useResult
$Res call({
 int? id, String? cycleCode, String? cycleName, int? cycleDays,@JsonKey(fromJson: _stringFromJson) String? yieldMultiplier,@JsonKey(fromJson: _stringFromJson) String? earlyPenaltyRate
});




}
/// @nodoc
class _$CycleRuleCopyWithImpl<$Res>
    implements $CycleRuleCopyWith<$Res> {
  _$CycleRuleCopyWithImpl(this._self, this._then);

  final CycleRule _self;
  final $Res Function(CycleRule) _then;

/// Create a copy of CycleRule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? cycleCode = freezed,Object? cycleName = freezed,Object? cycleDays = freezed,Object? yieldMultiplier = freezed,Object? earlyPenaltyRate = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,cycleCode: freezed == cycleCode ? _self.cycleCode : cycleCode // ignore: cast_nullable_to_non_nullable
as String?,cycleName: freezed == cycleName ? _self.cycleName : cycleName // ignore: cast_nullable_to_non_nullable
as String?,cycleDays: freezed == cycleDays ? _self.cycleDays : cycleDays // ignore: cast_nullable_to_non_nullable
as int?,yieldMultiplier: freezed == yieldMultiplier ? _self.yieldMultiplier : yieldMultiplier // ignore: cast_nullable_to_non_nullable
as String?,earlyPenaltyRate: freezed == earlyPenaltyRate ? _self.earlyPenaltyRate : earlyPenaltyRate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CycleRule].
extension CycleRulePatterns on CycleRule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CycleRule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CycleRule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CycleRule value)  $default,){
final _that = this;
switch (_that) {
case _CycleRule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CycleRule value)?  $default,){
final _that = this;
switch (_that) {
case _CycleRule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String? cycleCode,  String? cycleName,  int? cycleDays, @JsonKey(fromJson: _stringFromJson)  String? yieldMultiplier, @JsonKey(fromJson: _stringFromJson)  String? earlyPenaltyRate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CycleRule() when $default != null:
return $default(_that.id,_that.cycleCode,_that.cycleName,_that.cycleDays,_that.yieldMultiplier,_that.earlyPenaltyRate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String? cycleCode,  String? cycleName,  int? cycleDays, @JsonKey(fromJson: _stringFromJson)  String? yieldMultiplier, @JsonKey(fromJson: _stringFromJson)  String? earlyPenaltyRate)  $default,) {final _that = this;
switch (_that) {
case _CycleRule():
return $default(_that.id,_that.cycleCode,_that.cycleName,_that.cycleDays,_that.yieldMultiplier,_that.earlyPenaltyRate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String? cycleCode,  String? cycleName,  int? cycleDays, @JsonKey(fromJson: _stringFromJson)  String? yieldMultiplier, @JsonKey(fromJson: _stringFromJson)  String? earlyPenaltyRate)?  $default,) {final _that = this;
switch (_that) {
case _CycleRule() when $default != null:
return $default(_that.id,_that.cycleCode,_that.cycleName,_that.cycleDays,_that.yieldMultiplier,_that.earlyPenaltyRate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CycleRule implements CycleRule {
  const _CycleRule({this.id, this.cycleCode, this.cycleName, this.cycleDays, @JsonKey(fromJson: _stringFromJson) this.yieldMultiplier, @JsonKey(fromJson: _stringFromJson) this.earlyPenaltyRate});
  factory _CycleRule.fromJson(Map<String, dynamic> json) => _$CycleRuleFromJson(json);

@override final  int? id;
@override final  String? cycleCode;
@override final  String? cycleName;
@override final  int? cycleDays;
@override@JsonKey(fromJson: _stringFromJson) final  String? yieldMultiplier;
@override@JsonKey(fromJson: _stringFromJson) final  String? earlyPenaltyRate;

/// Create a copy of CycleRule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CycleRuleCopyWith<_CycleRule> get copyWith => __$CycleRuleCopyWithImpl<_CycleRule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CycleRuleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CycleRule&&(identical(other.id, id) || other.id == id)&&(identical(other.cycleCode, cycleCode) || other.cycleCode == cycleCode)&&(identical(other.cycleName, cycleName) || other.cycleName == cycleName)&&(identical(other.cycleDays, cycleDays) || other.cycleDays == cycleDays)&&(identical(other.yieldMultiplier, yieldMultiplier) || other.yieldMultiplier == yieldMultiplier)&&(identical(other.earlyPenaltyRate, earlyPenaltyRate) || other.earlyPenaltyRate == earlyPenaltyRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,cycleCode,cycleName,cycleDays,yieldMultiplier,earlyPenaltyRate);

@override
String toString() {
  return 'CycleRule(id: $id, cycleCode: $cycleCode, cycleName: $cycleName, cycleDays: $cycleDays, yieldMultiplier: $yieldMultiplier, earlyPenaltyRate: $earlyPenaltyRate)';
}


}

/// @nodoc
abstract mixin class _$CycleRuleCopyWith<$Res> implements $CycleRuleCopyWith<$Res> {
  factory _$CycleRuleCopyWith(_CycleRule value, $Res Function(_CycleRule) _then) = __$CycleRuleCopyWithImpl;
@override @useResult
$Res call({
 int? id, String? cycleCode, String? cycleName, int? cycleDays,@JsonKey(fromJson: _stringFromJson) String? yieldMultiplier,@JsonKey(fromJson: _stringFromJson) String? earlyPenaltyRate
});




}
/// @nodoc
class __$CycleRuleCopyWithImpl<$Res>
    implements _$CycleRuleCopyWith<$Res> {
  __$CycleRuleCopyWithImpl(this._self, this._then);

  final _CycleRule _self;
  final $Res Function(_CycleRule) _then;

/// Create a copy of CycleRule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? cycleCode = freezed,Object? cycleName = freezed,Object? cycleDays = freezed,Object? yieldMultiplier = freezed,Object? earlyPenaltyRate = freezed,}) {
  return _then(_CycleRule(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,cycleCode: freezed == cycleCode ? _self.cycleCode : cycleCode // ignore: cast_nullable_to_non_nullable
as String?,cycleName: freezed == cycleName ? _self.cycleName : cycleName // ignore: cast_nullable_to_non_nullable
as String?,cycleDays: freezed == cycleDays ? _self.cycleDays : cycleDays // ignore: cast_nullable_to_non_nullable
as int?,yieldMultiplier: freezed == yieldMultiplier ? _self.yieldMultiplier : yieldMultiplier // ignore: cast_nullable_to_non_nullable
as String?,earlyPenaltyRate: freezed == earlyPenaltyRate ? _self.earlyPenaltyRate : earlyPenaltyRate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$RentalEstimate {

 int? get productId; String? get productName; int? get aiModelId; String? get aiModelName; int? get cycleRuleId; String? get cycleName; int? get cycleDays;@JsonKey(fromJson: _stringFromJson) String? get rentPrice;@JsonKey(fromJson: _stringFromJson) String? get deployTechFee;@JsonKey(fromJson: _stringFromJson) String? get yieldRate;@JsonKey(fromJson: _stringFromJson) String? get tokenOutputPerDay;@JsonKey(fromJson: _stringFromJson) String? get tokenUnitPrice;@JsonKey(fromJson: _stringFromJson) String? get yieldMultiplier;@JsonKey(fromJson: _stringFromJson) String? get expectedDailyProfit;@JsonKey(fromJson: _stringFromJson) String? get expectedTotalProfit;
/// Create a copy of RentalEstimate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RentalEstimateCopyWith<RentalEstimate> get copyWith => _$RentalEstimateCopyWithImpl<RentalEstimate>(this as RentalEstimate, _$identity);

  /// Serializes this RentalEstimate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RentalEstimate&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.aiModelId, aiModelId) || other.aiModelId == aiModelId)&&(identical(other.aiModelName, aiModelName) || other.aiModelName == aiModelName)&&(identical(other.cycleRuleId, cycleRuleId) || other.cycleRuleId == cycleRuleId)&&(identical(other.cycleName, cycleName) || other.cycleName == cycleName)&&(identical(other.cycleDays, cycleDays) || other.cycleDays == cycleDays)&&(identical(other.rentPrice, rentPrice) || other.rentPrice == rentPrice)&&(identical(other.deployTechFee, deployTechFee) || other.deployTechFee == deployTechFee)&&(identical(other.yieldRate, yieldRate) || other.yieldRate == yieldRate)&&(identical(other.tokenOutputPerDay, tokenOutputPerDay) || other.tokenOutputPerDay == tokenOutputPerDay)&&(identical(other.tokenUnitPrice, tokenUnitPrice) || other.tokenUnitPrice == tokenUnitPrice)&&(identical(other.yieldMultiplier, yieldMultiplier) || other.yieldMultiplier == yieldMultiplier)&&(identical(other.expectedDailyProfit, expectedDailyProfit) || other.expectedDailyProfit == expectedDailyProfit)&&(identical(other.expectedTotalProfit, expectedTotalProfit) || other.expectedTotalProfit == expectedTotalProfit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productId,productName,aiModelId,aiModelName,cycleRuleId,cycleName,cycleDays,rentPrice,deployTechFee,yieldRate,tokenOutputPerDay,tokenUnitPrice,yieldMultiplier,expectedDailyProfit,expectedTotalProfit);

@override
String toString() {
  return 'RentalEstimate(productId: $productId, productName: $productName, aiModelId: $aiModelId, aiModelName: $aiModelName, cycleRuleId: $cycleRuleId, cycleName: $cycleName, cycleDays: $cycleDays, rentPrice: $rentPrice, deployTechFee: $deployTechFee, yieldRate: $yieldRate, tokenOutputPerDay: $tokenOutputPerDay, tokenUnitPrice: $tokenUnitPrice, yieldMultiplier: $yieldMultiplier, expectedDailyProfit: $expectedDailyProfit, expectedTotalProfit: $expectedTotalProfit)';
}


}

/// @nodoc
abstract mixin class $RentalEstimateCopyWith<$Res>  {
  factory $RentalEstimateCopyWith(RentalEstimate value, $Res Function(RentalEstimate) _then) = _$RentalEstimateCopyWithImpl;
@useResult
$Res call({
 int? productId, String? productName, int? aiModelId, String? aiModelName, int? cycleRuleId, String? cycleName, int? cycleDays,@JsonKey(fromJson: _stringFromJson) String? rentPrice,@JsonKey(fromJson: _stringFromJson) String? deployTechFee,@JsonKey(fromJson: _stringFromJson) String? yieldRate,@JsonKey(fromJson: _stringFromJson) String? tokenOutputPerDay,@JsonKey(fromJson: _stringFromJson) String? tokenUnitPrice,@JsonKey(fromJson: _stringFromJson) String? yieldMultiplier,@JsonKey(fromJson: _stringFromJson) String? expectedDailyProfit,@JsonKey(fromJson: _stringFromJson) String? expectedTotalProfit
});




}
/// @nodoc
class _$RentalEstimateCopyWithImpl<$Res>
    implements $RentalEstimateCopyWith<$Res> {
  _$RentalEstimateCopyWithImpl(this._self, this._then);

  final RentalEstimate _self;
  final $Res Function(RentalEstimate) _then;

/// Create a copy of RentalEstimate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productId = freezed,Object? productName = freezed,Object? aiModelId = freezed,Object? aiModelName = freezed,Object? cycleRuleId = freezed,Object? cycleName = freezed,Object? cycleDays = freezed,Object? rentPrice = freezed,Object? deployTechFee = freezed,Object? yieldRate = freezed,Object? tokenOutputPerDay = freezed,Object? tokenUnitPrice = freezed,Object? yieldMultiplier = freezed,Object? expectedDailyProfit = freezed,Object? expectedTotalProfit = freezed,}) {
  return _then(_self.copyWith(
productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int?,productName: freezed == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String?,aiModelId: freezed == aiModelId ? _self.aiModelId : aiModelId // ignore: cast_nullable_to_non_nullable
as int?,aiModelName: freezed == aiModelName ? _self.aiModelName : aiModelName // ignore: cast_nullable_to_non_nullable
as String?,cycleRuleId: freezed == cycleRuleId ? _self.cycleRuleId : cycleRuleId // ignore: cast_nullable_to_non_nullable
as int?,cycleName: freezed == cycleName ? _self.cycleName : cycleName // ignore: cast_nullable_to_non_nullable
as String?,cycleDays: freezed == cycleDays ? _self.cycleDays : cycleDays // ignore: cast_nullable_to_non_nullable
as int?,rentPrice: freezed == rentPrice ? _self.rentPrice : rentPrice // ignore: cast_nullable_to_non_nullable
as String?,deployTechFee: freezed == deployTechFee ? _self.deployTechFee : deployTechFee // ignore: cast_nullable_to_non_nullable
as String?,yieldRate: freezed == yieldRate ? _self.yieldRate : yieldRate // ignore: cast_nullable_to_non_nullable
as String?,tokenOutputPerDay: freezed == tokenOutputPerDay ? _self.tokenOutputPerDay : tokenOutputPerDay // ignore: cast_nullable_to_non_nullable
as String?,tokenUnitPrice: freezed == tokenUnitPrice ? _self.tokenUnitPrice : tokenUnitPrice // ignore: cast_nullable_to_non_nullable
as String?,yieldMultiplier: freezed == yieldMultiplier ? _self.yieldMultiplier : yieldMultiplier // ignore: cast_nullable_to_non_nullable
as String?,expectedDailyProfit: freezed == expectedDailyProfit ? _self.expectedDailyProfit : expectedDailyProfit // ignore: cast_nullable_to_non_nullable
as String?,expectedTotalProfit: freezed == expectedTotalProfit ? _self.expectedTotalProfit : expectedTotalProfit // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RentalEstimate].
extension RentalEstimatePatterns on RentalEstimate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RentalEstimate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RentalEstimate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RentalEstimate value)  $default,){
final _that = this;
switch (_that) {
case _RentalEstimate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RentalEstimate value)?  $default,){
final _that = this;
switch (_that) {
case _RentalEstimate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? productId,  String? productName,  int? aiModelId,  String? aiModelName,  int? cycleRuleId,  String? cycleName,  int? cycleDays, @JsonKey(fromJson: _stringFromJson)  String? rentPrice, @JsonKey(fromJson: _stringFromJson)  String? deployTechFee, @JsonKey(fromJson: _stringFromJson)  String? yieldRate, @JsonKey(fromJson: _stringFromJson)  String? tokenOutputPerDay, @JsonKey(fromJson: _stringFromJson)  String? tokenUnitPrice, @JsonKey(fromJson: _stringFromJson)  String? yieldMultiplier, @JsonKey(fromJson: _stringFromJson)  String? expectedDailyProfit, @JsonKey(fromJson: _stringFromJson)  String? expectedTotalProfit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RentalEstimate() when $default != null:
return $default(_that.productId,_that.productName,_that.aiModelId,_that.aiModelName,_that.cycleRuleId,_that.cycleName,_that.cycleDays,_that.rentPrice,_that.deployTechFee,_that.yieldRate,_that.tokenOutputPerDay,_that.tokenUnitPrice,_that.yieldMultiplier,_that.expectedDailyProfit,_that.expectedTotalProfit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? productId,  String? productName,  int? aiModelId,  String? aiModelName,  int? cycleRuleId,  String? cycleName,  int? cycleDays, @JsonKey(fromJson: _stringFromJson)  String? rentPrice, @JsonKey(fromJson: _stringFromJson)  String? deployTechFee, @JsonKey(fromJson: _stringFromJson)  String? yieldRate, @JsonKey(fromJson: _stringFromJson)  String? tokenOutputPerDay, @JsonKey(fromJson: _stringFromJson)  String? tokenUnitPrice, @JsonKey(fromJson: _stringFromJson)  String? yieldMultiplier, @JsonKey(fromJson: _stringFromJson)  String? expectedDailyProfit, @JsonKey(fromJson: _stringFromJson)  String? expectedTotalProfit)  $default,) {final _that = this;
switch (_that) {
case _RentalEstimate():
return $default(_that.productId,_that.productName,_that.aiModelId,_that.aiModelName,_that.cycleRuleId,_that.cycleName,_that.cycleDays,_that.rentPrice,_that.deployTechFee,_that.yieldRate,_that.tokenOutputPerDay,_that.tokenUnitPrice,_that.yieldMultiplier,_that.expectedDailyProfit,_that.expectedTotalProfit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? productId,  String? productName,  int? aiModelId,  String? aiModelName,  int? cycleRuleId,  String? cycleName,  int? cycleDays, @JsonKey(fromJson: _stringFromJson)  String? rentPrice, @JsonKey(fromJson: _stringFromJson)  String? deployTechFee, @JsonKey(fromJson: _stringFromJson)  String? yieldRate, @JsonKey(fromJson: _stringFromJson)  String? tokenOutputPerDay, @JsonKey(fromJson: _stringFromJson)  String? tokenUnitPrice, @JsonKey(fromJson: _stringFromJson)  String? yieldMultiplier, @JsonKey(fromJson: _stringFromJson)  String? expectedDailyProfit, @JsonKey(fromJson: _stringFromJson)  String? expectedTotalProfit)?  $default,) {final _that = this;
switch (_that) {
case _RentalEstimate() when $default != null:
return $default(_that.productId,_that.productName,_that.aiModelId,_that.aiModelName,_that.cycleRuleId,_that.cycleName,_that.cycleDays,_that.rentPrice,_that.deployTechFee,_that.yieldRate,_that.tokenOutputPerDay,_that.tokenUnitPrice,_that.yieldMultiplier,_that.expectedDailyProfit,_that.expectedTotalProfit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RentalEstimate implements RentalEstimate {
  const _RentalEstimate({this.productId, this.productName, this.aiModelId, this.aiModelName, this.cycleRuleId, this.cycleName, this.cycleDays, @JsonKey(fromJson: _stringFromJson) this.rentPrice, @JsonKey(fromJson: _stringFromJson) this.deployTechFee, @JsonKey(fromJson: _stringFromJson) this.yieldRate, @JsonKey(fromJson: _stringFromJson) this.tokenOutputPerDay, @JsonKey(fromJson: _stringFromJson) this.tokenUnitPrice, @JsonKey(fromJson: _stringFromJson) this.yieldMultiplier, @JsonKey(fromJson: _stringFromJson) this.expectedDailyProfit, @JsonKey(fromJson: _stringFromJson) this.expectedTotalProfit});
  factory _RentalEstimate.fromJson(Map<String, dynamic> json) => _$RentalEstimateFromJson(json);

@override final  int? productId;
@override final  String? productName;
@override final  int? aiModelId;
@override final  String? aiModelName;
@override final  int? cycleRuleId;
@override final  String? cycleName;
@override final  int? cycleDays;
@override@JsonKey(fromJson: _stringFromJson) final  String? rentPrice;
@override@JsonKey(fromJson: _stringFromJson) final  String? deployTechFee;
@override@JsonKey(fromJson: _stringFromJson) final  String? yieldRate;
@override@JsonKey(fromJson: _stringFromJson) final  String? tokenOutputPerDay;
@override@JsonKey(fromJson: _stringFromJson) final  String? tokenUnitPrice;
@override@JsonKey(fromJson: _stringFromJson) final  String? yieldMultiplier;
@override@JsonKey(fromJson: _stringFromJson) final  String? expectedDailyProfit;
@override@JsonKey(fromJson: _stringFromJson) final  String? expectedTotalProfit;

/// Create a copy of RentalEstimate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RentalEstimateCopyWith<_RentalEstimate> get copyWith => __$RentalEstimateCopyWithImpl<_RentalEstimate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RentalEstimateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RentalEstimate&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.aiModelId, aiModelId) || other.aiModelId == aiModelId)&&(identical(other.aiModelName, aiModelName) || other.aiModelName == aiModelName)&&(identical(other.cycleRuleId, cycleRuleId) || other.cycleRuleId == cycleRuleId)&&(identical(other.cycleName, cycleName) || other.cycleName == cycleName)&&(identical(other.cycleDays, cycleDays) || other.cycleDays == cycleDays)&&(identical(other.rentPrice, rentPrice) || other.rentPrice == rentPrice)&&(identical(other.deployTechFee, deployTechFee) || other.deployTechFee == deployTechFee)&&(identical(other.yieldRate, yieldRate) || other.yieldRate == yieldRate)&&(identical(other.tokenOutputPerDay, tokenOutputPerDay) || other.tokenOutputPerDay == tokenOutputPerDay)&&(identical(other.tokenUnitPrice, tokenUnitPrice) || other.tokenUnitPrice == tokenUnitPrice)&&(identical(other.yieldMultiplier, yieldMultiplier) || other.yieldMultiplier == yieldMultiplier)&&(identical(other.expectedDailyProfit, expectedDailyProfit) || other.expectedDailyProfit == expectedDailyProfit)&&(identical(other.expectedTotalProfit, expectedTotalProfit) || other.expectedTotalProfit == expectedTotalProfit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productId,productName,aiModelId,aiModelName,cycleRuleId,cycleName,cycleDays,rentPrice,deployTechFee,yieldRate,tokenOutputPerDay,tokenUnitPrice,yieldMultiplier,expectedDailyProfit,expectedTotalProfit);

@override
String toString() {
  return 'RentalEstimate(productId: $productId, productName: $productName, aiModelId: $aiModelId, aiModelName: $aiModelName, cycleRuleId: $cycleRuleId, cycleName: $cycleName, cycleDays: $cycleDays, rentPrice: $rentPrice, deployTechFee: $deployTechFee, yieldRate: $yieldRate, tokenOutputPerDay: $tokenOutputPerDay, tokenUnitPrice: $tokenUnitPrice, yieldMultiplier: $yieldMultiplier, expectedDailyProfit: $expectedDailyProfit, expectedTotalProfit: $expectedTotalProfit)';
}


}

/// @nodoc
abstract mixin class _$RentalEstimateCopyWith<$Res> implements $RentalEstimateCopyWith<$Res> {
  factory _$RentalEstimateCopyWith(_RentalEstimate value, $Res Function(_RentalEstimate) _then) = __$RentalEstimateCopyWithImpl;
@override @useResult
$Res call({
 int? productId, String? productName, int? aiModelId, String? aiModelName, int? cycleRuleId, String? cycleName, int? cycleDays,@JsonKey(fromJson: _stringFromJson) String? rentPrice,@JsonKey(fromJson: _stringFromJson) String? deployTechFee,@JsonKey(fromJson: _stringFromJson) String? yieldRate,@JsonKey(fromJson: _stringFromJson) String? tokenOutputPerDay,@JsonKey(fromJson: _stringFromJson) String? tokenUnitPrice,@JsonKey(fromJson: _stringFromJson) String? yieldMultiplier,@JsonKey(fromJson: _stringFromJson) String? expectedDailyProfit,@JsonKey(fromJson: _stringFromJson) String? expectedTotalProfit
});




}
/// @nodoc
class __$RentalEstimateCopyWithImpl<$Res>
    implements _$RentalEstimateCopyWith<$Res> {
  __$RentalEstimateCopyWithImpl(this._self, this._then);

  final _RentalEstimate _self;
  final $Res Function(_RentalEstimate) _then;

/// Create a copy of RentalEstimate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productId = freezed,Object? productName = freezed,Object? aiModelId = freezed,Object? aiModelName = freezed,Object? cycleRuleId = freezed,Object? cycleName = freezed,Object? cycleDays = freezed,Object? rentPrice = freezed,Object? deployTechFee = freezed,Object? yieldRate = freezed,Object? tokenOutputPerDay = freezed,Object? tokenUnitPrice = freezed,Object? yieldMultiplier = freezed,Object? expectedDailyProfit = freezed,Object? expectedTotalProfit = freezed,}) {
  return _then(_RentalEstimate(
productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int?,productName: freezed == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String?,aiModelId: freezed == aiModelId ? _self.aiModelId : aiModelId // ignore: cast_nullable_to_non_nullable
as int?,aiModelName: freezed == aiModelName ? _self.aiModelName : aiModelName // ignore: cast_nullable_to_non_nullable
as String?,cycleRuleId: freezed == cycleRuleId ? _self.cycleRuleId : cycleRuleId // ignore: cast_nullable_to_non_nullable
as int?,cycleName: freezed == cycleName ? _self.cycleName : cycleName // ignore: cast_nullable_to_non_nullable
as String?,cycleDays: freezed == cycleDays ? _self.cycleDays : cycleDays // ignore: cast_nullable_to_non_nullable
as int?,rentPrice: freezed == rentPrice ? _self.rentPrice : rentPrice // ignore: cast_nullable_to_non_nullable
as String?,deployTechFee: freezed == deployTechFee ? _self.deployTechFee : deployTechFee // ignore: cast_nullable_to_non_nullable
as String?,yieldRate: freezed == yieldRate ? _self.yieldRate : yieldRate // ignore: cast_nullable_to_non_nullable
as String?,tokenOutputPerDay: freezed == tokenOutputPerDay ? _self.tokenOutputPerDay : tokenOutputPerDay // ignore: cast_nullable_to_non_nullable
as String?,tokenUnitPrice: freezed == tokenUnitPrice ? _self.tokenUnitPrice : tokenUnitPrice // ignore: cast_nullable_to_non_nullable
as String?,yieldMultiplier: freezed == yieldMultiplier ? _self.yieldMultiplier : yieldMultiplier // ignore: cast_nullable_to_non_nullable
as String?,expectedDailyProfit: freezed == expectedDailyProfit ? _self.expectedDailyProfit : expectedDailyProfit // ignore: cast_nullable_to_non_nullable
as String?,expectedTotalProfit: freezed == expectedTotalProfit ? _self.expectedTotalProfit : expectedTotalProfit // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$RentalOrder {

 String? get orderNo; String? get productCodeSnapshot; String? get productNameSnapshot; String? get aiModelNameSnapshot; String? get machineCodeSnapshot; String? get machineAliasSnapshot; String? get regionNameSnapshot; String? get gpuModelNameSnapshot; String? get gpuModelSnapshot; int? get cycleDays; int? get cycleDaysSnapshot;@JsonKey(fromJson: _stringFromJson) String? get orderAmount;@JsonKey(fromJson: _stringFromJson) String? get deployFeeSnapshot;@JsonKey(fromJson: _stringFromJson) String? get deployTechFeeSnapshot; String? get currency;@JsonKey(fromJson: _stringFromJson) String? get expectedDailyProfit;@JsonKey(fromJson: _stringFromJson) String? get expectedTotalProfit; String? get orderStatus; String? get profitStatus; String? get settlementStatus; String? get apiStatus; String? get createdAt; String? get paidAt; String? get apiGeneratedAt; String? get deployFeePaidAt; String? get activatedAt; String? get autoPauseAt; String? get pausedAt; String? get startedAt; String? get profitStartAt; String? get profitEndAt; String? get expiredAt; String? get canceledAt; String? get finishedAt; ApiCredential? get apiCredential;
/// Create a copy of RentalOrder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RentalOrderCopyWith<RentalOrder> get copyWith => _$RentalOrderCopyWithImpl<RentalOrder>(this as RentalOrder, _$identity);

  /// Serializes this RentalOrder to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RentalOrder&&(identical(other.orderNo, orderNo) || other.orderNo == orderNo)&&(identical(other.productCodeSnapshot, productCodeSnapshot) || other.productCodeSnapshot == productCodeSnapshot)&&(identical(other.productNameSnapshot, productNameSnapshot) || other.productNameSnapshot == productNameSnapshot)&&(identical(other.aiModelNameSnapshot, aiModelNameSnapshot) || other.aiModelNameSnapshot == aiModelNameSnapshot)&&(identical(other.machineCodeSnapshot, machineCodeSnapshot) || other.machineCodeSnapshot == machineCodeSnapshot)&&(identical(other.machineAliasSnapshot, machineAliasSnapshot) || other.machineAliasSnapshot == machineAliasSnapshot)&&(identical(other.regionNameSnapshot, regionNameSnapshot) || other.regionNameSnapshot == regionNameSnapshot)&&(identical(other.gpuModelNameSnapshot, gpuModelNameSnapshot) || other.gpuModelNameSnapshot == gpuModelNameSnapshot)&&(identical(other.gpuModelSnapshot, gpuModelSnapshot) || other.gpuModelSnapshot == gpuModelSnapshot)&&(identical(other.cycleDays, cycleDays) || other.cycleDays == cycleDays)&&(identical(other.cycleDaysSnapshot, cycleDaysSnapshot) || other.cycleDaysSnapshot == cycleDaysSnapshot)&&(identical(other.orderAmount, orderAmount) || other.orderAmount == orderAmount)&&(identical(other.deployFeeSnapshot, deployFeeSnapshot) || other.deployFeeSnapshot == deployFeeSnapshot)&&(identical(other.deployTechFeeSnapshot, deployTechFeeSnapshot) || other.deployTechFeeSnapshot == deployTechFeeSnapshot)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.expectedDailyProfit, expectedDailyProfit) || other.expectedDailyProfit == expectedDailyProfit)&&(identical(other.expectedTotalProfit, expectedTotalProfit) || other.expectedTotalProfit == expectedTotalProfit)&&(identical(other.orderStatus, orderStatus) || other.orderStatus == orderStatus)&&(identical(other.profitStatus, profitStatus) || other.profitStatus == profitStatus)&&(identical(other.settlementStatus, settlementStatus) || other.settlementStatus == settlementStatus)&&(identical(other.apiStatus, apiStatus) || other.apiStatus == apiStatus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&(identical(other.apiGeneratedAt, apiGeneratedAt) || other.apiGeneratedAt == apiGeneratedAt)&&(identical(other.deployFeePaidAt, deployFeePaidAt) || other.deployFeePaidAt == deployFeePaidAt)&&(identical(other.activatedAt, activatedAt) || other.activatedAt == activatedAt)&&(identical(other.autoPauseAt, autoPauseAt) || other.autoPauseAt == autoPauseAt)&&(identical(other.pausedAt, pausedAt) || other.pausedAt == pausedAt)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.profitStartAt, profitStartAt) || other.profitStartAt == profitStartAt)&&(identical(other.profitEndAt, profitEndAt) || other.profitEndAt == profitEndAt)&&(identical(other.expiredAt, expiredAt) || other.expiredAt == expiredAt)&&(identical(other.canceledAt, canceledAt) || other.canceledAt == canceledAt)&&(identical(other.finishedAt, finishedAt) || other.finishedAt == finishedAt)&&(identical(other.apiCredential, apiCredential) || other.apiCredential == apiCredential));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,orderNo,productCodeSnapshot,productNameSnapshot,aiModelNameSnapshot,machineCodeSnapshot,machineAliasSnapshot,regionNameSnapshot,gpuModelNameSnapshot,gpuModelSnapshot,cycleDays,cycleDaysSnapshot,orderAmount,deployFeeSnapshot,deployTechFeeSnapshot,currency,expectedDailyProfit,expectedTotalProfit,orderStatus,profitStatus,settlementStatus,apiStatus,createdAt,paidAt,apiGeneratedAt,deployFeePaidAt,activatedAt,autoPauseAt,pausedAt,startedAt,profitStartAt,profitEndAt,expiredAt,canceledAt,finishedAt,apiCredential]);

@override
String toString() {
  return 'RentalOrder(orderNo: $orderNo, productCodeSnapshot: $productCodeSnapshot, productNameSnapshot: $productNameSnapshot, aiModelNameSnapshot: $aiModelNameSnapshot, machineCodeSnapshot: $machineCodeSnapshot, machineAliasSnapshot: $machineAliasSnapshot, regionNameSnapshot: $regionNameSnapshot, gpuModelNameSnapshot: $gpuModelNameSnapshot, gpuModelSnapshot: $gpuModelSnapshot, cycleDays: $cycleDays, cycleDaysSnapshot: $cycleDaysSnapshot, orderAmount: $orderAmount, deployFeeSnapshot: $deployFeeSnapshot, deployTechFeeSnapshot: $deployTechFeeSnapshot, currency: $currency, expectedDailyProfit: $expectedDailyProfit, expectedTotalProfit: $expectedTotalProfit, orderStatus: $orderStatus, profitStatus: $profitStatus, settlementStatus: $settlementStatus, apiStatus: $apiStatus, createdAt: $createdAt, paidAt: $paidAt, apiGeneratedAt: $apiGeneratedAt, deployFeePaidAt: $deployFeePaidAt, activatedAt: $activatedAt, autoPauseAt: $autoPauseAt, pausedAt: $pausedAt, startedAt: $startedAt, profitStartAt: $profitStartAt, profitEndAt: $profitEndAt, expiredAt: $expiredAt, canceledAt: $canceledAt, finishedAt: $finishedAt, apiCredential: $apiCredential)';
}


}

/// @nodoc
abstract mixin class $RentalOrderCopyWith<$Res>  {
  factory $RentalOrderCopyWith(RentalOrder value, $Res Function(RentalOrder) _then) = _$RentalOrderCopyWithImpl;
@useResult
$Res call({
 String? orderNo, String? productCodeSnapshot, String? productNameSnapshot, String? aiModelNameSnapshot, String? machineCodeSnapshot, String? machineAliasSnapshot, String? regionNameSnapshot, String? gpuModelNameSnapshot, String? gpuModelSnapshot, int? cycleDays, int? cycleDaysSnapshot,@JsonKey(fromJson: _stringFromJson) String? orderAmount,@JsonKey(fromJson: _stringFromJson) String? deployFeeSnapshot,@JsonKey(fromJson: _stringFromJson) String? deployTechFeeSnapshot, String? currency,@JsonKey(fromJson: _stringFromJson) String? expectedDailyProfit,@JsonKey(fromJson: _stringFromJson) String? expectedTotalProfit, String? orderStatus, String? profitStatus, String? settlementStatus, String? apiStatus, String? createdAt, String? paidAt, String? apiGeneratedAt, String? deployFeePaidAt, String? activatedAt, String? autoPauseAt, String? pausedAt, String? startedAt, String? profitStartAt, String? profitEndAt, String? expiredAt, String? canceledAt, String? finishedAt, ApiCredential? apiCredential
});


$ApiCredentialCopyWith<$Res>? get apiCredential;

}
/// @nodoc
class _$RentalOrderCopyWithImpl<$Res>
    implements $RentalOrderCopyWith<$Res> {
  _$RentalOrderCopyWithImpl(this._self, this._then);

  final RentalOrder _self;
  final $Res Function(RentalOrder) _then;

/// Create a copy of RentalOrder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? orderNo = freezed,Object? productCodeSnapshot = freezed,Object? productNameSnapshot = freezed,Object? aiModelNameSnapshot = freezed,Object? machineCodeSnapshot = freezed,Object? machineAliasSnapshot = freezed,Object? regionNameSnapshot = freezed,Object? gpuModelNameSnapshot = freezed,Object? gpuModelSnapshot = freezed,Object? cycleDays = freezed,Object? cycleDaysSnapshot = freezed,Object? orderAmount = freezed,Object? deployFeeSnapshot = freezed,Object? deployTechFeeSnapshot = freezed,Object? currency = freezed,Object? expectedDailyProfit = freezed,Object? expectedTotalProfit = freezed,Object? orderStatus = freezed,Object? profitStatus = freezed,Object? settlementStatus = freezed,Object? apiStatus = freezed,Object? createdAt = freezed,Object? paidAt = freezed,Object? apiGeneratedAt = freezed,Object? deployFeePaidAt = freezed,Object? activatedAt = freezed,Object? autoPauseAt = freezed,Object? pausedAt = freezed,Object? startedAt = freezed,Object? profitStartAt = freezed,Object? profitEndAt = freezed,Object? expiredAt = freezed,Object? canceledAt = freezed,Object? finishedAt = freezed,Object? apiCredential = freezed,}) {
  return _then(_self.copyWith(
orderNo: freezed == orderNo ? _self.orderNo : orderNo // ignore: cast_nullable_to_non_nullable
as String?,productCodeSnapshot: freezed == productCodeSnapshot ? _self.productCodeSnapshot : productCodeSnapshot // ignore: cast_nullable_to_non_nullable
as String?,productNameSnapshot: freezed == productNameSnapshot ? _self.productNameSnapshot : productNameSnapshot // ignore: cast_nullable_to_non_nullable
as String?,aiModelNameSnapshot: freezed == aiModelNameSnapshot ? _self.aiModelNameSnapshot : aiModelNameSnapshot // ignore: cast_nullable_to_non_nullable
as String?,machineCodeSnapshot: freezed == machineCodeSnapshot ? _self.machineCodeSnapshot : machineCodeSnapshot // ignore: cast_nullable_to_non_nullable
as String?,machineAliasSnapshot: freezed == machineAliasSnapshot ? _self.machineAliasSnapshot : machineAliasSnapshot // ignore: cast_nullable_to_non_nullable
as String?,regionNameSnapshot: freezed == regionNameSnapshot ? _self.regionNameSnapshot : regionNameSnapshot // ignore: cast_nullable_to_non_nullable
as String?,gpuModelNameSnapshot: freezed == gpuModelNameSnapshot ? _self.gpuModelNameSnapshot : gpuModelNameSnapshot // ignore: cast_nullable_to_non_nullable
as String?,gpuModelSnapshot: freezed == gpuModelSnapshot ? _self.gpuModelSnapshot : gpuModelSnapshot // ignore: cast_nullable_to_non_nullable
as String?,cycleDays: freezed == cycleDays ? _self.cycleDays : cycleDays // ignore: cast_nullable_to_non_nullable
as int?,cycleDaysSnapshot: freezed == cycleDaysSnapshot ? _self.cycleDaysSnapshot : cycleDaysSnapshot // ignore: cast_nullable_to_non_nullable
as int?,orderAmount: freezed == orderAmount ? _self.orderAmount : orderAmount // ignore: cast_nullable_to_non_nullable
as String?,deployFeeSnapshot: freezed == deployFeeSnapshot ? _self.deployFeeSnapshot : deployFeeSnapshot // ignore: cast_nullable_to_non_nullable
as String?,deployTechFeeSnapshot: freezed == deployTechFeeSnapshot ? _self.deployTechFeeSnapshot : deployTechFeeSnapshot // ignore: cast_nullable_to_non_nullable
as String?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,expectedDailyProfit: freezed == expectedDailyProfit ? _self.expectedDailyProfit : expectedDailyProfit // ignore: cast_nullable_to_non_nullable
as String?,expectedTotalProfit: freezed == expectedTotalProfit ? _self.expectedTotalProfit : expectedTotalProfit // ignore: cast_nullable_to_non_nullable
as String?,orderStatus: freezed == orderStatus ? _self.orderStatus : orderStatus // ignore: cast_nullable_to_non_nullable
as String?,profitStatus: freezed == profitStatus ? _self.profitStatus : profitStatus // ignore: cast_nullable_to_non_nullable
as String?,settlementStatus: freezed == settlementStatus ? _self.settlementStatus : settlementStatus // ignore: cast_nullable_to_non_nullable
as String?,apiStatus: freezed == apiStatus ? _self.apiStatus : apiStatus // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as String?,apiGeneratedAt: freezed == apiGeneratedAt ? _self.apiGeneratedAt : apiGeneratedAt // ignore: cast_nullable_to_non_nullable
as String?,deployFeePaidAt: freezed == deployFeePaidAt ? _self.deployFeePaidAt : deployFeePaidAt // ignore: cast_nullable_to_non_nullable
as String?,activatedAt: freezed == activatedAt ? _self.activatedAt : activatedAt // ignore: cast_nullable_to_non_nullable
as String?,autoPauseAt: freezed == autoPauseAt ? _self.autoPauseAt : autoPauseAt // ignore: cast_nullable_to_non_nullable
as String?,pausedAt: freezed == pausedAt ? _self.pausedAt : pausedAt // ignore: cast_nullable_to_non_nullable
as String?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as String?,profitStartAt: freezed == profitStartAt ? _self.profitStartAt : profitStartAt // ignore: cast_nullable_to_non_nullable
as String?,profitEndAt: freezed == profitEndAt ? _self.profitEndAt : profitEndAt // ignore: cast_nullable_to_non_nullable
as String?,expiredAt: freezed == expiredAt ? _self.expiredAt : expiredAt // ignore: cast_nullable_to_non_nullable
as String?,canceledAt: freezed == canceledAt ? _self.canceledAt : canceledAt // ignore: cast_nullable_to_non_nullable
as String?,finishedAt: freezed == finishedAt ? _self.finishedAt : finishedAt // ignore: cast_nullable_to_non_nullable
as String?,apiCredential: freezed == apiCredential ? _self.apiCredential : apiCredential // ignore: cast_nullable_to_non_nullable
as ApiCredential?,
  ));
}
/// Create a copy of RentalOrder
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiCredentialCopyWith<$Res>? get apiCredential {
    if (_self.apiCredential == null) {
    return null;
  }

  return $ApiCredentialCopyWith<$Res>(_self.apiCredential!, (value) {
    return _then(_self.copyWith(apiCredential: value));
  });
}
}


/// Adds pattern-matching-related methods to [RentalOrder].
extension RentalOrderPatterns on RentalOrder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RentalOrder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RentalOrder() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RentalOrder value)  $default,){
final _that = this;
switch (_that) {
case _RentalOrder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RentalOrder value)?  $default,){
final _that = this;
switch (_that) {
case _RentalOrder() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? orderNo,  String? productCodeSnapshot,  String? productNameSnapshot,  String? aiModelNameSnapshot,  String? machineCodeSnapshot,  String? machineAliasSnapshot,  String? regionNameSnapshot,  String? gpuModelNameSnapshot,  String? gpuModelSnapshot,  int? cycleDays,  int? cycleDaysSnapshot, @JsonKey(fromJson: _stringFromJson)  String? orderAmount, @JsonKey(fromJson: _stringFromJson)  String? deployFeeSnapshot, @JsonKey(fromJson: _stringFromJson)  String? deployTechFeeSnapshot,  String? currency, @JsonKey(fromJson: _stringFromJson)  String? expectedDailyProfit, @JsonKey(fromJson: _stringFromJson)  String? expectedTotalProfit,  String? orderStatus,  String? profitStatus,  String? settlementStatus,  String? apiStatus,  String? createdAt,  String? paidAt,  String? apiGeneratedAt,  String? deployFeePaidAt,  String? activatedAt,  String? autoPauseAt,  String? pausedAt,  String? startedAt,  String? profitStartAt,  String? profitEndAt,  String? expiredAt,  String? canceledAt,  String? finishedAt,  ApiCredential? apiCredential)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RentalOrder() when $default != null:
return $default(_that.orderNo,_that.productCodeSnapshot,_that.productNameSnapshot,_that.aiModelNameSnapshot,_that.machineCodeSnapshot,_that.machineAliasSnapshot,_that.regionNameSnapshot,_that.gpuModelNameSnapshot,_that.gpuModelSnapshot,_that.cycleDays,_that.cycleDaysSnapshot,_that.orderAmount,_that.deployFeeSnapshot,_that.deployTechFeeSnapshot,_that.currency,_that.expectedDailyProfit,_that.expectedTotalProfit,_that.orderStatus,_that.profitStatus,_that.settlementStatus,_that.apiStatus,_that.createdAt,_that.paidAt,_that.apiGeneratedAt,_that.deployFeePaidAt,_that.activatedAt,_that.autoPauseAt,_that.pausedAt,_that.startedAt,_that.profitStartAt,_that.profitEndAt,_that.expiredAt,_that.canceledAt,_that.finishedAt,_that.apiCredential);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? orderNo,  String? productCodeSnapshot,  String? productNameSnapshot,  String? aiModelNameSnapshot,  String? machineCodeSnapshot,  String? machineAliasSnapshot,  String? regionNameSnapshot,  String? gpuModelNameSnapshot,  String? gpuModelSnapshot,  int? cycleDays,  int? cycleDaysSnapshot, @JsonKey(fromJson: _stringFromJson)  String? orderAmount, @JsonKey(fromJson: _stringFromJson)  String? deployFeeSnapshot, @JsonKey(fromJson: _stringFromJson)  String? deployTechFeeSnapshot,  String? currency, @JsonKey(fromJson: _stringFromJson)  String? expectedDailyProfit, @JsonKey(fromJson: _stringFromJson)  String? expectedTotalProfit,  String? orderStatus,  String? profitStatus,  String? settlementStatus,  String? apiStatus,  String? createdAt,  String? paidAt,  String? apiGeneratedAt,  String? deployFeePaidAt,  String? activatedAt,  String? autoPauseAt,  String? pausedAt,  String? startedAt,  String? profitStartAt,  String? profitEndAt,  String? expiredAt,  String? canceledAt,  String? finishedAt,  ApiCredential? apiCredential)  $default,) {final _that = this;
switch (_that) {
case _RentalOrder():
return $default(_that.orderNo,_that.productCodeSnapshot,_that.productNameSnapshot,_that.aiModelNameSnapshot,_that.machineCodeSnapshot,_that.machineAliasSnapshot,_that.regionNameSnapshot,_that.gpuModelNameSnapshot,_that.gpuModelSnapshot,_that.cycleDays,_that.cycleDaysSnapshot,_that.orderAmount,_that.deployFeeSnapshot,_that.deployTechFeeSnapshot,_that.currency,_that.expectedDailyProfit,_that.expectedTotalProfit,_that.orderStatus,_that.profitStatus,_that.settlementStatus,_that.apiStatus,_that.createdAt,_that.paidAt,_that.apiGeneratedAt,_that.deployFeePaidAt,_that.activatedAt,_that.autoPauseAt,_that.pausedAt,_that.startedAt,_that.profitStartAt,_that.profitEndAt,_that.expiredAt,_that.canceledAt,_that.finishedAt,_that.apiCredential);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? orderNo,  String? productCodeSnapshot,  String? productNameSnapshot,  String? aiModelNameSnapshot,  String? machineCodeSnapshot,  String? machineAliasSnapshot,  String? regionNameSnapshot,  String? gpuModelNameSnapshot,  String? gpuModelSnapshot,  int? cycleDays,  int? cycleDaysSnapshot, @JsonKey(fromJson: _stringFromJson)  String? orderAmount, @JsonKey(fromJson: _stringFromJson)  String? deployFeeSnapshot, @JsonKey(fromJson: _stringFromJson)  String? deployTechFeeSnapshot,  String? currency, @JsonKey(fromJson: _stringFromJson)  String? expectedDailyProfit, @JsonKey(fromJson: _stringFromJson)  String? expectedTotalProfit,  String? orderStatus,  String? profitStatus,  String? settlementStatus,  String? apiStatus,  String? createdAt,  String? paidAt,  String? apiGeneratedAt,  String? deployFeePaidAt,  String? activatedAt,  String? autoPauseAt,  String? pausedAt,  String? startedAt,  String? profitStartAt,  String? profitEndAt,  String? expiredAt,  String? canceledAt,  String? finishedAt,  ApiCredential? apiCredential)?  $default,) {final _that = this;
switch (_that) {
case _RentalOrder() when $default != null:
return $default(_that.orderNo,_that.productCodeSnapshot,_that.productNameSnapshot,_that.aiModelNameSnapshot,_that.machineCodeSnapshot,_that.machineAliasSnapshot,_that.regionNameSnapshot,_that.gpuModelNameSnapshot,_that.gpuModelSnapshot,_that.cycleDays,_that.cycleDaysSnapshot,_that.orderAmount,_that.deployFeeSnapshot,_that.deployTechFeeSnapshot,_that.currency,_that.expectedDailyProfit,_that.expectedTotalProfit,_that.orderStatus,_that.profitStatus,_that.settlementStatus,_that.apiStatus,_that.createdAt,_that.paidAt,_that.apiGeneratedAt,_that.deployFeePaidAt,_that.activatedAt,_that.autoPauseAt,_that.pausedAt,_that.startedAt,_that.profitStartAt,_that.profitEndAt,_that.expiredAt,_that.canceledAt,_that.finishedAt,_that.apiCredential);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RentalOrder implements RentalOrder {
  const _RentalOrder({this.orderNo, this.productCodeSnapshot, this.productNameSnapshot, this.aiModelNameSnapshot, this.machineCodeSnapshot, this.machineAliasSnapshot, this.regionNameSnapshot, this.gpuModelNameSnapshot, this.gpuModelSnapshot, this.cycleDays, this.cycleDaysSnapshot, @JsonKey(fromJson: _stringFromJson) this.orderAmount, @JsonKey(fromJson: _stringFromJson) this.deployFeeSnapshot, @JsonKey(fromJson: _stringFromJson) this.deployTechFeeSnapshot, this.currency, @JsonKey(fromJson: _stringFromJson) this.expectedDailyProfit, @JsonKey(fromJson: _stringFromJson) this.expectedTotalProfit, this.orderStatus, this.profitStatus, this.settlementStatus, this.apiStatus, this.createdAt, this.paidAt, this.apiGeneratedAt, this.deployFeePaidAt, this.activatedAt, this.autoPauseAt, this.pausedAt, this.startedAt, this.profitStartAt, this.profitEndAt, this.expiredAt, this.canceledAt, this.finishedAt, this.apiCredential});
  factory _RentalOrder.fromJson(Map<String, dynamic> json) => _$RentalOrderFromJson(json);

@override final  String? orderNo;
@override final  String? productCodeSnapshot;
@override final  String? productNameSnapshot;
@override final  String? aiModelNameSnapshot;
@override final  String? machineCodeSnapshot;
@override final  String? machineAliasSnapshot;
@override final  String? regionNameSnapshot;
@override final  String? gpuModelNameSnapshot;
@override final  String? gpuModelSnapshot;
@override final  int? cycleDays;
@override final  int? cycleDaysSnapshot;
@override@JsonKey(fromJson: _stringFromJson) final  String? orderAmount;
@override@JsonKey(fromJson: _stringFromJson) final  String? deployFeeSnapshot;
@override@JsonKey(fromJson: _stringFromJson) final  String? deployTechFeeSnapshot;
@override final  String? currency;
@override@JsonKey(fromJson: _stringFromJson) final  String? expectedDailyProfit;
@override@JsonKey(fromJson: _stringFromJson) final  String? expectedTotalProfit;
@override final  String? orderStatus;
@override final  String? profitStatus;
@override final  String? settlementStatus;
@override final  String? apiStatus;
@override final  String? createdAt;
@override final  String? paidAt;
@override final  String? apiGeneratedAt;
@override final  String? deployFeePaidAt;
@override final  String? activatedAt;
@override final  String? autoPauseAt;
@override final  String? pausedAt;
@override final  String? startedAt;
@override final  String? profitStartAt;
@override final  String? profitEndAt;
@override final  String? expiredAt;
@override final  String? canceledAt;
@override final  String? finishedAt;
@override final  ApiCredential? apiCredential;

/// Create a copy of RentalOrder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RentalOrderCopyWith<_RentalOrder> get copyWith => __$RentalOrderCopyWithImpl<_RentalOrder>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RentalOrderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RentalOrder&&(identical(other.orderNo, orderNo) || other.orderNo == orderNo)&&(identical(other.productCodeSnapshot, productCodeSnapshot) || other.productCodeSnapshot == productCodeSnapshot)&&(identical(other.productNameSnapshot, productNameSnapshot) || other.productNameSnapshot == productNameSnapshot)&&(identical(other.aiModelNameSnapshot, aiModelNameSnapshot) || other.aiModelNameSnapshot == aiModelNameSnapshot)&&(identical(other.machineCodeSnapshot, machineCodeSnapshot) || other.machineCodeSnapshot == machineCodeSnapshot)&&(identical(other.machineAliasSnapshot, machineAliasSnapshot) || other.machineAliasSnapshot == machineAliasSnapshot)&&(identical(other.regionNameSnapshot, regionNameSnapshot) || other.regionNameSnapshot == regionNameSnapshot)&&(identical(other.gpuModelNameSnapshot, gpuModelNameSnapshot) || other.gpuModelNameSnapshot == gpuModelNameSnapshot)&&(identical(other.gpuModelSnapshot, gpuModelSnapshot) || other.gpuModelSnapshot == gpuModelSnapshot)&&(identical(other.cycleDays, cycleDays) || other.cycleDays == cycleDays)&&(identical(other.cycleDaysSnapshot, cycleDaysSnapshot) || other.cycleDaysSnapshot == cycleDaysSnapshot)&&(identical(other.orderAmount, orderAmount) || other.orderAmount == orderAmount)&&(identical(other.deployFeeSnapshot, deployFeeSnapshot) || other.deployFeeSnapshot == deployFeeSnapshot)&&(identical(other.deployTechFeeSnapshot, deployTechFeeSnapshot) || other.deployTechFeeSnapshot == deployTechFeeSnapshot)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.expectedDailyProfit, expectedDailyProfit) || other.expectedDailyProfit == expectedDailyProfit)&&(identical(other.expectedTotalProfit, expectedTotalProfit) || other.expectedTotalProfit == expectedTotalProfit)&&(identical(other.orderStatus, orderStatus) || other.orderStatus == orderStatus)&&(identical(other.profitStatus, profitStatus) || other.profitStatus == profitStatus)&&(identical(other.settlementStatus, settlementStatus) || other.settlementStatus == settlementStatus)&&(identical(other.apiStatus, apiStatus) || other.apiStatus == apiStatus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&(identical(other.apiGeneratedAt, apiGeneratedAt) || other.apiGeneratedAt == apiGeneratedAt)&&(identical(other.deployFeePaidAt, deployFeePaidAt) || other.deployFeePaidAt == deployFeePaidAt)&&(identical(other.activatedAt, activatedAt) || other.activatedAt == activatedAt)&&(identical(other.autoPauseAt, autoPauseAt) || other.autoPauseAt == autoPauseAt)&&(identical(other.pausedAt, pausedAt) || other.pausedAt == pausedAt)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.profitStartAt, profitStartAt) || other.profitStartAt == profitStartAt)&&(identical(other.profitEndAt, profitEndAt) || other.profitEndAt == profitEndAt)&&(identical(other.expiredAt, expiredAt) || other.expiredAt == expiredAt)&&(identical(other.canceledAt, canceledAt) || other.canceledAt == canceledAt)&&(identical(other.finishedAt, finishedAt) || other.finishedAt == finishedAt)&&(identical(other.apiCredential, apiCredential) || other.apiCredential == apiCredential));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,orderNo,productCodeSnapshot,productNameSnapshot,aiModelNameSnapshot,machineCodeSnapshot,machineAliasSnapshot,regionNameSnapshot,gpuModelNameSnapshot,gpuModelSnapshot,cycleDays,cycleDaysSnapshot,orderAmount,deployFeeSnapshot,deployTechFeeSnapshot,currency,expectedDailyProfit,expectedTotalProfit,orderStatus,profitStatus,settlementStatus,apiStatus,createdAt,paidAt,apiGeneratedAt,deployFeePaidAt,activatedAt,autoPauseAt,pausedAt,startedAt,profitStartAt,profitEndAt,expiredAt,canceledAt,finishedAt,apiCredential]);

@override
String toString() {
  return 'RentalOrder(orderNo: $orderNo, productCodeSnapshot: $productCodeSnapshot, productNameSnapshot: $productNameSnapshot, aiModelNameSnapshot: $aiModelNameSnapshot, machineCodeSnapshot: $machineCodeSnapshot, machineAliasSnapshot: $machineAliasSnapshot, regionNameSnapshot: $regionNameSnapshot, gpuModelNameSnapshot: $gpuModelNameSnapshot, gpuModelSnapshot: $gpuModelSnapshot, cycleDays: $cycleDays, cycleDaysSnapshot: $cycleDaysSnapshot, orderAmount: $orderAmount, deployFeeSnapshot: $deployFeeSnapshot, deployTechFeeSnapshot: $deployTechFeeSnapshot, currency: $currency, expectedDailyProfit: $expectedDailyProfit, expectedTotalProfit: $expectedTotalProfit, orderStatus: $orderStatus, profitStatus: $profitStatus, settlementStatus: $settlementStatus, apiStatus: $apiStatus, createdAt: $createdAt, paidAt: $paidAt, apiGeneratedAt: $apiGeneratedAt, deployFeePaidAt: $deployFeePaidAt, activatedAt: $activatedAt, autoPauseAt: $autoPauseAt, pausedAt: $pausedAt, startedAt: $startedAt, profitStartAt: $profitStartAt, profitEndAt: $profitEndAt, expiredAt: $expiredAt, canceledAt: $canceledAt, finishedAt: $finishedAt, apiCredential: $apiCredential)';
}


}

/// @nodoc
abstract mixin class _$RentalOrderCopyWith<$Res> implements $RentalOrderCopyWith<$Res> {
  factory _$RentalOrderCopyWith(_RentalOrder value, $Res Function(_RentalOrder) _then) = __$RentalOrderCopyWithImpl;
@override @useResult
$Res call({
 String? orderNo, String? productCodeSnapshot, String? productNameSnapshot, String? aiModelNameSnapshot, String? machineCodeSnapshot, String? machineAliasSnapshot, String? regionNameSnapshot, String? gpuModelNameSnapshot, String? gpuModelSnapshot, int? cycleDays, int? cycleDaysSnapshot,@JsonKey(fromJson: _stringFromJson) String? orderAmount,@JsonKey(fromJson: _stringFromJson) String? deployFeeSnapshot,@JsonKey(fromJson: _stringFromJson) String? deployTechFeeSnapshot, String? currency,@JsonKey(fromJson: _stringFromJson) String? expectedDailyProfit,@JsonKey(fromJson: _stringFromJson) String? expectedTotalProfit, String? orderStatus, String? profitStatus, String? settlementStatus, String? apiStatus, String? createdAt, String? paidAt, String? apiGeneratedAt, String? deployFeePaidAt, String? activatedAt, String? autoPauseAt, String? pausedAt, String? startedAt, String? profitStartAt, String? profitEndAt, String? expiredAt, String? canceledAt, String? finishedAt, ApiCredential? apiCredential
});


@override $ApiCredentialCopyWith<$Res>? get apiCredential;

}
/// @nodoc
class __$RentalOrderCopyWithImpl<$Res>
    implements _$RentalOrderCopyWith<$Res> {
  __$RentalOrderCopyWithImpl(this._self, this._then);

  final _RentalOrder _self;
  final $Res Function(_RentalOrder) _then;

/// Create a copy of RentalOrder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orderNo = freezed,Object? productCodeSnapshot = freezed,Object? productNameSnapshot = freezed,Object? aiModelNameSnapshot = freezed,Object? machineCodeSnapshot = freezed,Object? machineAliasSnapshot = freezed,Object? regionNameSnapshot = freezed,Object? gpuModelNameSnapshot = freezed,Object? gpuModelSnapshot = freezed,Object? cycleDays = freezed,Object? cycleDaysSnapshot = freezed,Object? orderAmount = freezed,Object? deployFeeSnapshot = freezed,Object? deployTechFeeSnapshot = freezed,Object? currency = freezed,Object? expectedDailyProfit = freezed,Object? expectedTotalProfit = freezed,Object? orderStatus = freezed,Object? profitStatus = freezed,Object? settlementStatus = freezed,Object? apiStatus = freezed,Object? createdAt = freezed,Object? paidAt = freezed,Object? apiGeneratedAt = freezed,Object? deployFeePaidAt = freezed,Object? activatedAt = freezed,Object? autoPauseAt = freezed,Object? pausedAt = freezed,Object? startedAt = freezed,Object? profitStartAt = freezed,Object? profitEndAt = freezed,Object? expiredAt = freezed,Object? canceledAt = freezed,Object? finishedAt = freezed,Object? apiCredential = freezed,}) {
  return _then(_RentalOrder(
orderNo: freezed == orderNo ? _self.orderNo : orderNo // ignore: cast_nullable_to_non_nullable
as String?,productCodeSnapshot: freezed == productCodeSnapshot ? _self.productCodeSnapshot : productCodeSnapshot // ignore: cast_nullable_to_non_nullable
as String?,productNameSnapshot: freezed == productNameSnapshot ? _self.productNameSnapshot : productNameSnapshot // ignore: cast_nullable_to_non_nullable
as String?,aiModelNameSnapshot: freezed == aiModelNameSnapshot ? _self.aiModelNameSnapshot : aiModelNameSnapshot // ignore: cast_nullable_to_non_nullable
as String?,machineCodeSnapshot: freezed == machineCodeSnapshot ? _self.machineCodeSnapshot : machineCodeSnapshot // ignore: cast_nullable_to_non_nullable
as String?,machineAliasSnapshot: freezed == machineAliasSnapshot ? _self.machineAliasSnapshot : machineAliasSnapshot // ignore: cast_nullable_to_non_nullable
as String?,regionNameSnapshot: freezed == regionNameSnapshot ? _self.regionNameSnapshot : regionNameSnapshot // ignore: cast_nullable_to_non_nullable
as String?,gpuModelNameSnapshot: freezed == gpuModelNameSnapshot ? _self.gpuModelNameSnapshot : gpuModelNameSnapshot // ignore: cast_nullable_to_non_nullable
as String?,gpuModelSnapshot: freezed == gpuModelSnapshot ? _self.gpuModelSnapshot : gpuModelSnapshot // ignore: cast_nullable_to_non_nullable
as String?,cycleDays: freezed == cycleDays ? _self.cycleDays : cycleDays // ignore: cast_nullable_to_non_nullable
as int?,cycleDaysSnapshot: freezed == cycleDaysSnapshot ? _self.cycleDaysSnapshot : cycleDaysSnapshot // ignore: cast_nullable_to_non_nullable
as int?,orderAmount: freezed == orderAmount ? _self.orderAmount : orderAmount // ignore: cast_nullable_to_non_nullable
as String?,deployFeeSnapshot: freezed == deployFeeSnapshot ? _self.deployFeeSnapshot : deployFeeSnapshot // ignore: cast_nullable_to_non_nullable
as String?,deployTechFeeSnapshot: freezed == deployTechFeeSnapshot ? _self.deployTechFeeSnapshot : deployTechFeeSnapshot // ignore: cast_nullable_to_non_nullable
as String?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,expectedDailyProfit: freezed == expectedDailyProfit ? _self.expectedDailyProfit : expectedDailyProfit // ignore: cast_nullable_to_non_nullable
as String?,expectedTotalProfit: freezed == expectedTotalProfit ? _self.expectedTotalProfit : expectedTotalProfit // ignore: cast_nullable_to_non_nullable
as String?,orderStatus: freezed == orderStatus ? _self.orderStatus : orderStatus // ignore: cast_nullable_to_non_nullable
as String?,profitStatus: freezed == profitStatus ? _self.profitStatus : profitStatus // ignore: cast_nullable_to_non_nullable
as String?,settlementStatus: freezed == settlementStatus ? _self.settlementStatus : settlementStatus // ignore: cast_nullable_to_non_nullable
as String?,apiStatus: freezed == apiStatus ? _self.apiStatus : apiStatus // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as String?,apiGeneratedAt: freezed == apiGeneratedAt ? _self.apiGeneratedAt : apiGeneratedAt // ignore: cast_nullable_to_non_nullable
as String?,deployFeePaidAt: freezed == deployFeePaidAt ? _self.deployFeePaidAt : deployFeePaidAt // ignore: cast_nullable_to_non_nullable
as String?,activatedAt: freezed == activatedAt ? _self.activatedAt : activatedAt // ignore: cast_nullable_to_non_nullable
as String?,autoPauseAt: freezed == autoPauseAt ? _self.autoPauseAt : autoPauseAt // ignore: cast_nullable_to_non_nullable
as String?,pausedAt: freezed == pausedAt ? _self.pausedAt : pausedAt // ignore: cast_nullable_to_non_nullable
as String?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as String?,profitStartAt: freezed == profitStartAt ? _self.profitStartAt : profitStartAt // ignore: cast_nullable_to_non_nullable
as String?,profitEndAt: freezed == profitEndAt ? _self.profitEndAt : profitEndAt // ignore: cast_nullable_to_non_nullable
as String?,expiredAt: freezed == expiredAt ? _self.expiredAt : expiredAt // ignore: cast_nullable_to_non_nullable
as String?,canceledAt: freezed == canceledAt ? _self.canceledAt : canceledAt // ignore: cast_nullable_to_non_nullable
as String?,finishedAt: freezed == finishedAt ? _self.finishedAt : finishedAt // ignore: cast_nullable_to_non_nullable
as String?,apiCredential: freezed == apiCredential ? _self.apiCredential : apiCredential // ignore: cast_nullable_to_non_nullable
as ApiCredential?,
  ));
}

/// Create a copy of RentalOrder
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiCredentialCopyWith<$Res>? get apiCredential {
    if (_self.apiCredential == null) {
    return null;
  }

  return $ApiCredentialCopyWith<$Res>(_self.apiCredential!, (value) {
    return _then(_self.copyWith(apiCredential: value));
  });
}
}


/// @nodoc
mixin _$ApiCredential {

 String? get apiName; String? get apiBaseUrl; String? get tokenMasked; String? get modelNameSnapshot; String? get tokenStatus;@JsonKey(fromJson: _stringFromJson) String? get deployFeeSnapshot; String? get generatedAt; String? get activationPaidAt; String? get activatedAt; String? get autoPauseAt; String? get pausedAt; String? get startedAt; String? get expiredAt;
/// Create a copy of ApiCredential
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiCredentialCopyWith<ApiCredential> get copyWith => _$ApiCredentialCopyWithImpl<ApiCredential>(this as ApiCredential, _$identity);

  /// Serializes this ApiCredential to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiCredential&&(identical(other.apiName, apiName) || other.apiName == apiName)&&(identical(other.apiBaseUrl, apiBaseUrl) || other.apiBaseUrl == apiBaseUrl)&&(identical(other.tokenMasked, tokenMasked) || other.tokenMasked == tokenMasked)&&(identical(other.modelNameSnapshot, modelNameSnapshot) || other.modelNameSnapshot == modelNameSnapshot)&&(identical(other.tokenStatus, tokenStatus) || other.tokenStatus == tokenStatus)&&(identical(other.deployFeeSnapshot, deployFeeSnapshot) || other.deployFeeSnapshot == deployFeeSnapshot)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.activationPaidAt, activationPaidAt) || other.activationPaidAt == activationPaidAt)&&(identical(other.activatedAt, activatedAt) || other.activatedAt == activatedAt)&&(identical(other.autoPauseAt, autoPauseAt) || other.autoPauseAt == autoPauseAt)&&(identical(other.pausedAt, pausedAt) || other.pausedAt == pausedAt)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.expiredAt, expiredAt) || other.expiredAt == expiredAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,apiName,apiBaseUrl,tokenMasked,modelNameSnapshot,tokenStatus,deployFeeSnapshot,generatedAt,activationPaidAt,activatedAt,autoPauseAt,pausedAt,startedAt,expiredAt);

@override
String toString() {
  return 'ApiCredential(apiName: $apiName, apiBaseUrl: $apiBaseUrl, tokenMasked: $tokenMasked, modelNameSnapshot: $modelNameSnapshot, tokenStatus: $tokenStatus, deployFeeSnapshot: $deployFeeSnapshot, generatedAt: $generatedAt, activationPaidAt: $activationPaidAt, activatedAt: $activatedAt, autoPauseAt: $autoPauseAt, pausedAt: $pausedAt, startedAt: $startedAt, expiredAt: $expiredAt)';
}


}

/// @nodoc
abstract mixin class $ApiCredentialCopyWith<$Res>  {
  factory $ApiCredentialCopyWith(ApiCredential value, $Res Function(ApiCredential) _then) = _$ApiCredentialCopyWithImpl;
@useResult
$Res call({
 String? apiName, String? apiBaseUrl, String? tokenMasked, String? modelNameSnapshot, String? tokenStatus,@JsonKey(fromJson: _stringFromJson) String? deployFeeSnapshot, String? generatedAt, String? activationPaidAt, String? activatedAt, String? autoPauseAt, String? pausedAt, String? startedAt, String? expiredAt
});




}
/// @nodoc
class _$ApiCredentialCopyWithImpl<$Res>
    implements $ApiCredentialCopyWith<$Res> {
  _$ApiCredentialCopyWithImpl(this._self, this._then);

  final ApiCredential _self;
  final $Res Function(ApiCredential) _then;

/// Create a copy of ApiCredential
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? apiName = freezed,Object? apiBaseUrl = freezed,Object? tokenMasked = freezed,Object? modelNameSnapshot = freezed,Object? tokenStatus = freezed,Object? deployFeeSnapshot = freezed,Object? generatedAt = freezed,Object? activationPaidAt = freezed,Object? activatedAt = freezed,Object? autoPauseAt = freezed,Object? pausedAt = freezed,Object? startedAt = freezed,Object? expiredAt = freezed,}) {
  return _then(_self.copyWith(
apiName: freezed == apiName ? _self.apiName : apiName // ignore: cast_nullable_to_non_nullable
as String?,apiBaseUrl: freezed == apiBaseUrl ? _self.apiBaseUrl : apiBaseUrl // ignore: cast_nullable_to_non_nullable
as String?,tokenMasked: freezed == tokenMasked ? _self.tokenMasked : tokenMasked // ignore: cast_nullable_to_non_nullable
as String?,modelNameSnapshot: freezed == modelNameSnapshot ? _self.modelNameSnapshot : modelNameSnapshot // ignore: cast_nullable_to_non_nullable
as String?,tokenStatus: freezed == tokenStatus ? _self.tokenStatus : tokenStatus // ignore: cast_nullable_to_non_nullable
as String?,deployFeeSnapshot: freezed == deployFeeSnapshot ? _self.deployFeeSnapshot : deployFeeSnapshot // ignore: cast_nullable_to_non_nullable
as String?,generatedAt: freezed == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as String?,activationPaidAt: freezed == activationPaidAt ? _self.activationPaidAt : activationPaidAt // ignore: cast_nullable_to_non_nullable
as String?,activatedAt: freezed == activatedAt ? _self.activatedAt : activatedAt // ignore: cast_nullable_to_non_nullable
as String?,autoPauseAt: freezed == autoPauseAt ? _self.autoPauseAt : autoPauseAt // ignore: cast_nullable_to_non_nullable
as String?,pausedAt: freezed == pausedAt ? _self.pausedAt : pausedAt // ignore: cast_nullable_to_non_nullable
as String?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as String?,expiredAt: freezed == expiredAt ? _self.expiredAt : expiredAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ApiCredential].
extension ApiCredentialPatterns on ApiCredential {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApiCredential value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApiCredential() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApiCredential value)  $default,){
final _that = this;
switch (_that) {
case _ApiCredential():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApiCredential value)?  $default,){
final _that = this;
switch (_that) {
case _ApiCredential() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? apiName,  String? apiBaseUrl,  String? tokenMasked,  String? modelNameSnapshot,  String? tokenStatus, @JsonKey(fromJson: _stringFromJson)  String? deployFeeSnapshot,  String? generatedAt,  String? activationPaidAt,  String? activatedAt,  String? autoPauseAt,  String? pausedAt,  String? startedAt,  String? expiredAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApiCredential() when $default != null:
return $default(_that.apiName,_that.apiBaseUrl,_that.tokenMasked,_that.modelNameSnapshot,_that.tokenStatus,_that.deployFeeSnapshot,_that.generatedAt,_that.activationPaidAt,_that.activatedAt,_that.autoPauseAt,_that.pausedAt,_that.startedAt,_that.expiredAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? apiName,  String? apiBaseUrl,  String? tokenMasked,  String? modelNameSnapshot,  String? tokenStatus, @JsonKey(fromJson: _stringFromJson)  String? deployFeeSnapshot,  String? generatedAt,  String? activationPaidAt,  String? activatedAt,  String? autoPauseAt,  String? pausedAt,  String? startedAt,  String? expiredAt)  $default,) {final _that = this;
switch (_that) {
case _ApiCredential():
return $default(_that.apiName,_that.apiBaseUrl,_that.tokenMasked,_that.modelNameSnapshot,_that.tokenStatus,_that.deployFeeSnapshot,_that.generatedAt,_that.activationPaidAt,_that.activatedAt,_that.autoPauseAt,_that.pausedAt,_that.startedAt,_that.expiredAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? apiName,  String? apiBaseUrl,  String? tokenMasked,  String? modelNameSnapshot,  String? tokenStatus, @JsonKey(fromJson: _stringFromJson)  String? deployFeeSnapshot,  String? generatedAt,  String? activationPaidAt,  String? activatedAt,  String? autoPauseAt,  String? pausedAt,  String? startedAt,  String? expiredAt)?  $default,) {final _that = this;
switch (_that) {
case _ApiCredential() when $default != null:
return $default(_that.apiName,_that.apiBaseUrl,_that.tokenMasked,_that.modelNameSnapshot,_that.tokenStatus,_that.deployFeeSnapshot,_that.generatedAt,_that.activationPaidAt,_that.activatedAt,_that.autoPauseAt,_that.pausedAt,_that.startedAt,_that.expiredAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApiCredential implements ApiCredential {
  const _ApiCredential({this.apiName, this.apiBaseUrl, this.tokenMasked, this.modelNameSnapshot, this.tokenStatus, @JsonKey(fromJson: _stringFromJson) this.deployFeeSnapshot, this.generatedAt, this.activationPaidAt, this.activatedAt, this.autoPauseAt, this.pausedAt, this.startedAt, this.expiredAt});
  factory _ApiCredential.fromJson(Map<String, dynamic> json) => _$ApiCredentialFromJson(json);

@override final  String? apiName;
@override final  String? apiBaseUrl;
@override final  String? tokenMasked;
@override final  String? modelNameSnapshot;
@override final  String? tokenStatus;
@override@JsonKey(fromJson: _stringFromJson) final  String? deployFeeSnapshot;
@override final  String? generatedAt;
@override final  String? activationPaidAt;
@override final  String? activatedAt;
@override final  String? autoPauseAt;
@override final  String? pausedAt;
@override final  String? startedAt;
@override final  String? expiredAt;

/// Create a copy of ApiCredential
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApiCredentialCopyWith<_ApiCredential> get copyWith => __$ApiCredentialCopyWithImpl<_ApiCredential>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApiCredentialToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApiCredential&&(identical(other.apiName, apiName) || other.apiName == apiName)&&(identical(other.apiBaseUrl, apiBaseUrl) || other.apiBaseUrl == apiBaseUrl)&&(identical(other.tokenMasked, tokenMasked) || other.tokenMasked == tokenMasked)&&(identical(other.modelNameSnapshot, modelNameSnapshot) || other.modelNameSnapshot == modelNameSnapshot)&&(identical(other.tokenStatus, tokenStatus) || other.tokenStatus == tokenStatus)&&(identical(other.deployFeeSnapshot, deployFeeSnapshot) || other.deployFeeSnapshot == deployFeeSnapshot)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.activationPaidAt, activationPaidAt) || other.activationPaidAt == activationPaidAt)&&(identical(other.activatedAt, activatedAt) || other.activatedAt == activatedAt)&&(identical(other.autoPauseAt, autoPauseAt) || other.autoPauseAt == autoPauseAt)&&(identical(other.pausedAt, pausedAt) || other.pausedAt == pausedAt)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.expiredAt, expiredAt) || other.expiredAt == expiredAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,apiName,apiBaseUrl,tokenMasked,modelNameSnapshot,tokenStatus,deployFeeSnapshot,generatedAt,activationPaidAt,activatedAt,autoPauseAt,pausedAt,startedAt,expiredAt);

@override
String toString() {
  return 'ApiCredential(apiName: $apiName, apiBaseUrl: $apiBaseUrl, tokenMasked: $tokenMasked, modelNameSnapshot: $modelNameSnapshot, tokenStatus: $tokenStatus, deployFeeSnapshot: $deployFeeSnapshot, generatedAt: $generatedAt, activationPaidAt: $activationPaidAt, activatedAt: $activatedAt, autoPauseAt: $autoPauseAt, pausedAt: $pausedAt, startedAt: $startedAt, expiredAt: $expiredAt)';
}


}

/// @nodoc
abstract mixin class _$ApiCredentialCopyWith<$Res> implements $ApiCredentialCopyWith<$Res> {
  factory _$ApiCredentialCopyWith(_ApiCredential value, $Res Function(_ApiCredential) _then) = __$ApiCredentialCopyWithImpl;
@override @useResult
$Res call({
 String? apiName, String? apiBaseUrl, String? tokenMasked, String? modelNameSnapshot, String? tokenStatus,@JsonKey(fromJson: _stringFromJson) String? deployFeeSnapshot, String? generatedAt, String? activationPaidAt, String? activatedAt, String? autoPauseAt, String? pausedAt, String? startedAt, String? expiredAt
});




}
/// @nodoc
class __$ApiCredentialCopyWithImpl<$Res>
    implements _$ApiCredentialCopyWith<$Res> {
  __$ApiCredentialCopyWithImpl(this._self, this._then);

  final _ApiCredential _self;
  final $Res Function(_ApiCredential) _then;

/// Create a copy of ApiCredential
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? apiName = freezed,Object? apiBaseUrl = freezed,Object? tokenMasked = freezed,Object? modelNameSnapshot = freezed,Object? tokenStatus = freezed,Object? deployFeeSnapshot = freezed,Object? generatedAt = freezed,Object? activationPaidAt = freezed,Object? activatedAt = freezed,Object? autoPauseAt = freezed,Object? pausedAt = freezed,Object? startedAt = freezed,Object? expiredAt = freezed,}) {
  return _then(_ApiCredential(
apiName: freezed == apiName ? _self.apiName : apiName // ignore: cast_nullable_to_non_nullable
as String?,apiBaseUrl: freezed == apiBaseUrl ? _self.apiBaseUrl : apiBaseUrl // ignore: cast_nullable_to_non_nullable
as String?,tokenMasked: freezed == tokenMasked ? _self.tokenMasked : tokenMasked // ignore: cast_nullable_to_non_nullable
as String?,modelNameSnapshot: freezed == modelNameSnapshot ? _self.modelNameSnapshot : modelNameSnapshot // ignore: cast_nullable_to_non_nullable
as String?,tokenStatus: freezed == tokenStatus ? _self.tokenStatus : tokenStatus // ignore: cast_nullable_to_non_nullable
as String?,deployFeeSnapshot: freezed == deployFeeSnapshot ? _self.deployFeeSnapshot : deployFeeSnapshot // ignore: cast_nullable_to_non_nullable
as String?,generatedAt: freezed == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as String?,activationPaidAt: freezed == activationPaidAt ? _self.activationPaidAt : activationPaidAt // ignore: cast_nullable_to_non_nullable
as String?,activatedAt: freezed == activatedAt ? _self.activatedAt : activatedAt // ignore: cast_nullable_to_non_nullable
as String?,autoPauseAt: freezed == autoPauseAt ? _self.autoPauseAt : autoPauseAt // ignore: cast_nullable_to_non_nullable
as String?,pausedAt: freezed == pausedAt ? _self.pausedAt : pausedAt // ignore: cast_nullable_to_non_nullable
as String?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as String?,expiredAt: freezed == expiredAt ? _self.expiredAt : expiredAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$DeployInfo {

 String? get orderNo; String? get orderStatus; String? get tokenStatus; String? get modelNameSnapshot;@JsonKey(fromJson: _stringFromJson) String? get deployFeeSnapshot; String? get apiName; String? get apiBaseUrl; String? get tokenMasked; String? get deployOrderStatus; String? get paidAt; String? get apiStage; String? get profitStartAt; String? get profitEndAt; String? get autoPauseAt; String? get nextStopAt; String? get nextStopReason; String? get pausedAt; String? get startedAt; String? get expiredAt; String? get finishedAt; String? get settlementStatus; String? get profitStatus; int? get cycleDaysSnapshot;
/// Create a copy of DeployInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeployInfoCopyWith<DeployInfo> get copyWith => _$DeployInfoCopyWithImpl<DeployInfo>(this as DeployInfo, _$identity);

  /// Serializes this DeployInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeployInfo&&(identical(other.orderNo, orderNo) || other.orderNo == orderNo)&&(identical(other.orderStatus, orderStatus) || other.orderStatus == orderStatus)&&(identical(other.tokenStatus, tokenStatus) || other.tokenStatus == tokenStatus)&&(identical(other.modelNameSnapshot, modelNameSnapshot) || other.modelNameSnapshot == modelNameSnapshot)&&(identical(other.deployFeeSnapshot, deployFeeSnapshot) || other.deployFeeSnapshot == deployFeeSnapshot)&&(identical(other.apiName, apiName) || other.apiName == apiName)&&(identical(other.apiBaseUrl, apiBaseUrl) || other.apiBaseUrl == apiBaseUrl)&&(identical(other.tokenMasked, tokenMasked) || other.tokenMasked == tokenMasked)&&(identical(other.deployOrderStatus, deployOrderStatus) || other.deployOrderStatus == deployOrderStatus)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&(identical(other.apiStage, apiStage) || other.apiStage == apiStage)&&(identical(other.profitStartAt, profitStartAt) || other.profitStartAt == profitStartAt)&&(identical(other.profitEndAt, profitEndAt) || other.profitEndAt == profitEndAt)&&(identical(other.autoPauseAt, autoPauseAt) || other.autoPauseAt == autoPauseAt)&&(identical(other.nextStopAt, nextStopAt) || other.nextStopAt == nextStopAt)&&(identical(other.nextStopReason, nextStopReason) || other.nextStopReason == nextStopReason)&&(identical(other.pausedAt, pausedAt) || other.pausedAt == pausedAt)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.expiredAt, expiredAt) || other.expiredAt == expiredAt)&&(identical(other.finishedAt, finishedAt) || other.finishedAt == finishedAt)&&(identical(other.settlementStatus, settlementStatus) || other.settlementStatus == settlementStatus)&&(identical(other.profitStatus, profitStatus) || other.profitStatus == profitStatus)&&(identical(other.cycleDaysSnapshot, cycleDaysSnapshot) || other.cycleDaysSnapshot == cycleDaysSnapshot));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,orderNo,orderStatus,tokenStatus,modelNameSnapshot,deployFeeSnapshot,apiName,apiBaseUrl,tokenMasked,deployOrderStatus,paidAt,apiStage,profitStartAt,profitEndAt,autoPauseAt,nextStopAt,nextStopReason,pausedAt,startedAt,expiredAt,finishedAt,settlementStatus,profitStatus,cycleDaysSnapshot]);

@override
String toString() {
  return 'DeployInfo(orderNo: $orderNo, orderStatus: $orderStatus, tokenStatus: $tokenStatus, modelNameSnapshot: $modelNameSnapshot, deployFeeSnapshot: $deployFeeSnapshot, apiName: $apiName, apiBaseUrl: $apiBaseUrl, tokenMasked: $tokenMasked, deployOrderStatus: $deployOrderStatus, paidAt: $paidAt, apiStage: $apiStage, profitStartAt: $profitStartAt, profitEndAt: $profitEndAt, autoPauseAt: $autoPauseAt, nextStopAt: $nextStopAt, nextStopReason: $nextStopReason, pausedAt: $pausedAt, startedAt: $startedAt, expiredAt: $expiredAt, finishedAt: $finishedAt, settlementStatus: $settlementStatus, profitStatus: $profitStatus, cycleDaysSnapshot: $cycleDaysSnapshot)';
}


}

/// @nodoc
abstract mixin class $DeployInfoCopyWith<$Res>  {
  factory $DeployInfoCopyWith(DeployInfo value, $Res Function(DeployInfo) _then) = _$DeployInfoCopyWithImpl;
@useResult
$Res call({
 String? orderNo, String? orderStatus, String? tokenStatus, String? modelNameSnapshot,@JsonKey(fromJson: _stringFromJson) String? deployFeeSnapshot, String? apiName, String? apiBaseUrl, String? tokenMasked, String? deployOrderStatus, String? paidAt, String? apiStage, String? profitStartAt, String? profitEndAt, String? autoPauseAt, String? nextStopAt, String? nextStopReason, String? pausedAt, String? startedAt, String? expiredAt, String? finishedAt, String? settlementStatus, String? profitStatus, int? cycleDaysSnapshot
});




}
/// @nodoc
class _$DeployInfoCopyWithImpl<$Res>
    implements $DeployInfoCopyWith<$Res> {
  _$DeployInfoCopyWithImpl(this._self, this._then);

  final DeployInfo _self;
  final $Res Function(DeployInfo) _then;

/// Create a copy of DeployInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? orderNo = freezed,Object? orderStatus = freezed,Object? tokenStatus = freezed,Object? modelNameSnapshot = freezed,Object? deployFeeSnapshot = freezed,Object? apiName = freezed,Object? apiBaseUrl = freezed,Object? tokenMasked = freezed,Object? deployOrderStatus = freezed,Object? paidAt = freezed,Object? apiStage = freezed,Object? profitStartAt = freezed,Object? profitEndAt = freezed,Object? autoPauseAt = freezed,Object? nextStopAt = freezed,Object? nextStopReason = freezed,Object? pausedAt = freezed,Object? startedAt = freezed,Object? expiredAt = freezed,Object? finishedAt = freezed,Object? settlementStatus = freezed,Object? profitStatus = freezed,Object? cycleDaysSnapshot = freezed,}) {
  return _then(_self.copyWith(
orderNo: freezed == orderNo ? _self.orderNo : orderNo // ignore: cast_nullable_to_non_nullable
as String?,orderStatus: freezed == orderStatus ? _self.orderStatus : orderStatus // ignore: cast_nullable_to_non_nullable
as String?,tokenStatus: freezed == tokenStatus ? _self.tokenStatus : tokenStatus // ignore: cast_nullable_to_non_nullable
as String?,modelNameSnapshot: freezed == modelNameSnapshot ? _self.modelNameSnapshot : modelNameSnapshot // ignore: cast_nullable_to_non_nullable
as String?,deployFeeSnapshot: freezed == deployFeeSnapshot ? _self.deployFeeSnapshot : deployFeeSnapshot // ignore: cast_nullable_to_non_nullable
as String?,apiName: freezed == apiName ? _self.apiName : apiName // ignore: cast_nullable_to_non_nullable
as String?,apiBaseUrl: freezed == apiBaseUrl ? _self.apiBaseUrl : apiBaseUrl // ignore: cast_nullable_to_non_nullable
as String?,tokenMasked: freezed == tokenMasked ? _self.tokenMasked : tokenMasked // ignore: cast_nullable_to_non_nullable
as String?,deployOrderStatus: freezed == deployOrderStatus ? _self.deployOrderStatus : deployOrderStatus // ignore: cast_nullable_to_non_nullable
as String?,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as String?,apiStage: freezed == apiStage ? _self.apiStage : apiStage // ignore: cast_nullable_to_non_nullable
as String?,profitStartAt: freezed == profitStartAt ? _self.profitStartAt : profitStartAt // ignore: cast_nullable_to_non_nullable
as String?,profitEndAt: freezed == profitEndAt ? _self.profitEndAt : profitEndAt // ignore: cast_nullable_to_non_nullable
as String?,autoPauseAt: freezed == autoPauseAt ? _self.autoPauseAt : autoPauseAt // ignore: cast_nullable_to_non_nullable
as String?,nextStopAt: freezed == nextStopAt ? _self.nextStopAt : nextStopAt // ignore: cast_nullable_to_non_nullable
as String?,nextStopReason: freezed == nextStopReason ? _self.nextStopReason : nextStopReason // ignore: cast_nullable_to_non_nullable
as String?,pausedAt: freezed == pausedAt ? _self.pausedAt : pausedAt // ignore: cast_nullable_to_non_nullable
as String?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as String?,expiredAt: freezed == expiredAt ? _self.expiredAt : expiredAt // ignore: cast_nullable_to_non_nullable
as String?,finishedAt: freezed == finishedAt ? _self.finishedAt : finishedAt // ignore: cast_nullable_to_non_nullable
as String?,settlementStatus: freezed == settlementStatus ? _self.settlementStatus : settlementStatus // ignore: cast_nullable_to_non_nullable
as String?,profitStatus: freezed == profitStatus ? _self.profitStatus : profitStatus // ignore: cast_nullable_to_non_nullable
as String?,cycleDaysSnapshot: freezed == cycleDaysSnapshot ? _self.cycleDaysSnapshot : cycleDaysSnapshot // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [DeployInfo].
extension DeployInfoPatterns on DeployInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeployInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeployInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeployInfo value)  $default,){
final _that = this;
switch (_that) {
case _DeployInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeployInfo value)?  $default,){
final _that = this;
switch (_that) {
case _DeployInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? orderNo,  String? orderStatus,  String? tokenStatus,  String? modelNameSnapshot, @JsonKey(fromJson: _stringFromJson)  String? deployFeeSnapshot,  String? apiName,  String? apiBaseUrl,  String? tokenMasked,  String? deployOrderStatus,  String? paidAt,  String? apiStage,  String? profitStartAt,  String? profitEndAt,  String? autoPauseAt,  String? nextStopAt,  String? nextStopReason,  String? pausedAt,  String? startedAt,  String? expiredAt,  String? finishedAt,  String? settlementStatus,  String? profitStatus,  int? cycleDaysSnapshot)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeployInfo() when $default != null:
return $default(_that.orderNo,_that.orderStatus,_that.tokenStatus,_that.modelNameSnapshot,_that.deployFeeSnapshot,_that.apiName,_that.apiBaseUrl,_that.tokenMasked,_that.deployOrderStatus,_that.paidAt,_that.apiStage,_that.profitStartAt,_that.profitEndAt,_that.autoPauseAt,_that.nextStopAt,_that.nextStopReason,_that.pausedAt,_that.startedAt,_that.expiredAt,_that.finishedAt,_that.settlementStatus,_that.profitStatus,_that.cycleDaysSnapshot);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? orderNo,  String? orderStatus,  String? tokenStatus,  String? modelNameSnapshot, @JsonKey(fromJson: _stringFromJson)  String? deployFeeSnapshot,  String? apiName,  String? apiBaseUrl,  String? tokenMasked,  String? deployOrderStatus,  String? paidAt,  String? apiStage,  String? profitStartAt,  String? profitEndAt,  String? autoPauseAt,  String? nextStopAt,  String? nextStopReason,  String? pausedAt,  String? startedAt,  String? expiredAt,  String? finishedAt,  String? settlementStatus,  String? profitStatus,  int? cycleDaysSnapshot)  $default,) {final _that = this;
switch (_that) {
case _DeployInfo():
return $default(_that.orderNo,_that.orderStatus,_that.tokenStatus,_that.modelNameSnapshot,_that.deployFeeSnapshot,_that.apiName,_that.apiBaseUrl,_that.tokenMasked,_that.deployOrderStatus,_that.paidAt,_that.apiStage,_that.profitStartAt,_that.profitEndAt,_that.autoPauseAt,_that.nextStopAt,_that.nextStopReason,_that.pausedAt,_that.startedAt,_that.expiredAt,_that.finishedAt,_that.settlementStatus,_that.profitStatus,_that.cycleDaysSnapshot);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? orderNo,  String? orderStatus,  String? tokenStatus,  String? modelNameSnapshot, @JsonKey(fromJson: _stringFromJson)  String? deployFeeSnapshot,  String? apiName,  String? apiBaseUrl,  String? tokenMasked,  String? deployOrderStatus,  String? paidAt,  String? apiStage,  String? profitStartAt,  String? profitEndAt,  String? autoPauseAt,  String? nextStopAt,  String? nextStopReason,  String? pausedAt,  String? startedAt,  String? expiredAt,  String? finishedAt,  String? settlementStatus,  String? profitStatus,  int? cycleDaysSnapshot)?  $default,) {final _that = this;
switch (_that) {
case _DeployInfo() when $default != null:
return $default(_that.orderNo,_that.orderStatus,_that.tokenStatus,_that.modelNameSnapshot,_that.deployFeeSnapshot,_that.apiName,_that.apiBaseUrl,_that.tokenMasked,_that.deployOrderStatus,_that.paidAt,_that.apiStage,_that.profitStartAt,_that.profitEndAt,_that.autoPauseAt,_that.nextStopAt,_that.nextStopReason,_that.pausedAt,_that.startedAt,_that.expiredAt,_that.finishedAt,_that.settlementStatus,_that.profitStatus,_that.cycleDaysSnapshot);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeployInfo implements DeployInfo {
  const _DeployInfo({this.orderNo, this.orderStatus, this.tokenStatus, this.modelNameSnapshot, @JsonKey(fromJson: _stringFromJson) this.deployFeeSnapshot, this.apiName, this.apiBaseUrl, this.tokenMasked, this.deployOrderStatus, this.paidAt, this.apiStage, this.profitStartAt, this.profitEndAt, this.autoPauseAt, this.nextStopAt, this.nextStopReason, this.pausedAt, this.startedAt, this.expiredAt, this.finishedAt, this.settlementStatus, this.profitStatus, this.cycleDaysSnapshot});
  factory _DeployInfo.fromJson(Map<String, dynamic> json) => _$DeployInfoFromJson(json);

@override final  String? orderNo;
@override final  String? orderStatus;
@override final  String? tokenStatus;
@override final  String? modelNameSnapshot;
@override@JsonKey(fromJson: _stringFromJson) final  String? deployFeeSnapshot;
@override final  String? apiName;
@override final  String? apiBaseUrl;
@override final  String? tokenMasked;
@override final  String? deployOrderStatus;
@override final  String? paidAt;
@override final  String? apiStage;
@override final  String? profitStartAt;
@override final  String? profitEndAt;
@override final  String? autoPauseAt;
@override final  String? nextStopAt;
@override final  String? nextStopReason;
@override final  String? pausedAt;
@override final  String? startedAt;
@override final  String? expiredAt;
@override final  String? finishedAt;
@override final  String? settlementStatus;
@override final  String? profitStatus;
@override final  int? cycleDaysSnapshot;

/// Create a copy of DeployInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeployInfoCopyWith<_DeployInfo> get copyWith => __$DeployInfoCopyWithImpl<_DeployInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeployInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeployInfo&&(identical(other.orderNo, orderNo) || other.orderNo == orderNo)&&(identical(other.orderStatus, orderStatus) || other.orderStatus == orderStatus)&&(identical(other.tokenStatus, tokenStatus) || other.tokenStatus == tokenStatus)&&(identical(other.modelNameSnapshot, modelNameSnapshot) || other.modelNameSnapshot == modelNameSnapshot)&&(identical(other.deployFeeSnapshot, deployFeeSnapshot) || other.deployFeeSnapshot == deployFeeSnapshot)&&(identical(other.apiName, apiName) || other.apiName == apiName)&&(identical(other.apiBaseUrl, apiBaseUrl) || other.apiBaseUrl == apiBaseUrl)&&(identical(other.tokenMasked, tokenMasked) || other.tokenMasked == tokenMasked)&&(identical(other.deployOrderStatus, deployOrderStatus) || other.deployOrderStatus == deployOrderStatus)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&(identical(other.apiStage, apiStage) || other.apiStage == apiStage)&&(identical(other.profitStartAt, profitStartAt) || other.profitStartAt == profitStartAt)&&(identical(other.profitEndAt, profitEndAt) || other.profitEndAt == profitEndAt)&&(identical(other.autoPauseAt, autoPauseAt) || other.autoPauseAt == autoPauseAt)&&(identical(other.nextStopAt, nextStopAt) || other.nextStopAt == nextStopAt)&&(identical(other.nextStopReason, nextStopReason) || other.nextStopReason == nextStopReason)&&(identical(other.pausedAt, pausedAt) || other.pausedAt == pausedAt)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.expiredAt, expiredAt) || other.expiredAt == expiredAt)&&(identical(other.finishedAt, finishedAt) || other.finishedAt == finishedAt)&&(identical(other.settlementStatus, settlementStatus) || other.settlementStatus == settlementStatus)&&(identical(other.profitStatus, profitStatus) || other.profitStatus == profitStatus)&&(identical(other.cycleDaysSnapshot, cycleDaysSnapshot) || other.cycleDaysSnapshot == cycleDaysSnapshot));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,orderNo,orderStatus,tokenStatus,modelNameSnapshot,deployFeeSnapshot,apiName,apiBaseUrl,tokenMasked,deployOrderStatus,paidAt,apiStage,profitStartAt,profitEndAt,autoPauseAt,nextStopAt,nextStopReason,pausedAt,startedAt,expiredAt,finishedAt,settlementStatus,profitStatus,cycleDaysSnapshot]);

@override
String toString() {
  return 'DeployInfo(orderNo: $orderNo, orderStatus: $orderStatus, tokenStatus: $tokenStatus, modelNameSnapshot: $modelNameSnapshot, deployFeeSnapshot: $deployFeeSnapshot, apiName: $apiName, apiBaseUrl: $apiBaseUrl, tokenMasked: $tokenMasked, deployOrderStatus: $deployOrderStatus, paidAt: $paidAt, apiStage: $apiStage, profitStartAt: $profitStartAt, profitEndAt: $profitEndAt, autoPauseAt: $autoPauseAt, nextStopAt: $nextStopAt, nextStopReason: $nextStopReason, pausedAt: $pausedAt, startedAt: $startedAt, expiredAt: $expiredAt, finishedAt: $finishedAt, settlementStatus: $settlementStatus, profitStatus: $profitStatus, cycleDaysSnapshot: $cycleDaysSnapshot)';
}


}

/// @nodoc
abstract mixin class _$DeployInfoCopyWith<$Res> implements $DeployInfoCopyWith<$Res> {
  factory _$DeployInfoCopyWith(_DeployInfo value, $Res Function(_DeployInfo) _then) = __$DeployInfoCopyWithImpl;
@override @useResult
$Res call({
 String? orderNo, String? orderStatus, String? tokenStatus, String? modelNameSnapshot,@JsonKey(fromJson: _stringFromJson) String? deployFeeSnapshot, String? apiName, String? apiBaseUrl, String? tokenMasked, String? deployOrderStatus, String? paidAt, String? apiStage, String? profitStartAt, String? profitEndAt, String? autoPauseAt, String? nextStopAt, String? nextStopReason, String? pausedAt, String? startedAt, String? expiredAt, String? finishedAt, String? settlementStatus, String? profitStatus, int? cycleDaysSnapshot
});




}
/// @nodoc
class __$DeployInfoCopyWithImpl<$Res>
    implements _$DeployInfoCopyWith<$Res> {
  __$DeployInfoCopyWithImpl(this._self, this._then);

  final _DeployInfo _self;
  final $Res Function(_DeployInfo) _then;

/// Create a copy of DeployInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orderNo = freezed,Object? orderStatus = freezed,Object? tokenStatus = freezed,Object? modelNameSnapshot = freezed,Object? deployFeeSnapshot = freezed,Object? apiName = freezed,Object? apiBaseUrl = freezed,Object? tokenMasked = freezed,Object? deployOrderStatus = freezed,Object? paidAt = freezed,Object? apiStage = freezed,Object? profitStartAt = freezed,Object? profitEndAt = freezed,Object? autoPauseAt = freezed,Object? nextStopAt = freezed,Object? nextStopReason = freezed,Object? pausedAt = freezed,Object? startedAt = freezed,Object? expiredAt = freezed,Object? finishedAt = freezed,Object? settlementStatus = freezed,Object? profitStatus = freezed,Object? cycleDaysSnapshot = freezed,}) {
  return _then(_DeployInfo(
orderNo: freezed == orderNo ? _self.orderNo : orderNo // ignore: cast_nullable_to_non_nullable
as String?,orderStatus: freezed == orderStatus ? _self.orderStatus : orderStatus // ignore: cast_nullable_to_non_nullable
as String?,tokenStatus: freezed == tokenStatus ? _self.tokenStatus : tokenStatus // ignore: cast_nullable_to_non_nullable
as String?,modelNameSnapshot: freezed == modelNameSnapshot ? _self.modelNameSnapshot : modelNameSnapshot // ignore: cast_nullable_to_non_nullable
as String?,deployFeeSnapshot: freezed == deployFeeSnapshot ? _self.deployFeeSnapshot : deployFeeSnapshot // ignore: cast_nullable_to_non_nullable
as String?,apiName: freezed == apiName ? _self.apiName : apiName // ignore: cast_nullable_to_non_nullable
as String?,apiBaseUrl: freezed == apiBaseUrl ? _self.apiBaseUrl : apiBaseUrl // ignore: cast_nullable_to_non_nullable
as String?,tokenMasked: freezed == tokenMasked ? _self.tokenMasked : tokenMasked // ignore: cast_nullable_to_non_nullable
as String?,deployOrderStatus: freezed == deployOrderStatus ? _self.deployOrderStatus : deployOrderStatus // ignore: cast_nullable_to_non_nullable
as String?,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as String?,apiStage: freezed == apiStage ? _self.apiStage : apiStage // ignore: cast_nullable_to_non_nullable
as String?,profitStartAt: freezed == profitStartAt ? _self.profitStartAt : profitStartAt // ignore: cast_nullable_to_non_nullable
as String?,profitEndAt: freezed == profitEndAt ? _self.profitEndAt : profitEndAt // ignore: cast_nullable_to_non_nullable
as String?,autoPauseAt: freezed == autoPauseAt ? _self.autoPauseAt : autoPauseAt // ignore: cast_nullable_to_non_nullable
as String?,nextStopAt: freezed == nextStopAt ? _self.nextStopAt : nextStopAt // ignore: cast_nullable_to_non_nullable
as String?,nextStopReason: freezed == nextStopReason ? _self.nextStopReason : nextStopReason // ignore: cast_nullable_to_non_nullable
as String?,pausedAt: freezed == pausedAt ? _self.pausedAt : pausedAt // ignore: cast_nullable_to_non_nullable
as String?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as String?,expiredAt: freezed == expiredAt ? _self.expiredAt : expiredAt // ignore: cast_nullable_to_non_nullable
as String?,finishedAt: freezed == finishedAt ? _self.finishedAt : finishedAt // ignore: cast_nullable_to_non_nullable
as String?,settlementStatus: freezed == settlementStatus ? _self.settlementStatus : settlementStatus // ignore: cast_nullable_to_non_nullable
as String?,profitStatus: freezed == profitStatus ? _self.profitStatus : profitStatus // ignore: cast_nullable_to_non_nullable
as String?,cycleDaysSnapshot: freezed == cycleDaysSnapshot ? _self.cycleDaysSnapshot : cycleDaysSnapshot // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$DeployOrder {

 String? get modelNameSnapshot;@JsonKey(fromJson: _stringFromJson) String? get deployFeeAmount; String? get status; String? get paidAt; String? get createdAt;
/// Create a copy of DeployOrder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeployOrderCopyWith<DeployOrder> get copyWith => _$DeployOrderCopyWithImpl<DeployOrder>(this as DeployOrder, _$identity);

  /// Serializes this DeployOrder to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeployOrder&&(identical(other.modelNameSnapshot, modelNameSnapshot) || other.modelNameSnapshot == modelNameSnapshot)&&(identical(other.deployFeeAmount, deployFeeAmount) || other.deployFeeAmount == deployFeeAmount)&&(identical(other.status, status) || other.status == status)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,modelNameSnapshot,deployFeeAmount,status,paidAt,createdAt);

@override
String toString() {
  return 'DeployOrder(modelNameSnapshot: $modelNameSnapshot, deployFeeAmount: $deployFeeAmount, status: $status, paidAt: $paidAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $DeployOrderCopyWith<$Res>  {
  factory $DeployOrderCopyWith(DeployOrder value, $Res Function(DeployOrder) _then) = _$DeployOrderCopyWithImpl;
@useResult
$Res call({
 String? modelNameSnapshot,@JsonKey(fromJson: _stringFromJson) String? deployFeeAmount, String? status, String? paidAt, String? createdAt
});




}
/// @nodoc
class _$DeployOrderCopyWithImpl<$Res>
    implements $DeployOrderCopyWith<$Res> {
  _$DeployOrderCopyWithImpl(this._self, this._then);

  final DeployOrder _self;
  final $Res Function(DeployOrder) _then;

/// Create a copy of DeployOrder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? modelNameSnapshot = freezed,Object? deployFeeAmount = freezed,Object? status = freezed,Object? paidAt = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
modelNameSnapshot: freezed == modelNameSnapshot ? _self.modelNameSnapshot : modelNameSnapshot // ignore: cast_nullable_to_non_nullable
as String?,deployFeeAmount: freezed == deployFeeAmount ? _self.deployFeeAmount : deployFeeAmount // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DeployOrder].
extension DeployOrderPatterns on DeployOrder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeployOrder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeployOrder() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeployOrder value)  $default,){
final _that = this;
switch (_that) {
case _DeployOrder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeployOrder value)?  $default,){
final _that = this;
switch (_that) {
case _DeployOrder() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? modelNameSnapshot, @JsonKey(fromJson: _stringFromJson)  String? deployFeeAmount,  String? status,  String? paidAt,  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeployOrder() when $default != null:
return $default(_that.modelNameSnapshot,_that.deployFeeAmount,_that.status,_that.paidAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? modelNameSnapshot, @JsonKey(fromJson: _stringFromJson)  String? deployFeeAmount,  String? status,  String? paidAt,  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _DeployOrder():
return $default(_that.modelNameSnapshot,_that.deployFeeAmount,_that.status,_that.paidAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? modelNameSnapshot, @JsonKey(fromJson: _stringFromJson)  String? deployFeeAmount,  String? status,  String? paidAt,  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _DeployOrder() when $default != null:
return $default(_that.modelNameSnapshot,_that.deployFeeAmount,_that.status,_that.paidAt,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeployOrder implements DeployOrder {
  const _DeployOrder({this.modelNameSnapshot, @JsonKey(fromJson: _stringFromJson) this.deployFeeAmount, this.status, this.paidAt, this.createdAt});
  factory _DeployOrder.fromJson(Map<String, dynamic> json) => _$DeployOrderFromJson(json);

@override final  String? modelNameSnapshot;
@override@JsonKey(fromJson: _stringFromJson) final  String? deployFeeAmount;
@override final  String? status;
@override final  String? paidAt;
@override final  String? createdAt;

/// Create a copy of DeployOrder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeployOrderCopyWith<_DeployOrder> get copyWith => __$DeployOrderCopyWithImpl<_DeployOrder>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeployOrderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeployOrder&&(identical(other.modelNameSnapshot, modelNameSnapshot) || other.modelNameSnapshot == modelNameSnapshot)&&(identical(other.deployFeeAmount, deployFeeAmount) || other.deployFeeAmount == deployFeeAmount)&&(identical(other.status, status) || other.status == status)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,modelNameSnapshot,deployFeeAmount,status,paidAt,createdAt);

@override
String toString() {
  return 'DeployOrder(modelNameSnapshot: $modelNameSnapshot, deployFeeAmount: $deployFeeAmount, status: $status, paidAt: $paidAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$DeployOrderCopyWith<$Res> implements $DeployOrderCopyWith<$Res> {
  factory _$DeployOrderCopyWith(_DeployOrder value, $Res Function(_DeployOrder) _then) = __$DeployOrderCopyWithImpl;
@override @useResult
$Res call({
 String? modelNameSnapshot,@JsonKey(fromJson: _stringFromJson) String? deployFeeAmount, String? status, String? paidAt, String? createdAt
});




}
/// @nodoc
class __$DeployOrderCopyWithImpl<$Res>
    implements _$DeployOrderCopyWith<$Res> {
  __$DeployOrderCopyWithImpl(this._self, this._then);

  final _DeployOrder _self;
  final $Res Function(_DeployOrder) _then;

/// Create a copy of DeployOrder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? modelNameSnapshot = freezed,Object? deployFeeAmount = freezed,Object? status = freezed,Object? paidAt = freezed,Object? createdAt = freezed,}) {
  return _then(_DeployOrder(
modelNameSnapshot: freezed == modelNameSnapshot ? _self.modelNameSnapshot : modelNameSnapshot // ignore: cast_nullable_to_non_nullable
as String?,deployFeeAmount: freezed == deployFeeAmount ? _self.deployFeeAmount : deployFeeAmount // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$RealtimeEarningSnapshot {

 String? get orderNo; String? get currency;@JsonKey(fromJson: _stringFromJson) String? get realtimeProfitAmount;@JsonKey(fromJson: _stringFromJson) String? get totalProfitAmount; String? get tokenAssetCode;@JsonKey(fromJson: _stringFromJson) String? get realtimeTokenAmount;@JsonKey(fromJson: _stringFromJson) String? get totalTokenAmount; String? get calculatedAt; bool? get running; String? get status;
/// Create a copy of RealtimeEarningSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RealtimeEarningSnapshotCopyWith<RealtimeEarningSnapshot> get copyWith => _$RealtimeEarningSnapshotCopyWithImpl<RealtimeEarningSnapshot>(this as RealtimeEarningSnapshot, _$identity);

  /// Serializes this RealtimeEarningSnapshot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RealtimeEarningSnapshot&&(identical(other.orderNo, orderNo) || other.orderNo == orderNo)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.realtimeProfitAmount, realtimeProfitAmount) || other.realtimeProfitAmount == realtimeProfitAmount)&&(identical(other.totalProfitAmount, totalProfitAmount) || other.totalProfitAmount == totalProfitAmount)&&(identical(other.tokenAssetCode, tokenAssetCode) || other.tokenAssetCode == tokenAssetCode)&&(identical(other.realtimeTokenAmount, realtimeTokenAmount) || other.realtimeTokenAmount == realtimeTokenAmount)&&(identical(other.totalTokenAmount, totalTokenAmount) || other.totalTokenAmount == totalTokenAmount)&&(identical(other.calculatedAt, calculatedAt) || other.calculatedAt == calculatedAt)&&(identical(other.running, running) || other.running == running)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,orderNo,currency,realtimeProfitAmount,totalProfitAmount,tokenAssetCode,realtimeTokenAmount,totalTokenAmount,calculatedAt,running,status);

@override
String toString() {
  return 'RealtimeEarningSnapshot(orderNo: $orderNo, currency: $currency, realtimeProfitAmount: $realtimeProfitAmount, totalProfitAmount: $totalProfitAmount, tokenAssetCode: $tokenAssetCode, realtimeTokenAmount: $realtimeTokenAmount, totalTokenAmount: $totalTokenAmount, calculatedAt: $calculatedAt, running: $running, status: $status)';
}


}

/// @nodoc
abstract mixin class $RealtimeEarningSnapshotCopyWith<$Res>  {
  factory $RealtimeEarningSnapshotCopyWith(RealtimeEarningSnapshot value, $Res Function(RealtimeEarningSnapshot) _then) = _$RealtimeEarningSnapshotCopyWithImpl;
@useResult
$Res call({
 String? orderNo, String? currency,@JsonKey(fromJson: _stringFromJson) String? realtimeProfitAmount,@JsonKey(fromJson: _stringFromJson) String? totalProfitAmount, String? tokenAssetCode,@JsonKey(fromJson: _stringFromJson) String? realtimeTokenAmount,@JsonKey(fromJson: _stringFromJson) String? totalTokenAmount, String? calculatedAt, bool? running, String? status
});




}
/// @nodoc
class _$RealtimeEarningSnapshotCopyWithImpl<$Res>
    implements $RealtimeEarningSnapshotCopyWith<$Res> {
  _$RealtimeEarningSnapshotCopyWithImpl(this._self, this._then);

  final RealtimeEarningSnapshot _self;
  final $Res Function(RealtimeEarningSnapshot) _then;

/// Create a copy of RealtimeEarningSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? orderNo = freezed,Object? currency = freezed,Object? realtimeProfitAmount = freezed,Object? totalProfitAmount = freezed,Object? tokenAssetCode = freezed,Object? realtimeTokenAmount = freezed,Object? totalTokenAmount = freezed,Object? calculatedAt = freezed,Object? running = freezed,Object? status = freezed,}) {
  return _then(_self.copyWith(
orderNo: freezed == orderNo ? _self.orderNo : orderNo // ignore: cast_nullable_to_non_nullable
as String?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,realtimeProfitAmount: freezed == realtimeProfitAmount ? _self.realtimeProfitAmount : realtimeProfitAmount // ignore: cast_nullable_to_non_nullable
as String?,totalProfitAmount: freezed == totalProfitAmount ? _self.totalProfitAmount : totalProfitAmount // ignore: cast_nullable_to_non_nullable
as String?,tokenAssetCode: freezed == tokenAssetCode ? _self.tokenAssetCode : tokenAssetCode // ignore: cast_nullable_to_non_nullable
as String?,realtimeTokenAmount: freezed == realtimeTokenAmount ? _self.realtimeTokenAmount : realtimeTokenAmount // ignore: cast_nullable_to_non_nullable
as String?,totalTokenAmount: freezed == totalTokenAmount ? _self.totalTokenAmount : totalTokenAmount // ignore: cast_nullable_to_non_nullable
as String?,calculatedAt: freezed == calculatedAt ? _self.calculatedAt : calculatedAt // ignore: cast_nullable_to_non_nullable
as String?,running: freezed == running ? _self.running : running // ignore: cast_nullable_to_non_nullable
as bool?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RealtimeEarningSnapshot].
extension RealtimeEarningSnapshotPatterns on RealtimeEarningSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RealtimeEarningSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RealtimeEarningSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RealtimeEarningSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _RealtimeEarningSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RealtimeEarningSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _RealtimeEarningSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? orderNo,  String? currency, @JsonKey(fromJson: _stringFromJson)  String? realtimeProfitAmount, @JsonKey(fromJson: _stringFromJson)  String? totalProfitAmount,  String? tokenAssetCode, @JsonKey(fromJson: _stringFromJson)  String? realtimeTokenAmount, @JsonKey(fromJson: _stringFromJson)  String? totalTokenAmount,  String? calculatedAt,  bool? running,  String? status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RealtimeEarningSnapshot() when $default != null:
return $default(_that.orderNo,_that.currency,_that.realtimeProfitAmount,_that.totalProfitAmount,_that.tokenAssetCode,_that.realtimeTokenAmount,_that.totalTokenAmount,_that.calculatedAt,_that.running,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? orderNo,  String? currency, @JsonKey(fromJson: _stringFromJson)  String? realtimeProfitAmount, @JsonKey(fromJson: _stringFromJson)  String? totalProfitAmount,  String? tokenAssetCode, @JsonKey(fromJson: _stringFromJson)  String? realtimeTokenAmount, @JsonKey(fromJson: _stringFromJson)  String? totalTokenAmount,  String? calculatedAt,  bool? running,  String? status)  $default,) {final _that = this;
switch (_that) {
case _RealtimeEarningSnapshot():
return $default(_that.orderNo,_that.currency,_that.realtimeProfitAmount,_that.totalProfitAmount,_that.tokenAssetCode,_that.realtimeTokenAmount,_that.totalTokenAmount,_that.calculatedAt,_that.running,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? orderNo,  String? currency, @JsonKey(fromJson: _stringFromJson)  String? realtimeProfitAmount, @JsonKey(fromJson: _stringFromJson)  String? totalProfitAmount,  String? tokenAssetCode, @JsonKey(fromJson: _stringFromJson)  String? realtimeTokenAmount, @JsonKey(fromJson: _stringFromJson)  String? totalTokenAmount,  String? calculatedAt,  bool? running,  String? status)?  $default,) {final _that = this;
switch (_that) {
case _RealtimeEarningSnapshot() when $default != null:
return $default(_that.orderNo,_that.currency,_that.realtimeProfitAmount,_that.totalProfitAmount,_that.tokenAssetCode,_that.realtimeTokenAmount,_that.totalTokenAmount,_that.calculatedAt,_that.running,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RealtimeEarningSnapshot implements RealtimeEarningSnapshot {
  const _RealtimeEarningSnapshot({this.orderNo, this.currency, @JsonKey(fromJson: _stringFromJson) this.realtimeProfitAmount, @JsonKey(fromJson: _stringFromJson) this.totalProfitAmount, this.tokenAssetCode, @JsonKey(fromJson: _stringFromJson) this.realtimeTokenAmount, @JsonKey(fromJson: _stringFromJson) this.totalTokenAmount, this.calculatedAt, this.running, this.status});
  factory _RealtimeEarningSnapshot.fromJson(Map<String, dynamic> json) => _$RealtimeEarningSnapshotFromJson(json);

@override final  String? orderNo;
@override final  String? currency;
@override@JsonKey(fromJson: _stringFromJson) final  String? realtimeProfitAmount;
@override@JsonKey(fromJson: _stringFromJson) final  String? totalProfitAmount;
@override final  String? tokenAssetCode;
@override@JsonKey(fromJson: _stringFromJson) final  String? realtimeTokenAmount;
@override@JsonKey(fromJson: _stringFromJson) final  String? totalTokenAmount;
@override final  String? calculatedAt;
@override final  bool? running;
@override final  String? status;

/// Create a copy of RealtimeEarningSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RealtimeEarningSnapshotCopyWith<_RealtimeEarningSnapshot> get copyWith => __$RealtimeEarningSnapshotCopyWithImpl<_RealtimeEarningSnapshot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RealtimeEarningSnapshotToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RealtimeEarningSnapshot&&(identical(other.orderNo, orderNo) || other.orderNo == orderNo)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.realtimeProfitAmount, realtimeProfitAmount) || other.realtimeProfitAmount == realtimeProfitAmount)&&(identical(other.totalProfitAmount, totalProfitAmount) || other.totalProfitAmount == totalProfitAmount)&&(identical(other.tokenAssetCode, tokenAssetCode) || other.tokenAssetCode == tokenAssetCode)&&(identical(other.realtimeTokenAmount, realtimeTokenAmount) || other.realtimeTokenAmount == realtimeTokenAmount)&&(identical(other.totalTokenAmount, totalTokenAmount) || other.totalTokenAmount == totalTokenAmount)&&(identical(other.calculatedAt, calculatedAt) || other.calculatedAt == calculatedAt)&&(identical(other.running, running) || other.running == running)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,orderNo,currency,realtimeProfitAmount,totalProfitAmount,tokenAssetCode,realtimeTokenAmount,totalTokenAmount,calculatedAt,running,status);

@override
String toString() {
  return 'RealtimeEarningSnapshot(orderNo: $orderNo, currency: $currency, realtimeProfitAmount: $realtimeProfitAmount, totalProfitAmount: $totalProfitAmount, tokenAssetCode: $tokenAssetCode, realtimeTokenAmount: $realtimeTokenAmount, totalTokenAmount: $totalTokenAmount, calculatedAt: $calculatedAt, running: $running, status: $status)';
}


}

/// @nodoc
abstract mixin class _$RealtimeEarningSnapshotCopyWith<$Res> implements $RealtimeEarningSnapshotCopyWith<$Res> {
  factory _$RealtimeEarningSnapshotCopyWith(_RealtimeEarningSnapshot value, $Res Function(_RealtimeEarningSnapshot) _then) = __$RealtimeEarningSnapshotCopyWithImpl;
@override @useResult
$Res call({
 String? orderNo, String? currency,@JsonKey(fromJson: _stringFromJson) String? realtimeProfitAmount,@JsonKey(fromJson: _stringFromJson) String? totalProfitAmount, String? tokenAssetCode,@JsonKey(fromJson: _stringFromJson) String? realtimeTokenAmount,@JsonKey(fromJson: _stringFromJson) String? totalTokenAmount, String? calculatedAt, bool? running, String? status
});




}
/// @nodoc
class __$RealtimeEarningSnapshotCopyWithImpl<$Res>
    implements _$RealtimeEarningSnapshotCopyWith<$Res> {
  __$RealtimeEarningSnapshotCopyWithImpl(this._self, this._then);

  final _RealtimeEarningSnapshot _self;
  final $Res Function(_RealtimeEarningSnapshot) _then;

/// Create a copy of RealtimeEarningSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orderNo = freezed,Object? currency = freezed,Object? realtimeProfitAmount = freezed,Object? totalProfitAmount = freezed,Object? tokenAssetCode = freezed,Object? realtimeTokenAmount = freezed,Object? totalTokenAmount = freezed,Object? calculatedAt = freezed,Object? running = freezed,Object? status = freezed,}) {
  return _then(_RealtimeEarningSnapshot(
orderNo: freezed == orderNo ? _self.orderNo : orderNo // ignore: cast_nullable_to_non_nullable
as String?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,realtimeProfitAmount: freezed == realtimeProfitAmount ? _self.realtimeProfitAmount : realtimeProfitAmount // ignore: cast_nullable_to_non_nullable
as String?,totalProfitAmount: freezed == totalProfitAmount ? _self.totalProfitAmount : totalProfitAmount // ignore: cast_nullable_to_non_nullable
as String?,tokenAssetCode: freezed == tokenAssetCode ? _self.tokenAssetCode : tokenAssetCode // ignore: cast_nullable_to_non_nullable
as String?,realtimeTokenAmount: freezed == realtimeTokenAmount ? _self.realtimeTokenAmount : realtimeTokenAmount // ignore: cast_nullable_to_non_nullable
as String?,totalTokenAmount: freezed == totalTokenAmount ? _self.totalTokenAmount : totalTokenAmount // ignore: cast_nullable_to_non_nullable
as String?,calculatedAt: freezed == calculatedAt ? _self.calculatedAt : calculatedAt // ignore: cast_nullable_to_non_nullable
as String?,running: freezed == running ? _self.running : running // ignore: cast_nullable_to_non_nullable
as bool?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$RechargeChannel {

 int? get channelId; String? get channelName; String? get channelCode; String? get network; String? get displayUrl; String? get qrCodeUrl; String? get accountName; String? get accountNo;
/// Create a copy of RechargeChannel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RechargeChannelCopyWith<RechargeChannel> get copyWith => _$RechargeChannelCopyWithImpl<RechargeChannel>(this as RechargeChannel, _$identity);

  /// Serializes this RechargeChannel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RechargeChannel&&(identical(other.channelId, channelId) || other.channelId == channelId)&&(identical(other.channelName, channelName) || other.channelName == channelName)&&(identical(other.channelCode, channelCode) || other.channelCode == channelCode)&&(identical(other.network, network) || other.network == network)&&(identical(other.displayUrl, displayUrl) || other.displayUrl == displayUrl)&&(identical(other.qrCodeUrl, qrCodeUrl) || other.qrCodeUrl == qrCodeUrl)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.accountNo, accountNo) || other.accountNo == accountNo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,channelId,channelName,channelCode,network,displayUrl,qrCodeUrl,accountName,accountNo);

@override
String toString() {
  return 'RechargeChannel(channelId: $channelId, channelName: $channelName, channelCode: $channelCode, network: $network, displayUrl: $displayUrl, qrCodeUrl: $qrCodeUrl, accountName: $accountName, accountNo: $accountNo)';
}


}

/// @nodoc
abstract mixin class $RechargeChannelCopyWith<$Res>  {
  factory $RechargeChannelCopyWith(RechargeChannel value, $Res Function(RechargeChannel) _then) = _$RechargeChannelCopyWithImpl;
@useResult
$Res call({
 int? channelId, String? channelName, String? channelCode, String? network, String? displayUrl, String? qrCodeUrl, String? accountName, String? accountNo
});




}
/// @nodoc
class _$RechargeChannelCopyWithImpl<$Res>
    implements $RechargeChannelCopyWith<$Res> {
  _$RechargeChannelCopyWithImpl(this._self, this._then);

  final RechargeChannel _self;
  final $Res Function(RechargeChannel) _then;

/// Create a copy of RechargeChannel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? channelId = freezed,Object? channelName = freezed,Object? channelCode = freezed,Object? network = freezed,Object? displayUrl = freezed,Object? qrCodeUrl = freezed,Object? accountName = freezed,Object? accountNo = freezed,}) {
  return _then(_self.copyWith(
channelId: freezed == channelId ? _self.channelId : channelId // ignore: cast_nullable_to_non_nullable
as int?,channelName: freezed == channelName ? _self.channelName : channelName // ignore: cast_nullable_to_non_nullable
as String?,channelCode: freezed == channelCode ? _self.channelCode : channelCode // ignore: cast_nullable_to_non_nullable
as String?,network: freezed == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String?,displayUrl: freezed == displayUrl ? _self.displayUrl : displayUrl // ignore: cast_nullable_to_non_nullable
as String?,qrCodeUrl: freezed == qrCodeUrl ? _self.qrCodeUrl : qrCodeUrl // ignore: cast_nullable_to_non_nullable
as String?,accountName: freezed == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String?,accountNo: freezed == accountNo ? _self.accountNo : accountNo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RechargeChannel].
extension RechargeChannelPatterns on RechargeChannel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RechargeChannel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RechargeChannel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RechargeChannel value)  $default,){
final _that = this;
switch (_that) {
case _RechargeChannel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RechargeChannel value)?  $default,){
final _that = this;
switch (_that) {
case _RechargeChannel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? channelId,  String? channelName,  String? channelCode,  String? network,  String? displayUrl,  String? qrCodeUrl,  String? accountName,  String? accountNo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RechargeChannel() when $default != null:
return $default(_that.channelId,_that.channelName,_that.channelCode,_that.network,_that.displayUrl,_that.qrCodeUrl,_that.accountName,_that.accountNo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? channelId,  String? channelName,  String? channelCode,  String? network,  String? displayUrl,  String? qrCodeUrl,  String? accountName,  String? accountNo)  $default,) {final _that = this;
switch (_that) {
case _RechargeChannel():
return $default(_that.channelId,_that.channelName,_that.channelCode,_that.network,_that.displayUrl,_that.qrCodeUrl,_that.accountName,_that.accountNo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? channelId,  String? channelName,  String? channelCode,  String? network,  String? displayUrl,  String? qrCodeUrl,  String? accountName,  String? accountNo)?  $default,) {final _that = this;
switch (_that) {
case _RechargeChannel() when $default != null:
return $default(_that.channelId,_that.channelName,_that.channelCode,_that.network,_that.displayUrl,_that.qrCodeUrl,_that.accountName,_that.accountNo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RechargeChannel implements RechargeChannel {
  const _RechargeChannel({this.channelId, this.channelName, this.channelCode, this.network, this.displayUrl, this.qrCodeUrl, this.accountName, this.accountNo});
  factory _RechargeChannel.fromJson(Map<String, dynamic> json) => _$RechargeChannelFromJson(json);

@override final  int? channelId;
@override final  String? channelName;
@override final  String? channelCode;
@override final  String? network;
@override final  String? displayUrl;
@override final  String? qrCodeUrl;
@override final  String? accountName;
@override final  String? accountNo;

/// Create a copy of RechargeChannel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RechargeChannelCopyWith<_RechargeChannel> get copyWith => __$RechargeChannelCopyWithImpl<_RechargeChannel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RechargeChannelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RechargeChannel&&(identical(other.channelId, channelId) || other.channelId == channelId)&&(identical(other.channelName, channelName) || other.channelName == channelName)&&(identical(other.channelCode, channelCode) || other.channelCode == channelCode)&&(identical(other.network, network) || other.network == network)&&(identical(other.displayUrl, displayUrl) || other.displayUrl == displayUrl)&&(identical(other.qrCodeUrl, qrCodeUrl) || other.qrCodeUrl == qrCodeUrl)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.accountNo, accountNo) || other.accountNo == accountNo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,channelId,channelName,channelCode,network,displayUrl,qrCodeUrl,accountName,accountNo);

@override
String toString() {
  return 'RechargeChannel(channelId: $channelId, channelName: $channelName, channelCode: $channelCode, network: $network, displayUrl: $displayUrl, qrCodeUrl: $qrCodeUrl, accountName: $accountName, accountNo: $accountNo)';
}


}

/// @nodoc
abstract mixin class _$RechargeChannelCopyWith<$Res> implements $RechargeChannelCopyWith<$Res> {
  factory _$RechargeChannelCopyWith(_RechargeChannel value, $Res Function(_RechargeChannel) _then) = __$RechargeChannelCopyWithImpl;
@override @useResult
$Res call({
 int? channelId, String? channelName, String? channelCode, String? network, String? displayUrl, String? qrCodeUrl, String? accountName, String? accountNo
});




}
/// @nodoc
class __$RechargeChannelCopyWithImpl<$Res>
    implements _$RechargeChannelCopyWith<$Res> {
  __$RechargeChannelCopyWithImpl(this._self, this._then);

  final _RechargeChannel _self;
  final $Res Function(_RechargeChannel) _then;

/// Create a copy of RechargeChannel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? channelId = freezed,Object? channelName = freezed,Object? channelCode = freezed,Object? network = freezed,Object? displayUrl = freezed,Object? qrCodeUrl = freezed,Object? accountName = freezed,Object? accountNo = freezed,}) {
  return _then(_RechargeChannel(
channelId: freezed == channelId ? _self.channelId : channelId // ignore: cast_nullable_to_non_nullable
as int?,channelName: freezed == channelName ? _self.channelName : channelName // ignore: cast_nullable_to_non_nullable
as String?,channelCode: freezed == channelCode ? _self.channelCode : channelCode // ignore: cast_nullable_to_non_nullable
as String?,network: freezed == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String?,displayUrl: freezed == displayUrl ? _self.displayUrl : displayUrl // ignore: cast_nullable_to_non_nullable
as String?,qrCodeUrl: freezed == qrCodeUrl ? _self.qrCodeUrl : qrCodeUrl // ignore: cast_nullable_to_non_nullable
as String?,accountName: freezed == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String?,accountNo: freezed == accountNo ? _self.accountNo : accountNo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$RechargeOrder {

 String? get rechargeNo; String? get currency; String? get channelName; String? get network; String? get accountNo;@JsonKey(fromJson: _stringFromJson) String? get applyAmount;@JsonKey(fromJson: _stringFromJson) String? get actualAmount; String? get displayUrl; String? get channelQrCodeUrl; String? get externalTxNo; String? get paymentProofUrl; String? get userRemark; String? get status; String? get createdAt; String? get reviewedAt; String? get reviewRemark; String? get creditedAt;
/// Create a copy of RechargeOrder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RechargeOrderCopyWith<RechargeOrder> get copyWith => _$RechargeOrderCopyWithImpl<RechargeOrder>(this as RechargeOrder, _$identity);

  /// Serializes this RechargeOrder to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RechargeOrder&&(identical(other.rechargeNo, rechargeNo) || other.rechargeNo == rechargeNo)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.channelName, channelName) || other.channelName == channelName)&&(identical(other.network, network) || other.network == network)&&(identical(other.accountNo, accountNo) || other.accountNo == accountNo)&&(identical(other.applyAmount, applyAmount) || other.applyAmount == applyAmount)&&(identical(other.actualAmount, actualAmount) || other.actualAmount == actualAmount)&&(identical(other.displayUrl, displayUrl) || other.displayUrl == displayUrl)&&(identical(other.channelQrCodeUrl, channelQrCodeUrl) || other.channelQrCodeUrl == channelQrCodeUrl)&&(identical(other.externalTxNo, externalTxNo) || other.externalTxNo == externalTxNo)&&(identical(other.paymentProofUrl, paymentProofUrl) || other.paymentProofUrl == paymentProofUrl)&&(identical(other.userRemark, userRemark) || other.userRemark == userRemark)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt)&&(identical(other.reviewRemark, reviewRemark) || other.reviewRemark == reviewRemark)&&(identical(other.creditedAt, creditedAt) || other.creditedAt == creditedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rechargeNo,currency,channelName,network,accountNo,applyAmount,actualAmount,displayUrl,channelQrCodeUrl,externalTxNo,paymentProofUrl,userRemark,status,createdAt,reviewedAt,reviewRemark,creditedAt);

@override
String toString() {
  return 'RechargeOrder(rechargeNo: $rechargeNo, currency: $currency, channelName: $channelName, network: $network, accountNo: $accountNo, applyAmount: $applyAmount, actualAmount: $actualAmount, displayUrl: $displayUrl, channelQrCodeUrl: $channelQrCodeUrl, externalTxNo: $externalTxNo, paymentProofUrl: $paymentProofUrl, userRemark: $userRemark, status: $status, createdAt: $createdAt, reviewedAt: $reviewedAt, reviewRemark: $reviewRemark, creditedAt: $creditedAt)';
}


}

/// @nodoc
abstract mixin class $RechargeOrderCopyWith<$Res>  {
  factory $RechargeOrderCopyWith(RechargeOrder value, $Res Function(RechargeOrder) _then) = _$RechargeOrderCopyWithImpl;
@useResult
$Res call({
 String? rechargeNo, String? currency, String? channelName, String? network, String? accountNo,@JsonKey(fromJson: _stringFromJson) String? applyAmount,@JsonKey(fromJson: _stringFromJson) String? actualAmount, String? displayUrl, String? channelQrCodeUrl, String? externalTxNo, String? paymentProofUrl, String? userRemark, String? status, String? createdAt, String? reviewedAt, String? reviewRemark, String? creditedAt
});




}
/// @nodoc
class _$RechargeOrderCopyWithImpl<$Res>
    implements $RechargeOrderCopyWith<$Res> {
  _$RechargeOrderCopyWithImpl(this._self, this._then);

  final RechargeOrder _self;
  final $Res Function(RechargeOrder) _then;

/// Create a copy of RechargeOrder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rechargeNo = freezed,Object? currency = freezed,Object? channelName = freezed,Object? network = freezed,Object? accountNo = freezed,Object? applyAmount = freezed,Object? actualAmount = freezed,Object? displayUrl = freezed,Object? channelQrCodeUrl = freezed,Object? externalTxNo = freezed,Object? paymentProofUrl = freezed,Object? userRemark = freezed,Object? status = freezed,Object? createdAt = freezed,Object? reviewedAt = freezed,Object? reviewRemark = freezed,Object? creditedAt = freezed,}) {
  return _then(_self.copyWith(
rechargeNo: freezed == rechargeNo ? _self.rechargeNo : rechargeNo // ignore: cast_nullable_to_non_nullable
as String?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,channelName: freezed == channelName ? _self.channelName : channelName // ignore: cast_nullable_to_non_nullable
as String?,network: freezed == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String?,accountNo: freezed == accountNo ? _self.accountNo : accountNo // ignore: cast_nullable_to_non_nullable
as String?,applyAmount: freezed == applyAmount ? _self.applyAmount : applyAmount // ignore: cast_nullable_to_non_nullable
as String?,actualAmount: freezed == actualAmount ? _self.actualAmount : actualAmount // ignore: cast_nullable_to_non_nullable
as String?,displayUrl: freezed == displayUrl ? _self.displayUrl : displayUrl // ignore: cast_nullable_to_non_nullable
as String?,channelQrCodeUrl: freezed == channelQrCodeUrl ? _self.channelQrCodeUrl : channelQrCodeUrl // ignore: cast_nullable_to_non_nullable
as String?,externalTxNo: freezed == externalTxNo ? _self.externalTxNo : externalTxNo // ignore: cast_nullable_to_non_nullable
as String?,paymentProofUrl: freezed == paymentProofUrl ? _self.paymentProofUrl : paymentProofUrl // ignore: cast_nullable_to_non_nullable
as String?,userRemark: freezed == userRemark ? _self.userRemark : userRemark // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as String?,reviewRemark: freezed == reviewRemark ? _self.reviewRemark : reviewRemark // ignore: cast_nullable_to_non_nullable
as String?,creditedAt: freezed == creditedAt ? _self.creditedAt : creditedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RechargeOrder].
extension RechargeOrderPatterns on RechargeOrder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RechargeOrder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RechargeOrder() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RechargeOrder value)  $default,){
final _that = this;
switch (_that) {
case _RechargeOrder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RechargeOrder value)?  $default,){
final _that = this;
switch (_that) {
case _RechargeOrder() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? rechargeNo,  String? currency,  String? channelName,  String? network,  String? accountNo, @JsonKey(fromJson: _stringFromJson)  String? applyAmount, @JsonKey(fromJson: _stringFromJson)  String? actualAmount,  String? displayUrl,  String? channelQrCodeUrl,  String? externalTxNo,  String? paymentProofUrl,  String? userRemark,  String? status,  String? createdAt,  String? reviewedAt,  String? reviewRemark,  String? creditedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RechargeOrder() when $default != null:
return $default(_that.rechargeNo,_that.currency,_that.channelName,_that.network,_that.accountNo,_that.applyAmount,_that.actualAmount,_that.displayUrl,_that.channelQrCodeUrl,_that.externalTxNo,_that.paymentProofUrl,_that.userRemark,_that.status,_that.createdAt,_that.reviewedAt,_that.reviewRemark,_that.creditedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? rechargeNo,  String? currency,  String? channelName,  String? network,  String? accountNo, @JsonKey(fromJson: _stringFromJson)  String? applyAmount, @JsonKey(fromJson: _stringFromJson)  String? actualAmount,  String? displayUrl,  String? channelQrCodeUrl,  String? externalTxNo,  String? paymentProofUrl,  String? userRemark,  String? status,  String? createdAt,  String? reviewedAt,  String? reviewRemark,  String? creditedAt)  $default,) {final _that = this;
switch (_that) {
case _RechargeOrder():
return $default(_that.rechargeNo,_that.currency,_that.channelName,_that.network,_that.accountNo,_that.applyAmount,_that.actualAmount,_that.displayUrl,_that.channelQrCodeUrl,_that.externalTxNo,_that.paymentProofUrl,_that.userRemark,_that.status,_that.createdAt,_that.reviewedAt,_that.reviewRemark,_that.creditedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? rechargeNo,  String? currency,  String? channelName,  String? network,  String? accountNo, @JsonKey(fromJson: _stringFromJson)  String? applyAmount, @JsonKey(fromJson: _stringFromJson)  String? actualAmount,  String? displayUrl,  String? channelQrCodeUrl,  String? externalTxNo,  String? paymentProofUrl,  String? userRemark,  String? status,  String? createdAt,  String? reviewedAt,  String? reviewRemark,  String? creditedAt)?  $default,) {final _that = this;
switch (_that) {
case _RechargeOrder() when $default != null:
return $default(_that.rechargeNo,_that.currency,_that.channelName,_that.network,_that.accountNo,_that.applyAmount,_that.actualAmount,_that.displayUrl,_that.channelQrCodeUrl,_that.externalTxNo,_that.paymentProofUrl,_that.userRemark,_that.status,_that.createdAt,_that.reviewedAt,_that.reviewRemark,_that.creditedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RechargeOrder implements RechargeOrder {
  const _RechargeOrder({this.rechargeNo, this.currency, this.channelName, this.network, this.accountNo, @JsonKey(fromJson: _stringFromJson) this.applyAmount, @JsonKey(fromJson: _stringFromJson) this.actualAmount, this.displayUrl, this.channelQrCodeUrl, this.externalTxNo, this.paymentProofUrl, this.userRemark, this.status, this.createdAt, this.reviewedAt, this.reviewRemark, this.creditedAt});
  factory _RechargeOrder.fromJson(Map<String, dynamic> json) => _$RechargeOrderFromJson(json);

@override final  String? rechargeNo;
@override final  String? currency;
@override final  String? channelName;
@override final  String? network;
@override final  String? accountNo;
@override@JsonKey(fromJson: _stringFromJson) final  String? applyAmount;
@override@JsonKey(fromJson: _stringFromJson) final  String? actualAmount;
@override final  String? displayUrl;
@override final  String? channelQrCodeUrl;
@override final  String? externalTxNo;
@override final  String? paymentProofUrl;
@override final  String? userRemark;
@override final  String? status;
@override final  String? createdAt;
@override final  String? reviewedAt;
@override final  String? reviewRemark;
@override final  String? creditedAt;

/// Create a copy of RechargeOrder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RechargeOrderCopyWith<_RechargeOrder> get copyWith => __$RechargeOrderCopyWithImpl<_RechargeOrder>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RechargeOrderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RechargeOrder&&(identical(other.rechargeNo, rechargeNo) || other.rechargeNo == rechargeNo)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.channelName, channelName) || other.channelName == channelName)&&(identical(other.network, network) || other.network == network)&&(identical(other.accountNo, accountNo) || other.accountNo == accountNo)&&(identical(other.applyAmount, applyAmount) || other.applyAmount == applyAmount)&&(identical(other.actualAmount, actualAmount) || other.actualAmount == actualAmount)&&(identical(other.displayUrl, displayUrl) || other.displayUrl == displayUrl)&&(identical(other.channelQrCodeUrl, channelQrCodeUrl) || other.channelQrCodeUrl == channelQrCodeUrl)&&(identical(other.externalTxNo, externalTxNo) || other.externalTxNo == externalTxNo)&&(identical(other.paymentProofUrl, paymentProofUrl) || other.paymentProofUrl == paymentProofUrl)&&(identical(other.userRemark, userRemark) || other.userRemark == userRemark)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt)&&(identical(other.reviewRemark, reviewRemark) || other.reviewRemark == reviewRemark)&&(identical(other.creditedAt, creditedAt) || other.creditedAt == creditedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rechargeNo,currency,channelName,network,accountNo,applyAmount,actualAmount,displayUrl,channelQrCodeUrl,externalTxNo,paymentProofUrl,userRemark,status,createdAt,reviewedAt,reviewRemark,creditedAt);

@override
String toString() {
  return 'RechargeOrder(rechargeNo: $rechargeNo, currency: $currency, channelName: $channelName, network: $network, accountNo: $accountNo, applyAmount: $applyAmount, actualAmount: $actualAmount, displayUrl: $displayUrl, channelQrCodeUrl: $channelQrCodeUrl, externalTxNo: $externalTxNo, paymentProofUrl: $paymentProofUrl, userRemark: $userRemark, status: $status, createdAt: $createdAt, reviewedAt: $reviewedAt, reviewRemark: $reviewRemark, creditedAt: $creditedAt)';
}


}

/// @nodoc
abstract mixin class _$RechargeOrderCopyWith<$Res> implements $RechargeOrderCopyWith<$Res> {
  factory _$RechargeOrderCopyWith(_RechargeOrder value, $Res Function(_RechargeOrder) _then) = __$RechargeOrderCopyWithImpl;
@override @useResult
$Res call({
 String? rechargeNo, String? currency, String? channelName, String? network, String? accountNo,@JsonKey(fromJson: _stringFromJson) String? applyAmount,@JsonKey(fromJson: _stringFromJson) String? actualAmount, String? displayUrl, String? channelQrCodeUrl, String? externalTxNo, String? paymentProofUrl, String? userRemark, String? status, String? createdAt, String? reviewedAt, String? reviewRemark, String? creditedAt
});




}
/// @nodoc
class __$RechargeOrderCopyWithImpl<$Res>
    implements _$RechargeOrderCopyWith<$Res> {
  __$RechargeOrderCopyWithImpl(this._self, this._then);

  final _RechargeOrder _self;
  final $Res Function(_RechargeOrder) _then;

/// Create a copy of RechargeOrder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rechargeNo = freezed,Object? currency = freezed,Object? channelName = freezed,Object? network = freezed,Object? accountNo = freezed,Object? applyAmount = freezed,Object? actualAmount = freezed,Object? displayUrl = freezed,Object? channelQrCodeUrl = freezed,Object? externalTxNo = freezed,Object? paymentProofUrl = freezed,Object? userRemark = freezed,Object? status = freezed,Object? createdAt = freezed,Object? reviewedAt = freezed,Object? reviewRemark = freezed,Object? creditedAt = freezed,}) {
  return _then(_RechargeOrder(
rechargeNo: freezed == rechargeNo ? _self.rechargeNo : rechargeNo // ignore: cast_nullable_to_non_nullable
as String?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,channelName: freezed == channelName ? _self.channelName : channelName // ignore: cast_nullable_to_non_nullable
as String?,network: freezed == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String?,accountNo: freezed == accountNo ? _self.accountNo : accountNo // ignore: cast_nullable_to_non_nullable
as String?,applyAmount: freezed == applyAmount ? _self.applyAmount : applyAmount // ignore: cast_nullable_to_non_nullable
as String?,actualAmount: freezed == actualAmount ? _self.actualAmount : actualAmount // ignore: cast_nullable_to_non_nullable
as String?,displayUrl: freezed == displayUrl ? _self.displayUrl : displayUrl // ignore: cast_nullable_to_non_nullable
as String?,channelQrCodeUrl: freezed == channelQrCodeUrl ? _self.channelQrCodeUrl : channelQrCodeUrl // ignore: cast_nullable_to_non_nullable
as String?,externalTxNo: freezed == externalTxNo ? _self.externalTxNo : externalTxNo // ignore: cast_nullable_to_non_nullable
as String?,paymentProofUrl: freezed == paymentProofUrl ? _self.paymentProofUrl : paymentProofUrl // ignore: cast_nullable_to_non_nullable
as String?,userRemark: freezed == userRemark ? _self.userRemark : userRemark // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as String?,reviewRemark: freezed == reviewRemark ? _self.reviewRemark : reviewRemark // ignore: cast_nullable_to_non_nullable
as String?,creditedAt: freezed == creditedAt ? _self.creditedAt : creditedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$WithdrawAddress {

 int? get addressId; String? get network; String? get accountNo; String? get accountName; String? get label; bool? get defaultAddress; int? get status; String? get createdAt; String? get updatedAt;
/// Create a copy of WithdrawAddress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WithdrawAddressCopyWith<WithdrawAddress> get copyWith => _$WithdrawAddressCopyWithImpl<WithdrawAddress>(this as WithdrawAddress, _$identity);

  /// Serializes this WithdrawAddress to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WithdrawAddress&&(identical(other.addressId, addressId) || other.addressId == addressId)&&(identical(other.network, network) || other.network == network)&&(identical(other.accountNo, accountNo) || other.accountNo == accountNo)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.label, label) || other.label == label)&&(identical(other.defaultAddress, defaultAddress) || other.defaultAddress == defaultAddress)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,addressId,network,accountNo,accountName,label,defaultAddress,status,createdAt,updatedAt);

@override
String toString() {
  return 'WithdrawAddress(addressId: $addressId, network: $network, accountNo: $accountNo, accountName: $accountName, label: $label, defaultAddress: $defaultAddress, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $WithdrawAddressCopyWith<$Res>  {
  factory $WithdrawAddressCopyWith(WithdrawAddress value, $Res Function(WithdrawAddress) _then) = _$WithdrawAddressCopyWithImpl;
@useResult
$Res call({
 int? addressId, String? network, String? accountNo, String? accountName, String? label, bool? defaultAddress, int? status, String? createdAt, String? updatedAt
});




}
/// @nodoc
class _$WithdrawAddressCopyWithImpl<$Res>
    implements $WithdrawAddressCopyWith<$Res> {
  _$WithdrawAddressCopyWithImpl(this._self, this._then);

  final WithdrawAddress _self;
  final $Res Function(WithdrawAddress) _then;

/// Create a copy of WithdrawAddress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? addressId = freezed,Object? network = freezed,Object? accountNo = freezed,Object? accountName = freezed,Object? label = freezed,Object? defaultAddress = freezed,Object? status = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
addressId: freezed == addressId ? _self.addressId : addressId // ignore: cast_nullable_to_non_nullable
as int?,network: freezed == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String?,accountNo: freezed == accountNo ? _self.accountNo : accountNo // ignore: cast_nullable_to_non_nullable
as String?,accountName: freezed == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String?,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,defaultAddress: freezed == defaultAddress ? _self.defaultAddress : defaultAddress // ignore: cast_nullable_to_non_nullable
as bool?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WithdrawAddress].
extension WithdrawAddressPatterns on WithdrawAddress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WithdrawAddress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WithdrawAddress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WithdrawAddress value)  $default,){
final _that = this;
switch (_that) {
case _WithdrawAddress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WithdrawAddress value)?  $default,){
final _that = this;
switch (_that) {
case _WithdrawAddress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? addressId,  String? network,  String? accountNo,  String? accountName,  String? label,  bool? defaultAddress,  int? status,  String? createdAt,  String? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WithdrawAddress() when $default != null:
return $default(_that.addressId,_that.network,_that.accountNo,_that.accountName,_that.label,_that.defaultAddress,_that.status,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? addressId,  String? network,  String? accountNo,  String? accountName,  String? label,  bool? defaultAddress,  int? status,  String? createdAt,  String? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _WithdrawAddress():
return $default(_that.addressId,_that.network,_that.accountNo,_that.accountName,_that.label,_that.defaultAddress,_that.status,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? addressId,  String? network,  String? accountNo,  String? accountName,  String? label,  bool? defaultAddress,  int? status,  String? createdAt,  String? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _WithdrawAddress() when $default != null:
return $default(_that.addressId,_that.network,_that.accountNo,_that.accountName,_that.label,_that.defaultAddress,_that.status,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WithdrawAddress implements WithdrawAddress {
  const _WithdrawAddress({this.addressId, this.network, this.accountNo, this.accountName, this.label, this.defaultAddress, this.status, this.createdAt, this.updatedAt});
  factory _WithdrawAddress.fromJson(Map<String, dynamic> json) => _$WithdrawAddressFromJson(json);

@override final  int? addressId;
@override final  String? network;
@override final  String? accountNo;
@override final  String? accountName;
@override final  String? label;
@override final  bool? defaultAddress;
@override final  int? status;
@override final  String? createdAt;
@override final  String? updatedAt;

/// Create a copy of WithdrawAddress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WithdrawAddressCopyWith<_WithdrawAddress> get copyWith => __$WithdrawAddressCopyWithImpl<_WithdrawAddress>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WithdrawAddressToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WithdrawAddress&&(identical(other.addressId, addressId) || other.addressId == addressId)&&(identical(other.network, network) || other.network == network)&&(identical(other.accountNo, accountNo) || other.accountNo == accountNo)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.label, label) || other.label == label)&&(identical(other.defaultAddress, defaultAddress) || other.defaultAddress == defaultAddress)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,addressId,network,accountNo,accountName,label,defaultAddress,status,createdAt,updatedAt);

@override
String toString() {
  return 'WithdrawAddress(addressId: $addressId, network: $network, accountNo: $accountNo, accountName: $accountName, label: $label, defaultAddress: $defaultAddress, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$WithdrawAddressCopyWith<$Res> implements $WithdrawAddressCopyWith<$Res> {
  factory _$WithdrawAddressCopyWith(_WithdrawAddress value, $Res Function(_WithdrawAddress) _then) = __$WithdrawAddressCopyWithImpl;
@override @useResult
$Res call({
 int? addressId, String? network, String? accountNo, String? accountName, String? label, bool? defaultAddress, int? status, String? createdAt, String? updatedAt
});




}
/// @nodoc
class __$WithdrawAddressCopyWithImpl<$Res>
    implements _$WithdrawAddressCopyWith<$Res> {
  __$WithdrawAddressCopyWithImpl(this._self, this._then);

  final _WithdrawAddress _self;
  final $Res Function(_WithdrawAddress) _then;

/// Create a copy of WithdrawAddress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? addressId = freezed,Object? network = freezed,Object? accountNo = freezed,Object? accountName = freezed,Object? label = freezed,Object? defaultAddress = freezed,Object? status = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_WithdrawAddress(
addressId: freezed == addressId ? _self.addressId : addressId // ignore: cast_nullable_to_non_nullable
as int?,network: freezed == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String?,accountNo: freezed == accountNo ? _self.accountNo : accountNo // ignore: cast_nullable_to_non_nullable
as String?,accountName: freezed == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String?,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,defaultAddress: freezed == defaultAddress ? _self.defaultAddress : defaultAddress // ignore: cast_nullable_to_non_nullable
as bool?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$WithdrawOrder {

 String? get withdrawNo; String? get currency; String? get withdrawMethod; String? get network; String? get accountName; String? get accountNo;@JsonKey(fromJson: _stringFromJson) String? get applyAmount;@JsonKey(fromJson: _stringFromJson) String? get feeAmount;@JsonKey(fromJson: _stringFromJson) String? get actualAmount; String? get status; String? get createdAt; String? get reviewedAt; String? get reviewRemark; String? get paidAt;
/// Create a copy of WithdrawOrder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WithdrawOrderCopyWith<WithdrawOrder> get copyWith => _$WithdrawOrderCopyWithImpl<WithdrawOrder>(this as WithdrawOrder, _$identity);

  /// Serializes this WithdrawOrder to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WithdrawOrder&&(identical(other.withdrawNo, withdrawNo) || other.withdrawNo == withdrawNo)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.withdrawMethod, withdrawMethod) || other.withdrawMethod == withdrawMethod)&&(identical(other.network, network) || other.network == network)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.accountNo, accountNo) || other.accountNo == accountNo)&&(identical(other.applyAmount, applyAmount) || other.applyAmount == applyAmount)&&(identical(other.feeAmount, feeAmount) || other.feeAmount == feeAmount)&&(identical(other.actualAmount, actualAmount) || other.actualAmount == actualAmount)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt)&&(identical(other.reviewRemark, reviewRemark) || other.reviewRemark == reviewRemark)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,withdrawNo,currency,withdrawMethod,network,accountName,accountNo,applyAmount,feeAmount,actualAmount,status,createdAt,reviewedAt,reviewRemark,paidAt);

@override
String toString() {
  return 'WithdrawOrder(withdrawNo: $withdrawNo, currency: $currency, withdrawMethod: $withdrawMethod, network: $network, accountName: $accountName, accountNo: $accountNo, applyAmount: $applyAmount, feeAmount: $feeAmount, actualAmount: $actualAmount, status: $status, createdAt: $createdAt, reviewedAt: $reviewedAt, reviewRemark: $reviewRemark, paidAt: $paidAt)';
}


}

/// @nodoc
abstract mixin class $WithdrawOrderCopyWith<$Res>  {
  factory $WithdrawOrderCopyWith(WithdrawOrder value, $Res Function(WithdrawOrder) _then) = _$WithdrawOrderCopyWithImpl;
@useResult
$Res call({
 String? withdrawNo, String? currency, String? withdrawMethod, String? network, String? accountName, String? accountNo,@JsonKey(fromJson: _stringFromJson) String? applyAmount,@JsonKey(fromJson: _stringFromJson) String? feeAmount,@JsonKey(fromJson: _stringFromJson) String? actualAmount, String? status, String? createdAt, String? reviewedAt, String? reviewRemark, String? paidAt
});




}
/// @nodoc
class _$WithdrawOrderCopyWithImpl<$Res>
    implements $WithdrawOrderCopyWith<$Res> {
  _$WithdrawOrderCopyWithImpl(this._self, this._then);

  final WithdrawOrder _self;
  final $Res Function(WithdrawOrder) _then;

/// Create a copy of WithdrawOrder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? withdrawNo = freezed,Object? currency = freezed,Object? withdrawMethod = freezed,Object? network = freezed,Object? accountName = freezed,Object? accountNo = freezed,Object? applyAmount = freezed,Object? feeAmount = freezed,Object? actualAmount = freezed,Object? status = freezed,Object? createdAt = freezed,Object? reviewedAt = freezed,Object? reviewRemark = freezed,Object? paidAt = freezed,}) {
  return _then(_self.copyWith(
withdrawNo: freezed == withdrawNo ? _self.withdrawNo : withdrawNo // ignore: cast_nullable_to_non_nullable
as String?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,withdrawMethod: freezed == withdrawMethod ? _self.withdrawMethod : withdrawMethod // ignore: cast_nullable_to_non_nullable
as String?,network: freezed == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String?,accountName: freezed == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String?,accountNo: freezed == accountNo ? _self.accountNo : accountNo // ignore: cast_nullable_to_non_nullable
as String?,applyAmount: freezed == applyAmount ? _self.applyAmount : applyAmount // ignore: cast_nullable_to_non_nullable
as String?,feeAmount: freezed == feeAmount ? _self.feeAmount : feeAmount // ignore: cast_nullable_to_non_nullable
as String?,actualAmount: freezed == actualAmount ? _self.actualAmount : actualAmount // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as String?,reviewRemark: freezed == reviewRemark ? _self.reviewRemark : reviewRemark // ignore: cast_nullable_to_non_nullable
as String?,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WithdrawOrder].
extension WithdrawOrderPatterns on WithdrawOrder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WithdrawOrder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WithdrawOrder() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WithdrawOrder value)  $default,){
final _that = this;
switch (_that) {
case _WithdrawOrder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WithdrawOrder value)?  $default,){
final _that = this;
switch (_that) {
case _WithdrawOrder() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? withdrawNo,  String? currency,  String? withdrawMethod,  String? network,  String? accountName,  String? accountNo, @JsonKey(fromJson: _stringFromJson)  String? applyAmount, @JsonKey(fromJson: _stringFromJson)  String? feeAmount, @JsonKey(fromJson: _stringFromJson)  String? actualAmount,  String? status,  String? createdAt,  String? reviewedAt,  String? reviewRemark,  String? paidAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WithdrawOrder() when $default != null:
return $default(_that.withdrawNo,_that.currency,_that.withdrawMethod,_that.network,_that.accountName,_that.accountNo,_that.applyAmount,_that.feeAmount,_that.actualAmount,_that.status,_that.createdAt,_that.reviewedAt,_that.reviewRemark,_that.paidAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? withdrawNo,  String? currency,  String? withdrawMethod,  String? network,  String? accountName,  String? accountNo, @JsonKey(fromJson: _stringFromJson)  String? applyAmount, @JsonKey(fromJson: _stringFromJson)  String? feeAmount, @JsonKey(fromJson: _stringFromJson)  String? actualAmount,  String? status,  String? createdAt,  String? reviewedAt,  String? reviewRemark,  String? paidAt)  $default,) {final _that = this;
switch (_that) {
case _WithdrawOrder():
return $default(_that.withdrawNo,_that.currency,_that.withdrawMethod,_that.network,_that.accountName,_that.accountNo,_that.applyAmount,_that.feeAmount,_that.actualAmount,_that.status,_that.createdAt,_that.reviewedAt,_that.reviewRemark,_that.paidAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? withdrawNo,  String? currency,  String? withdrawMethod,  String? network,  String? accountName,  String? accountNo, @JsonKey(fromJson: _stringFromJson)  String? applyAmount, @JsonKey(fromJson: _stringFromJson)  String? feeAmount, @JsonKey(fromJson: _stringFromJson)  String? actualAmount,  String? status,  String? createdAt,  String? reviewedAt,  String? reviewRemark,  String? paidAt)?  $default,) {final _that = this;
switch (_that) {
case _WithdrawOrder() when $default != null:
return $default(_that.withdrawNo,_that.currency,_that.withdrawMethod,_that.network,_that.accountName,_that.accountNo,_that.applyAmount,_that.feeAmount,_that.actualAmount,_that.status,_that.createdAt,_that.reviewedAt,_that.reviewRemark,_that.paidAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WithdrawOrder implements WithdrawOrder {
  const _WithdrawOrder({this.withdrawNo, this.currency, this.withdrawMethod, this.network, this.accountName, this.accountNo, @JsonKey(fromJson: _stringFromJson) this.applyAmount, @JsonKey(fromJson: _stringFromJson) this.feeAmount, @JsonKey(fromJson: _stringFromJson) this.actualAmount, this.status, this.createdAt, this.reviewedAt, this.reviewRemark, this.paidAt});
  factory _WithdrawOrder.fromJson(Map<String, dynamic> json) => _$WithdrawOrderFromJson(json);

@override final  String? withdrawNo;
@override final  String? currency;
@override final  String? withdrawMethod;
@override final  String? network;
@override final  String? accountName;
@override final  String? accountNo;
@override@JsonKey(fromJson: _stringFromJson) final  String? applyAmount;
@override@JsonKey(fromJson: _stringFromJson) final  String? feeAmount;
@override@JsonKey(fromJson: _stringFromJson) final  String? actualAmount;
@override final  String? status;
@override final  String? createdAt;
@override final  String? reviewedAt;
@override final  String? reviewRemark;
@override final  String? paidAt;

/// Create a copy of WithdrawOrder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WithdrawOrderCopyWith<_WithdrawOrder> get copyWith => __$WithdrawOrderCopyWithImpl<_WithdrawOrder>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WithdrawOrderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WithdrawOrder&&(identical(other.withdrawNo, withdrawNo) || other.withdrawNo == withdrawNo)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.withdrawMethod, withdrawMethod) || other.withdrawMethod == withdrawMethod)&&(identical(other.network, network) || other.network == network)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.accountNo, accountNo) || other.accountNo == accountNo)&&(identical(other.applyAmount, applyAmount) || other.applyAmount == applyAmount)&&(identical(other.feeAmount, feeAmount) || other.feeAmount == feeAmount)&&(identical(other.actualAmount, actualAmount) || other.actualAmount == actualAmount)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt)&&(identical(other.reviewRemark, reviewRemark) || other.reviewRemark == reviewRemark)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,withdrawNo,currency,withdrawMethod,network,accountName,accountNo,applyAmount,feeAmount,actualAmount,status,createdAt,reviewedAt,reviewRemark,paidAt);

@override
String toString() {
  return 'WithdrawOrder(withdrawNo: $withdrawNo, currency: $currency, withdrawMethod: $withdrawMethod, network: $network, accountName: $accountName, accountNo: $accountNo, applyAmount: $applyAmount, feeAmount: $feeAmount, actualAmount: $actualAmount, status: $status, createdAt: $createdAt, reviewedAt: $reviewedAt, reviewRemark: $reviewRemark, paidAt: $paidAt)';
}


}

/// @nodoc
abstract mixin class _$WithdrawOrderCopyWith<$Res> implements $WithdrawOrderCopyWith<$Res> {
  factory _$WithdrawOrderCopyWith(_WithdrawOrder value, $Res Function(_WithdrawOrder) _then) = __$WithdrawOrderCopyWithImpl;
@override @useResult
$Res call({
 String? withdrawNo, String? currency, String? withdrawMethod, String? network, String? accountName, String? accountNo,@JsonKey(fromJson: _stringFromJson) String? applyAmount,@JsonKey(fromJson: _stringFromJson) String? feeAmount,@JsonKey(fromJson: _stringFromJson) String? actualAmount, String? status, String? createdAt, String? reviewedAt, String? reviewRemark, String? paidAt
});




}
/// @nodoc
class __$WithdrawOrderCopyWithImpl<$Res>
    implements _$WithdrawOrderCopyWith<$Res> {
  __$WithdrawOrderCopyWithImpl(this._self, this._then);

  final _WithdrawOrder _self;
  final $Res Function(_WithdrawOrder) _then;

/// Create a copy of WithdrawOrder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? withdrawNo = freezed,Object? currency = freezed,Object? withdrawMethod = freezed,Object? network = freezed,Object? accountName = freezed,Object? accountNo = freezed,Object? applyAmount = freezed,Object? feeAmount = freezed,Object? actualAmount = freezed,Object? status = freezed,Object? createdAt = freezed,Object? reviewedAt = freezed,Object? reviewRemark = freezed,Object? paidAt = freezed,}) {
  return _then(_WithdrawOrder(
withdrawNo: freezed == withdrawNo ? _self.withdrawNo : withdrawNo // ignore: cast_nullable_to_non_nullable
as String?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,withdrawMethod: freezed == withdrawMethod ? _self.withdrawMethod : withdrawMethod // ignore: cast_nullable_to_non_nullable
as String?,network: freezed == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String?,accountName: freezed == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String?,accountNo: freezed == accountNo ? _self.accountNo : accountNo // ignore: cast_nullable_to_non_nullable
as String?,applyAmount: freezed == applyAmount ? _self.applyAmount : applyAmount // ignore: cast_nullable_to_non_nullable
as String?,feeAmount: freezed == feeAmount ? _self.feeAmount : feeAmount // ignore: cast_nullable_to_non_nullable
as String?,actualAmount: freezed == actualAmount ? _self.actualAmount : actualAmount // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as String?,reviewRemark: freezed == reviewRemark ? _self.reviewRemark : reviewRemark // ignore: cast_nullable_to_non_nullable
as String?,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ProfitSummary {

@JsonKey(fromJson: _stringFromJson) String? get totalProfit;@JsonKey(fromJson: _stringFromJson) String? get todayProfit;@JsonKey(fromJson: _stringFromJson) String? get yesterdayProfit;@JsonKey(fromJson: _stringFromJson) String? get currentMonthProfit; int? get settledProfitCount;
/// Create a copy of ProfitSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfitSummaryCopyWith<ProfitSummary> get copyWith => _$ProfitSummaryCopyWithImpl<ProfitSummary>(this as ProfitSummary, _$identity);

  /// Serializes this ProfitSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfitSummary&&(identical(other.totalProfit, totalProfit) || other.totalProfit == totalProfit)&&(identical(other.todayProfit, todayProfit) || other.todayProfit == todayProfit)&&(identical(other.yesterdayProfit, yesterdayProfit) || other.yesterdayProfit == yesterdayProfit)&&(identical(other.currentMonthProfit, currentMonthProfit) || other.currentMonthProfit == currentMonthProfit)&&(identical(other.settledProfitCount, settledProfitCount) || other.settledProfitCount == settledProfitCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalProfit,todayProfit,yesterdayProfit,currentMonthProfit,settledProfitCount);

@override
String toString() {
  return 'ProfitSummary(totalProfit: $totalProfit, todayProfit: $todayProfit, yesterdayProfit: $yesterdayProfit, currentMonthProfit: $currentMonthProfit, settledProfitCount: $settledProfitCount)';
}


}

/// @nodoc
abstract mixin class $ProfitSummaryCopyWith<$Res>  {
  factory $ProfitSummaryCopyWith(ProfitSummary value, $Res Function(ProfitSummary) _then) = _$ProfitSummaryCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _stringFromJson) String? totalProfit,@JsonKey(fromJson: _stringFromJson) String? todayProfit,@JsonKey(fromJson: _stringFromJson) String? yesterdayProfit,@JsonKey(fromJson: _stringFromJson) String? currentMonthProfit, int? settledProfitCount
});




}
/// @nodoc
class _$ProfitSummaryCopyWithImpl<$Res>
    implements $ProfitSummaryCopyWith<$Res> {
  _$ProfitSummaryCopyWithImpl(this._self, this._then);

  final ProfitSummary _self;
  final $Res Function(ProfitSummary) _then;

/// Create a copy of ProfitSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalProfit = freezed,Object? todayProfit = freezed,Object? yesterdayProfit = freezed,Object? currentMonthProfit = freezed,Object? settledProfitCount = freezed,}) {
  return _then(_self.copyWith(
totalProfit: freezed == totalProfit ? _self.totalProfit : totalProfit // ignore: cast_nullable_to_non_nullable
as String?,todayProfit: freezed == todayProfit ? _self.todayProfit : todayProfit // ignore: cast_nullable_to_non_nullable
as String?,yesterdayProfit: freezed == yesterdayProfit ? _self.yesterdayProfit : yesterdayProfit // ignore: cast_nullable_to_non_nullable
as String?,currentMonthProfit: freezed == currentMonthProfit ? _self.currentMonthProfit : currentMonthProfit // ignore: cast_nullable_to_non_nullable
as String?,settledProfitCount: freezed == settledProfitCount ? _self.settledProfitCount : settledProfitCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfitSummary].
extension ProfitSummaryPatterns on ProfitSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfitSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfitSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfitSummary value)  $default,){
final _that = this;
switch (_that) {
case _ProfitSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfitSummary value)?  $default,){
final _that = this;
switch (_that) {
case _ProfitSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _stringFromJson)  String? totalProfit, @JsonKey(fromJson: _stringFromJson)  String? todayProfit, @JsonKey(fromJson: _stringFromJson)  String? yesterdayProfit, @JsonKey(fromJson: _stringFromJson)  String? currentMonthProfit,  int? settledProfitCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfitSummary() when $default != null:
return $default(_that.totalProfit,_that.todayProfit,_that.yesterdayProfit,_that.currentMonthProfit,_that.settledProfitCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _stringFromJson)  String? totalProfit, @JsonKey(fromJson: _stringFromJson)  String? todayProfit, @JsonKey(fromJson: _stringFromJson)  String? yesterdayProfit, @JsonKey(fromJson: _stringFromJson)  String? currentMonthProfit,  int? settledProfitCount)  $default,) {final _that = this;
switch (_that) {
case _ProfitSummary():
return $default(_that.totalProfit,_that.todayProfit,_that.yesterdayProfit,_that.currentMonthProfit,_that.settledProfitCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: _stringFromJson)  String? totalProfit, @JsonKey(fromJson: _stringFromJson)  String? todayProfit, @JsonKey(fromJson: _stringFromJson)  String? yesterdayProfit, @JsonKey(fromJson: _stringFromJson)  String? currentMonthProfit,  int? settledProfitCount)?  $default,) {final _that = this;
switch (_that) {
case _ProfitSummary() when $default != null:
return $default(_that.totalProfit,_that.todayProfit,_that.yesterdayProfit,_that.currentMonthProfit,_that.settledProfitCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfitSummary implements ProfitSummary {
  const _ProfitSummary({@JsonKey(fromJson: _stringFromJson) this.totalProfit, @JsonKey(fromJson: _stringFromJson) this.todayProfit, @JsonKey(fromJson: _stringFromJson) this.yesterdayProfit, @JsonKey(fromJson: _stringFromJson) this.currentMonthProfit, this.settledProfitCount});
  factory _ProfitSummary.fromJson(Map<String, dynamic> json) => _$ProfitSummaryFromJson(json);

@override@JsonKey(fromJson: _stringFromJson) final  String? totalProfit;
@override@JsonKey(fromJson: _stringFromJson) final  String? todayProfit;
@override@JsonKey(fromJson: _stringFromJson) final  String? yesterdayProfit;
@override@JsonKey(fromJson: _stringFromJson) final  String? currentMonthProfit;
@override final  int? settledProfitCount;

/// Create a copy of ProfitSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfitSummaryCopyWith<_ProfitSummary> get copyWith => __$ProfitSummaryCopyWithImpl<_ProfitSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfitSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfitSummary&&(identical(other.totalProfit, totalProfit) || other.totalProfit == totalProfit)&&(identical(other.todayProfit, todayProfit) || other.todayProfit == todayProfit)&&(identical(other.yesterdayProfit, yesterdayProfit) || other.yesterdayProfit == yesterdayProfit)&&(identical(other.currentMonthProfit, currentMonthProfit) || other.currentMonthProfit == currentMonthProfit)&&(identical(other.settledProfitCount, settledProfitCount) || other.settledProfitCount == settledProfitCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalProfit,todayProfit,yesterdayProfit,currentMonthProfit,settledProfitCount);

@override
String toString() {
  return 'ProfitSummary(totalProfit: $totalProfit, todayProfit: $todayProfit, yesterdayProfit: $yesterdayProfit, currentMonthProfit: $currentMonthProfit, settledProfitCount: $settledProfitCount)';
}


}

/// @nodoc
abstract mixin class _$ProfitSummaryCopyWith<$Res> implements $ProfitSummaryCopyWith<$Res> {
  factory _$ProfitSummaryCopyWith(_ProfitSummary value, $Res Function(_ProfitSummary) _then) = __$ProfitSummaryCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _stringFromJson) String? totalProfit,@JsonKey(fromJson: _stringFromJson) String? todayProfit,@JsonKey(fromJson: _stringFromJson) String? yesterdayProfit,@JsonKey(fromJson: _stringFromJson) String? currentMonthProfit, int? settledProfitCount
});




}
/// @nodoc
class __$ProfitSummaryCopyWithImpl<$Res>
    implements _$ProfitSummaryCopyWith<$Res> {
  __$ProfitSummaryCopyWithImpl(this._self, this._then);

  final _ProfitSummary _self;
  final $Res Function(_ProfitSummary) _then;

/// Create a copy of ProfitSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalProfit = freezed,Object? todayProfit = freezed,Object? yesterdayProfit = freezed,Object? currentMonthProfit = freezed,Object? settledProfitCount = freezed,}) {
  return _then(_ProfitSummary(
totalProfit: freezed == totalProfit ? _self.totalProfit : totalProfit // ignore: cast_nullable_to_non_nullable
as String?,todayProfit: freezed == todayProfit ? _self.todayProfit : todayProfit // ignore: cast_nullable_to_non_nullable
as String?,yesterdayProfit: freezed == yesterdayProfit ? _self.yesterdayProfit : yesterdayProfit // ignore: cast_nullable_to_non_nullable
as String?,currentMonthProfit: freezed == currentMonthProfit ? _self.currentMonthProfit : currentMonthProfit // ignore: cast_nullable_to_non_nullable
as String?,settledProfitCount: freezed == settledProfitCount ? _self.settledProfitCount : settledProfitCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$TodayEstimate {

@JsonKey(fromJson: _stringFromJson) String? get estimatedProfit; String? get calculatedAt; int? get orderCount; String? get currency;
/// Create a copy of TodayEstimate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodayEstimateCopyWith<TodayEstimate> get copyWith => _$TodayEstimateCopyWithImpl<TodayEstimate>(this as TodayEstimate, _$identity);

  /// Serializes this TodayEstimate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodayEstimate&&(identical(other.estimatedProfit, estimatedProfit) || other.estimatedProfit == estimatedProfit)&&(identical(other.calculatedAt, calculatedAt) || other.calculatedAt == calculatedAt)&&(identical(other.orderCount, orderCount) || other.orderCount == orderCount)&&(identical(other.currency, currency) || other.currency == currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,estimatedProfit,calculatedAt,orderCount,currency);

@override
String toString() {
  return 'TodayEstimate(estimatedProfit: $estimatedProfit, calculatedAt: $calculatedAt, orderCount: $orderCount, currency: $currency)';
}


}

/// @nodoc
abstract mixin class $TodayEstimateCopyWith<$Res>  {
  factory $TodayEstimateCopyWith(TodayEstimate value, $Res Function(TodayEstimate) _then) = _$TodayEstimateCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _stringFromJson) String? estimatedProfit, String? calculatedAt, int? orderCount, String? currency
});




}
/// @nodoc
class _$TodayEstimateCopyWithImpl<$Res>
    implements $TodayEstimateCopyWith<$Res> {
  _$TodayEstimateCopyWithImpl(this._self, this._then);

  final TodayEstimate _self;
  final $Res Function(TodayEstimate) _then;

/// Create a copy of TodayEstimate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? estimatedProfit = freezed,Object? calculatedAt = freezed,Object? orderCount = freezed,Object? currency = freezed,}) {
  return _then(_self.copyWith(
estimatedProfit: freezed == estimatedProfit ? _self.estimatedProfit : estimatedProfit // ignore: cast_nullable_to_non_nullable
as String?,calculatedAt: freezed == calculatedAt ? _self.calculatedAt : calculatedAt // ignore: cast_nullable_to_non_nullable
as String?,orderCount: freezed == orderCount ? _self.orderCount : orderCount // ignore: cast_nullable_to_non_nullable
as int?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TodayEstimate].
extension TodayEstimatePatterns on TodayEstimate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TodayEstimate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodayEstimate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TodayEstimate value)  $default,){
final _that = this;
switch (_that) {
case _TodayEstimate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TodayEstimate value)?  $default,){
final _that = this;
switch (_that) {
case _TodayEstimate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _stringFromJson)  String? estimatedProfit,  String? calculatedAt,  int? orderCount,  String? currency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodayEstimate() when $default != null:
return $default(_that.estimatedProfit,_that.calculatedAt,_that.orderCount,_that.currency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _stringFromJson)  String? estimatedProfit,  String? calculatedAt,  int? orderCount,  String? currency)  $default,) {final _that = this;
switch (_that) {
case _TodayEstimate():
return $default(_that.estimatedProfit,_that.calculatedAt,_that.orderCount,_that.currency);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: _stringFromJson)  String? estimatedProfit,  String? calculatedAt,  int? orderCount,  String? currency)?  $default,) {final _that = this;
switch (_that) {
case _TodayEstimate() when $default != null:
return $default(_that.estimatedProfit,_that.calculatedAt,_that.orderCount,_that.currency);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TodayEstimate implements TodayEstimate {
  const _TodayEstimate({@JsonKey(fromJson: _stringFromJson) this.estimatedProfit, this.calculatedAt, this.orderCount, this.currency});
  factory _TodayEstimate.fromJson(Map<String, dynamic> json) => _$TodayEstimateFromJson(json);

@override@JsonKey(fromJson: _stringFromJson) final  String? estimatedProfit;
@override final  String? calculatedAt;
@override final  int? orderCount;
@override final  String? currency;

/// Create a copy of TodayEstimate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodayEstimateCopyWith<_TodayEstimate> get copyWith => __$TodayEstimateCopyWithImpl<_TodayEstimate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TodayEstimateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodayEstimate&&(identical(other.estimatedProfit, estimatedProfit) || other.estimatedProfit == estimatedProfit)&&(identical(other.calculatedAt, calculatedAt) || other.calculatedAt == calculatedAt)&&(identical(other.orderCount, orderCount) || other.orderCount == orderCount)&&(identical(other.currency, currency) || other.currency == currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,estimatedProfit,calculatedAt,orderCount,currency);

@override
String toString() {
  return 'TodayEstimate(estimatedProfit: $estimatedProfit, calculatedAt: $calculatedAt, orderCount: $orderCount, currency: $currency)';
}


}

/// @nodoc
abstract mixin class _$TodayEstimateCopyWith<$Res> implements $TodayEstimateCopyWith<$Res> {
  factory _$TodayEstimateCopyWith(_TodayEstimate value, $Res Function(_TodayEstimate) _then) = __$TodayEstimateCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _stringFromJson) String? estimatedProfit, String? calculatedAt, int? orderCount, String? currency
});




}
/// @nodoc
class __$TodayEstimateCopyWithImpl<$Res>
    implements _$TodayEstimateCopyWith<$Res> {
  __$TodayEstimateCopyWithImpl(this._self, this._then);

  final _TodayEstimate _self;
  final $Res Function(_TodayEstimate) _then;

/// Create a copy of TodayEstimate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? estimatedProfit = freezed,Object? calculatedAt = freezed,Object? orderCount = freezed,Object? currency = freezed,}) {
  return _then(_TodayEstimate(
estimatedProfit: freezed == estimatedProfit ? _self.estimatedProfit : estimatedProfit // ignore: cast_nullable_to_non_nullable
as String?,calculatedAt: freezed == calculatedAt ? _self.calculatedAt : calculatedAt // ignore: cast_nullable_to_non_nullable
as String?,orderCount: freezed == orderCount ? _self.orderCount : orderCount // ignore: cast_nullable_to_non_nullable
as int?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ProfitTrendPoint {

 String? get profitDate;@JsonKey(fromJson: _stringFromJson) String? get finalProfitAmount; int? get recordCount;
/// Create a copy of ProfitTrendPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfitTrendPointCopyWith<ProfitTrendPoint> get copyWith => _$ProfitTrendPointCopyWithImpl<ProfitTrendPoint>(this as ProfitTrendPoint, _$identity);

  /// Serializes this ProfitTrendPoint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfitTrendPoint&&(identical(other.profitDate, profitDate) || other.profitDate == profitDate)&&(identical(other.finalProfitAmount, finalProfitAmount) || other.finalProfitAmount == finalProfitAmount)&&(identical(other.recordCount, recordCount) || other.recordCount == recordCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,profitDate,finalProfitAmount,recordCount);

@override
String toString() {
  return 'ProfitTrendPoint(profitDate: $profitDate, finalProfitAmount: $finalProfitAmount, recordCount: $recordCount)';
}


}

/// @nodoc
abstract mixin class $ProfitTrendPointCopyWith<$Res>  {
  factory $ProfitTrendPointCopyWith(ProfitTrendPoint value, $Res Function(ProfitTrendPoint) _then) = _$ProfitTrendPointCopyWithImpl;
@useResult
$Res call({
 String? profitDate,@JsonKey(fromJson: _stringFromJson) String? finalProfitAmount, int? recordCount
});




}
/// @nodoc
class _$ProfitTrendPointCopyWithImpl<$Res>
    implements $ProfitTrendPointCopyWith<$Res> {
  _$ProfitTrendPointCopyWithImpl(this._self, this._then);

  final ProfitTrendPoint _self;
  final $Res Function(ProfitTrendPoint) _then;

/// Create a copy of ProfitTrendPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profitDate = freezed,Object? finalProfitAmount = freezed,Object? recordCount = freezed,}) {
  return _then(_self.copyWith(
profitDate: freezed == profitDate ? _self.profitDate : profitDate // ignore: cast_nullable_to_non_nullable
as String?,finalProfitAmount: freezed == finalProfitAmount ? _self.finalProfitAmount : finalProfitAmount // ignore: cast_nullable_to_non_nullable
as String?,recordCount: freezed == recordCount ? _self.recordCount : recordCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfitTrendPoint].
extension ProfitTrendPointPatterns on ProfitTrendPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfitTrendPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfitTrendPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfitTrendPoint value)  $default,){
final _that = this;
switch (_that) {
case _ProfitTrendPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfitTrendPoint value)?  $default,){
final _that = this;
switch (_that) {
case _ProfitTrendPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? profitDate, @JsonKey(fromJson: _stringFromJson)  String? finalProfitAmount,  int? recordCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfitTrendPoint() when $default != null:
return $default(_that.profitDate,_that.finalProfitAmount,_that.recordCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? profitDate, @JsonKey(fromJson: _stringFromJson)  String? finalProfitAmount,  int? recordCount)  $default,) {final _that = this;
switch (_that) {
case _ProfitTrendPoint():
return $default(_that.profitDate,_that.finalProfitAmount,_that.recordCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? profitDate, @JsonKey(fromJson: _stringFromJson)  String? finalProfitAmount,  int? recordCount)?  $default,) {final _that = this;
switch (_that) {
case _ProfitTrendPoint() when $default != null:
return $default(_that.profitDate,_that.finalProfitAmount,_that.recordCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfitTrendPoint implements ProfitTrendPoint {
  const _ProfitTrendPoint({this.profitDate, @JsonKey(fromJson: _stringFromJson) this.finalProfitAmount, this.recordCount});
  factory _ProfitTrendPoint.fromJson(Map<String, dynamic> json) => _$ProfitTrendPointFromJson(json);

@override final  String? profitDate;
@override@JsonKey(fromJson: _stringFromJson) final  String? finalProfitAmount;
@override final  int? recordCount;

/// Create a copy of ProfitTrendPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfitTrendPointCopyWith<_ProfitTrendPoint> get copyWith => __$ProfitTrendPointCopyWithImpl<_ProfitTrendPoint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfitTrendPointToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfitTrendPoint&&(identical(other.profitDate, profitDate) || other.profitDate == profitDate)&&(identical(other.finalProfitAmount, finalProfitAmount) || other.finalProfitAmount == finalProfitAmount)&&(identical(other.recordCount, recordCount) || other.recordCount == recordCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,profitDate,finalProfitAmount,recordCount);

@override
String toString() {
  return 'ProfitTrendPoint(profitDate: $profitDate, finalProfitAmount: $finalProfitAmount, recordCount: $recordCount)';
}


}

/// @nodoc
abstract mixin class _$ProfitTrendPointCopyWith<$Res> implements $ProfitTrendPointCopyWith<$Res> {
  factory _$ProfitTrendPointCopyWith(_ProfitTrendPoint value, $Res Function(_ProfitTrendPoint) _then) = __$ProfitTrendPointCopyWithImpl;
@override @useResult
$Res call({
 String? profitDate,@JsonKey(fromJson: _stringFromJson) String? finalProfitAmount, int? recordCount
});




}
/// @nodoc
class __$ProfitTrendPointCopyWithImpl<$Res>
    implements _$ProfitTrendPointCopyWith<$Res> {
  __$ProfitTrendPointCopyWithImpl(this._self, this._then);

  final _ProfitTrendPoint _self;
  final $Res Function(_ProfitTrendPoint) _then;

/// Create a copy of ProfitTrendPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profitDate = freezed,Object? finalProfitAmount = freezed,Object? recordCount = freezed,}) {
  return _then(_ProfitTrendPoint(
profitDate: freezed == profitDate ? _self.profitDate : profitDate // ignore: cast_nullable_to_non_nullable
as String?,finalProfitAmount: freezed == finalProfitAmount ? _self.finalProfitAmount : finalProfitAmount // ignore: cast_nullable_to_non_nullable
as String?,recordCount: freezed == recordCount ? _self.recordCount : recordCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$ProfitRecord {

 String? get productNameSnapshot; String? get aiModelNameSnapshot; String? get profitDate; int? get effectiveMinutes; String? get periodStartAt; String? get periodEndAt;@JsonKey(fromJson: _stringFromJson) String? get baseProfitAmount;@JsonKey(fromJson: _stringFromJson) String? get finalProfitAmount; String? get status;@JsonKey(fromJson: _stringFromJson) String? get settledTokenAmount; int? get commissionGenerated; String? get settledAt;
/// Create a copy of ProfitRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfitRecordCopyWith<ProfitRecord> get copyWith => _$ProfitRecordCopyWithImpl<ProfitRecord>(this as ProfitRecord, _$identity);

  /// Serializes this ProfitRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfitRecord&&(identical(other.productNameSnapshot, productNameSnapshot) || other.productNameSnapshot == productNameSnapshot)&&(identical(other.aiModelNameSnapshot, aiModelNameSnapshot) || other.aiModelNameSnapshot == aiModelNameSnapshot)&&(identical(other.profitDate, profitDate) || other.profitDate == profitDate)&&(identical(other.effectiveMinutes, effectiveMinutes) || other.effectiveMinutes == effectiveMinutes)&&(identical(other.periodStartAt, periodStartAt) || other.periodStartAt == periodStartAt)&&(identical(other.periodEndAt, periodEndAt) || other.periodEndAt == periodEndAt)&&(identical(other.baseProfitAmount, baseProfitAmount) || other.baseProfitAmount == baseProfitAmount)&&(identical(other.finalProfitAmount, finalProfitAmount) || other.finalProfitAmount == finalProfitAmount)&&(identical(other.status, status) || other.status == status)&&(identical(other.settledTokenAmount, settledTokenAmount) || other.settledTokenAmount == settledTokenAmount)&&(identical(other.commissionGenerated, commissionGenerated) || other.commissionGenerated == commissionGenerated)&&(identical(other.settledAt, settledAt) || other.settledAt == settledAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productNameSnapshot,aiModelNameSnapshot,profitDate,effectiveMinutes,periodStartAt,periodEndAt,baseProfitAmount,finalProfitAmount,status,settledTokenAmount,commissionGenerated,settledAt);

@override
String toString() {
  return 'ProfitRecord(productNameSnapshot: $productNameSnapshot, aiModelNameSnapshot: $aiModelNameSnapshot, profitDate: $profitDate, effectiveMinutes: $effectiveMinutes, periodStartAt: $periodStartAt, periodEndAt: $periodEndAt, baseProfitAmount: $baseProfitAmount, finalProfitAmount: $finalProfitAmount, status: $status, settledTokenAmount: $settledTokenAmount, commissionGenerated: $commissionGenerated, settledAt: $settledAt)';
}


}

/// @nodoc
abstract mixin class $ProfitRecordCopyWith<$Res>  {
  factory $ProfitRecordCopyWith(ProfitRecord value, $Res Function(ProfitRecord) _then) = _$ProfitRecordCopyWithImpl;
@useResult
$Res call({
 String? productNameSnapshot, String? aiModelNameSnapshot, String? profitDate, int? effectiveMinutes, String? periodStartAt, String? periodEndAt,@JsonKey(fromJson: _stringFromJson) String? baseProfitAmount,@JsonKey(fromJson: _stringFromJson) String? finalProfitAmount, String? status,@JsonKey(fromJson: _stringFromJson) String? settledTokenAmount, int? commissionGenerated, String? settledAt
});




}
/// @nodoc
class _$ProfitRecordCopyWithImpl<$Res>
    implements $ProfitRecordCopyWith<$Res> {
  _$ProfitRecordCopyWithImpl(this._self, this._then);

  final ProfitRecord _self;
  final $Res Function(ProfitRecord) _then;

/// Create a copy of ProfitRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productNameSnapshot = freezed,Object? aiModelNameSnapshot = freezed,Object? profitDate = freezed,Object? effectiveMinutes = freezed,Object? periodStartAt = freezed,Object? periodEndAt = freezed,Object? baseProfitAmount = freezed,Object? finalProfitAmount = freezed,Object? status = freezed,Object? settledTokenAmount = freezed,Object? commissionGenerated = freezed,Object? settledAt = freezed,}) {
  return _then(_self.copyWith(
productNameSnapshot: freezed == productNameSnapshot ? _self.productNameSnapshot : productNameSnapshot // ignore: cast_nullable_to_non_nullable
as String?,aiModelNameSnapshot: freezed == aiModelNameSnapshot ? _self.aiModelNameSnapshot : aiModelNameSnapshot // ignore: cast_nullable_to_non_nullable
as String?,profitDate: freezed == profitDate ? _self.profitDate : profitDate // ignore: cast_nullable_to_non_nullable
as String?,effectiveMinutes: freezed == effectiveMinutes ? _self.effectiveMinutes : effectiveMinutes // ignore: cast_nullable_to_non_nullable
as int?,periodStartAt: freezed == periodStartAt ? _self.periodStartAt : periodStartAt // ignore: cast_nullable_to_non_nullable
as String?,periodEndAt: freezed == periodEndAt ? _self.periodEndAt : periodEndAt // ignore: cast_nullable_to_non_nullable
as String?,baseProfitAmount: freezed == baseProfitAmount ? _self.baseProfitAmount : baseProfitAmount // ignore: cast_nullable_to_non_nullable
as String?,finalProfitAmount: freezed == finalProfitAmount ? _self.finalProfitAmount : finalProfitAmount // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,settledTokenAmount: freezed == settledTokenAmount ? _self.settledTokenAmount : settledTokenAmount // ignore: cast_nullable_to_non_nullable
as String?,commissionGenerated: freezed == commissionGenerated ? _self.commissionGenerated : commissionGenerated // ignore: cast_nullable_to_non_nullable
as int?,settledAt: freezed == settledAt ? _self.settledAt : settledAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfitRecord].
extension ProfitRecordPatterns on ProfitRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfitRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfitRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfitRecord value)  $default,){
final _that = this;
switch (_that) {
case _ProfitRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfitRecord value)?  $default,){
final _that = this;
switch (_that) {
case _ProfitRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? productNameSnapshot,  String? aiModelNameSnapshot,  String? profitDate,  int? effectiveMinutes,  String? periodStartAt,  String? periodEndAt, @JsonKey(fromJson: _stringFromJson)  String? baseProfitAmount, @JsonKey(fromJson: _stringFromJson)  String? finalProfitAmount,  String? status, @JsonKey(fromJson: _stringFromJson)  String? settledTokenAmount,  int? commissionGenerated,  String? settledAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfitRecord() when $default != null:
return $default(_that.productNameSnapshot,_that.aiModelNameSnapshot,_that.profitDate,_that.effectiveMinutes,_that.periodStartAt,_that.periodEndAt,_that.baseProfitAmount,_that.finalProfitAmount,_that.status,_that.settledTokenAmount,_that.commissionGenerated,_that.settledAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? productNameSnapshot,  String? aiModelNameSnapshot,  String? profitDate,  int? effectiveMinutes,  String? periodStartAt,  String? periodEndAt, @JsonKey(fromJson: _stringFromJson)  String? baseProfitAmount, @JsonKey(fromJson: _stringFromJson)  String? finalProfitAmount,  String? status, @JsonKey(fromJson: _stringFromJson)  String? settledTokenAmount,  int? commissionGenerated,  String? settledAt)  $default,) {final _that = this;
switch (_that) {
case _ProfitRecord():
return $default(_that.productNameSnapshot,_that.aiModelNameSnapshot,_that.profitDate,_that.effectiveMinutes,_that.periodStartAt,_that.periodEndAt,_that.baseProfitAmount,_that.finalProfitAmount,_that.status,_that.settledTokenAmount,_that.commissionGenerated,_that.settledAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? productNameSnapshot,  String? aiModelNameSnapshot,  String? profitDate,  int? effectiveMinutes,  String? periodStartAt,  String? periodEndAt, @JsonKey(fromJson: _stringFromJson)  String? baseProfitAmount, @JsonKey(fromJson: _stringFromJson)  String? finalProfitAmount,  String? status, @JsonKey(fromJson: _stringFromJson)  String? settledTokenAmount,  int? commissionGenerated,  String? settledAt)?  $default,) {final _that = this;
switch (_that) {
case _ProfitRecord() when $default != null:
return $default(_that.productNameSnapshot,_that.aiModelNameSnapshot,_that.profitDate,_that.effectiveMinutes,_that.periodStartAt,_that.periodEndAt,_that.baseProfitAmount,_that.finalProfitAmount,_that.status,_that.settledTokenAmount,_that.commissionGenerated,_that.settledAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfitRecord implements ProfitRecord {
  const _ProfitRecord({this.productNameSnapshot, this.aiModelNameSnapshot, this.profitDate, this.effectiveMinutes, this.periodStartAt, this.periodEndAt, @JsonKey(fromJson: _stringFromJson) this.baseProfitAmount, @JsonKey(fromJson: _stringFromJson) this.finalProfitAmount, this.status, @JsonKey(fromJson: _stringFromJson) this.settledTokenAmount, this.commissionGenerated, this.settledAt});
  factory _ProfitRecord.fromJson(Map<String, dynamic> json) => _$ProfitRecordFromJson(json);

@override final  String? productNameSnapshot;
@override final  String? aiModelNameSnapshot;
@override final  String? profitDate;
@override final  int? effectiveMinutes;
@override final  String? periodStartAt;
@override final  String? periodEndAt;
@override@JsonKey(fromJson: _stringFromJson) final  String? baseProfitAmount;
@override@JsonKey(fromJson: _stringFromJson) final  String? finalProfitAmount;
@override final  String? status;
@override@JsonKey(fromJson: _stringFromJson) final  String? settledTokenAmount;
@override final  int? commissionGenerated;
@override final  String? settledAt;

/// Create a copy of ProfitRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfitRecordCopyWith<_ProfitRecord> get copyWith => __$ProfitRecordCopyWithImpl<_ProfitRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfitRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfitRecord&&(identical(other.productNameSnapshot, productNameSnapshot) || other.productNameSnapshot == productNameSnapshot)&&(identical(other.aiModelNameSnapshot, aiModelNameSnapshot) || other.aiModelNameSnapshot == aiModelNameSnapshot)&&(identical(other.profitDate, profitDate) || other.profitDate == profitDate)&&(identical(other.effectiveMinutes, effectiveMinutes) || other.effectiveMinutes == effectiveMinutes)&&(identical(other.periodStartAt, periodStartAt) || other.periodStartAt == periodStartAt)&&(identical(other.periodEndAt, periodEndAt) || other.periodEndAt == periodEndAt)&&(identical(other.baseProfitAmount, baseProfitAmount) || other.baseProfitAmount == baseProfitAmount)&&(identical(other.finalProfitAmount, finalProfitAmount) || other.finalProfitAmount == finalProfitAmount)&&(identical(other.status, status) || other.status == status)&&(identical(other.settledTokenAmount, settledTokenAmount) || other.settledTokenAmount == settledTokenAmount)&&(identical(other.commissionGenerated, commissionGenerated) || other.commissionGenerated == commissionGenerated)&&(identical(other.settledAt, settledAt) || other.settledAt == settledAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productNameSnapshot,aiModelNameSnapshot,profitDate,effectiveMinutes,periodStartAt,periodEndAt,baseProfitAmount,finalProfitAmount,status,settledTokenAmount,commissionGenerated,settledAt);

@override
String toString() {
  return 'ProfitRecord(productNameSnapshot: $productNameSnapshot, aiModelNameSnapshot: $aiModelNameSnapshot, profitDate: $profitDate, effectiveMinutes: $effectiveMinutes, periodStartAt: $periodStartAt, periodEndAt: $periodEndAt, baseProfitAmount: $baseProfitAmount, finalProfitAmount: $finalProfitAmount, status: $status, settledTokenAmount: $settledTokenAmount, commissionGenerated: $commissionGenerated, settledAt: $settledAt)';
}


}

/// @nodoc
abstract mixin class _$ProfitRecordCopyWith<$Res> implements $ProfitRecordCopyWith<$Res> {
  factory _$ProfitRecordCopyWith(_ProfitRecord value, $Res Function(_ProfitRecord) _then) = __$ProfitRecordCopyWithImpl;
@override @useResult
$Res call({
 String? productNameSnapshot, String? aiModelNameSnapshot, String? profitDate, int? effectiveMinutes, String? periodStartAt, String? periodEndAt,@JsonKey(fromJson: _stringFromJson) String? baseProfitAmount,@JsonKey(fromJson: _stringFromJson) String? finalProfitAmount, String? status,@JsonKey(fromJson: _stringFromJson) String? settledTokenAmount, int? commissionGenerated, String? settledAt
});




}
/// @nodoc
class __$ProfitRecordCopyWithImpl<$Res>
    implements _$ProfitRecordCopyWith<$Res> {
  __$ProfitRecordCopyWithImpl(this._self, this._then);

  final _ProfitRecord _self;
  final $Res Function(_ProfitRecord) _then;

/// Create a copy of ProfitRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productNameSnapshot = freezed,Object? aiModelNameSnapshot = freezed,Object? profitDate = freezed,Object? effectiveMinutes = freezed,Object? periodStartAt = freezed,Object? periodEndAt = freezed,Object? baseProfitAmount = freezed,Object? finalProfitAmount = freezed,Object? status = freezed,Object? settledTokenAmount = freezed,Object? commissionGenerated = freezed,Object? settledAt = freezed,}) {
  return _then(_ProfitRecord(
productNameSnapshot: freezed == productNameSnapshot ? _self.productNameSnapshot : productNameSnapshot // ignore: cast_nullable_to_non_nullable
as String?,aiModelNameSnapshot: freezed == aiModelNameSnapshot ? _self.aiModelNameSnapshot : aiModelNameSnapshot // ignore: cast_nullable_to_non_nullable
as String?,profitDate: freezed == profitDate ? _self.profitDate : profitDate // ignore: cast_nullable_to_non_nullable
as String?,effectiveMinutes: freezed == effectiveMinutes ? _self.effectiveMinutes : effectiveMinutes // ignore: cast_nullable_to_non_nullable
as int?,periodStartAt: freezed == periodStartAt ? _self.periodStartAt : periodStartAt // ignore: cast_nullable_to_non_nullable
as String?,periodEndAt: freezed == periodEndAt ? _self.periodEndAt : periodEndAt // ignore: cast_nullable_to_non_nullable
as String?,baseProfitAmount: freezed == baseProfitAmount ? _self.baseProfitAmount : baseProfitAmount // ignore: cast_nullable_to_non_nullable
as String?,finalProfitAmount: freezed == finalProfitAmount ? _self.finalProfitAmount : finalProfitAmount // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,settledTokenAmount: freezed == settledTokenAmount ? _self.settledTokenAmount : settledTokenAmount // ignore: cast_nullable_to_non_nullable
as String?,commissionGenerated: freezed == commissionGenerated ? _self.commissionGenerated : commissionGenerated // ignore: cast_nullable_to_non_nullable
as int?,settledAt: freezed == settledAt ? _self.settledAt : settledAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CommissionSummary {

@JsonKey(fromJson: _stringFromJson) String? get totalCommission;@JsonKey(fromJson: _stringFromJson) String? get todayCommission;@JsonKey(fromJson: _stringFromJson) String? get yesterdayCommission;@JsonKey(fromJson: _stringFromJson) String? get currentMonthCommission;@JsonKey(fromJson: _stringFromJson) String? get level1Commission;@JsonKey(fromJson: _stringFromJson) String? get level2Commission;
/// Create a copy of CommissionSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommissionSummaryCopyWith<CommissionSummary> get copyWith => _$CommissionSummaryCopyWithImpl<CommissionSummary>(this as CommissionSummary, _$identity);

  /// Serializes this CommissionSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommissionSummary&&(identical(other.totalCommission, totalCommission) || other.totalCommission == totalCommission)&&(identical(other.todayCommission, todayCommission) || other.todayCommission == todayCommission)&&(identical(other.yesterdayCommission, yesterdayCommission) || other.yesterdayCommission == yesterdayCommission)&&(identical(other.currentMonthCommission, currentMonthCommission) || other.currentMonthCommission == currentMonthCommission)&&(identical(other.level1Commission, level1Commission) || other.level1Commission == level1Commission)&&(identical(other.level2Commission, level2Commission) || other.level2Commission == level2Commission));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalCommission,todayCommission,yesterdayCommission,currentMonthCommission,level1Commission,level2Commission);

@override
String toString() {
  return 'CommissionSummary(totalCommission: $totalCommission, todayCommission: $todayCommission, yesterdayCommission: $yesterdayCommission, currentMonthCommission: $currentMonthCommission, level1Commission: $level1Commission, level2Commission: $level2Commission)';
}


}

/// @nodoc
abstract mixin class $CommissionSummaryCopyWith<$Res>  {
  factory $CommissionSummaryCopyWith(CommissionSummary value, $Res Function(CommissionSummary) _then) = _$CommissionSummaryCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _stringFromJson) String? totalCommission,@JsonKey(fromJson: _stringFromJson) String? todayCommission,@JsonKey(fromJson: _stringFromJson) String? yesterdayCommission,@JsonKey(fromJson: _stringFromJson) String? currentMonthCommission,@JsonKey(fromJson: _stringFromJson) String? level1Commission,@JsonKey(fromJson: _stringFromJson) String? level2Commission
});




}
/// @nodoc
class _$CommissionSummaryCopyWithImpl<$Res>
    implements $CommissionSummaryCopyWith<$Res> {
  _$CommissionSummaryCopyWithImpl(this._self, this._then);

  final CommissionSummary _self;
  final $Res Function(CommissionSummary) _then;

/// Create a copy of CommissionSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalCommission = freezed,Object? todayCommission = freezed,Object? yesterdayCommission = freezed,Object? currentMonthCommission = freezed,Object? level1Commission = freezed,Object? level2Commission = freezed,}) {
  return _then(_self.copyWith(
totalCommission: freezed == totalCommission ? _self.totalCommission : totalCommission // ignore: cast_nullable_to_non_nullable
as String?,todayCommission: freezed == todayCommission ? _self.todayCommission : todayCommission // ignore: cast_nullable_to_non_nullable
as String?,yesterdayCommission: freezed == yesterdayCommission ? _self.yesterdayCommission : yesterdayCommission // ignore: cast_nullable_to_non_nullable
as String?,currentMonthCommission: freezed == currentMonthCommission ? _self.currentMonthCommission : currentMonthCommission // ignore: cast_nullable_to_non_nullable
as String?,level1Commission: freezed == level1Commission ? _self.level1Commission : level1Commission // ignore: cast_nullable_to_non_nullable
as String?,level2Commission: freezed == level2Commission ? _self.level2Commission : level2Commission // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CommissionSummary].
extension CommissionSummaryPatterns on CommissionSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommissionSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommissionSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommissionSummary value)  $default,){
final _that = this;
switch (_that) {
case _CommissionSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommissionSummary value)?  $default,){
final _that = this;
switch (_that) {
case _CommissionSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _stringFromJson)  String? totalCommission, @JsonKey(fromJson: _stringFromJson)  String? todayCommission, @JsonKey(fromJson: _stringFromJson)  String? yesterdayCommission, @JsonKey(fromJson: _stringFromJson)  String? currentMonthCommission, @JsonKey(fromJson: _stringFromJson)  String? level1Commission, @JsonKey(fromJson: _stringFromJson)  String? level2Commission)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommissionSummary() when $default != null:
return $default(_that.totalCommission,_that.todayCommission,_that.yesterdayCommission,_that.currentMonthCommission,_that.level1Commission,_that.level2Commission);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _stringFromJson)  String? totalCommission, @JsonKey(fromJson: _stringFromJson)  String? todayCommission, @JsonKey(fromJson: _stringFromJson)  String? yesterdayCommission, @JsonKey(fromJson: _stringFromJson)  String? currentMonthCommission, @JsonKey(fromJson: _stringFromJson)  String? level1Commission, @JsonKey(fromJson: _stringFromJson)  String? level2Commission)  $default,) {final _that = this;
switch (_that) {
case _CommissionSummary():
return $default(_that.totalCommission,_that.todayCommission,_that.yesterdayCommission,_that.currentMonthCommission,_that.level1Commission,_that.level2Commission);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: _stringFromJson)  String? totalCommission, @JsonKey(fromJson: _stringFromJson)  String? todayCommission, @JsonKey(fromJson: _stringFromJson)  String? yesterdayCommission, @JsonKey(fromJson: _stringFromJson)  String? currentMonthCommission, @JsonKey(fromJson: _stringFromJson)  String? level1Commission, @JsonKey(fromJson: _stringFromJson)  String? level2Commission)?  $default,) {final _that = this;
switch (_that) {
case _CommissionSummary() when $default != null:
return $default(_that.totalCommission,_that.todayCommission,_that.yesterdayCommission,_that.currentMonthCommission,_that.level1Commission,_that.level2Commission);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommissionSummary implements CommissionSummary {
  const _CommissionSummary({@JsonKey(fromJson: _stringFromJson) this.totalCommission, @JsonKey(fromJson: _stringFromJson) this.todayCommission, @JsonKey(fromJson: _stringFromJson) this.yesterdayCommission, @JsonKey(fromJson: _stringFromJson) this.currentMonthCommission, @JsonKey(fromJson: _stringFromJson) this.level1Commission, @JsonKey(fromJson: _stringFromJson) this.level2Commission});
  factory _CommissionSummary.fromJson(Map<String, dynamic> json) => _$CommissionSummaryFromJson(json);

@override@JsonKey(fromJson: _stringFromJson) final  String? totalCommission;
@override@JsonKey(fromJson: _stringFromJson) final  String? todayCommission;
@override@JsonKey(fromJson: _stringFromJson) final  String? yesterdayCommission;
@override@JsonKey(fromJson: _stringFromJson) final  String? currentMonthCommission;
@override@JsonKey(fromJson: _stringFromJson) final  String? level1Commission;
@override@JsonKey(fromJson: _stringFromJson) final  String? level2Commission;

/// Create a copy of CommissionSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommissionSummaryCopyWith<_CommissionSummary> get copyWith => __$CommissionSummaryCopyWithImpl<_CommissionSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommissionSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommissionSummary&&(identical(other.totalCommission, totalCommission) || other.totalCommission == totalCommission)&&(identical(other.todayCommission, todayCommission) || other.todayCommission == todayCommission)&&(identical(other.yesterdayCommission, yesterdayCommission) || other.yesterdayCommission == yesterdayCommission)&&(identical(other.currentMonthCommission, currentMonthCommission) || other.currentMonthCommission == currentMonthCommission)&&(identical(other.level1Commission, level1Commission) || other.level1Commission == level1Commission)&&(identical(other.level2Commission, level2Commission) || other.level2Commission == level2Commission));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalCommission,todayCommission,yesterdayCommission,currentMonthCommission,level1Commission,level2Commission);

@override
String toString() {
  return 'CommissionSummary(totalCommission: $totalCommission, todayCommission: $todayCommission, yesterdayCommission: $yesterdayCommission, currentMonthCommission: $currentMonthCommission, level1Commission: $level1Commission, level2Commission: $level2Commission)';
}


}

/// @nodoc
abstract mixin class _$CommissionSummaryCopyWith<$Res> implements $CommissionSummaryCopyWith<$Res> {
  factory _$CommissionSummaryCopyWith(_CommissionSummary value, $Res Function(_CommissionSummary) _then) = __$CommissionSummaryCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _stringFromJson) String? totalCommission,@JsonKey(fromJson: _stringFromJson) String? todayCommission,@JsonKey(fromJson: _stringFromJson) String? yesterdayCommission,@JsonKey(fromJson: _stringFromJson) String? currentMonthCommission,@JsonKey(fromJson: _stringFromJson) String? level1Commission,@JsonKey(fromJson: _stringFromJson) String? level2Commission
});




}
/// @nodoc
class __$CommissionSummaryCopyWithImpl<$Res>
    implements _$CommissionSummaryCopyWith<$Res> {
  __$CommissionSummaryCopyWithImpl(this._self, this._then);

  final _CommissionSummary _self;
  final $Res Function(_CommissionSummary) _then;

/// Create a copy of CommissionSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalCommission = freezed,Object? todayCommission = freezed,Object? yesterdayCommission = freezed,Object? currentMonthCommission = freezed,Object? level1Commission = freezed,Object? level2Commission = freezed,}) {
  return _then(_CommissionSummary(
totalCommission: freezed == totalCommission ? _self.totalCommission : totalCommission // ignore: cast_nullable_to_non_nullable
as String?,todayCommission: freezed == todayCommission ? _self.todayCommission : todayCommission // ignore: cast_nullable_to_non_nullable
as String?,yesterdayCommission: freezed == yesterdayCommission ? _self.yesterdayCommission : yesterdayCommission // ignore: cast_nullable_to_non_nullable
as String?,currentMonthCommission: freezed == currentMonthCommission ? _self.currentMonthCommission : currentMonthCommission // ignore: cast_nullable_to_non_nullable
as String?,level1Commission: freezed == level1Commission ? _self.level1Commission : level1Commission // ignore: cast_nullable_to_non_nullable
as String?,level2Commission: freezed == level2Commission ? _self.level2Commission : level2Commission // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CommissionRecord {

 String? get userName; int? get levelNo;@JsonKey(fromJson: _stringFromJson) String? get sourceProfitAmount;@JsonKey(fromJson: _stringFromJson) String? get commissionRateSnapshot;@JsonKey(fromJson: _stringFromJson) String? get commissionAmount; String? get status; String? get settledAt; String? get createdAt;
/// Create a copy of CommissionRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommissionRecordCopyWith<CommissionRecord> get copyWith => _$CommissionRecordCopyWithImpl<CommissionRecord>(this as CommissionRecord, _$identity);

  /// Serializes this CommissionRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommissionRecord&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.levelNo, levelNo) || other.levelNo == levelNo)&&(identical(other.sourceProfitAmount, sourceProfitAmount) || other.sourceProfitAmount == sourceProfitAmount)&&(identical(other.commissionRateSnapshot, commissionRateSnapshot) || other.commissionRateSnapshot == commissionRateSnapshot)&&(identical(other.commissionAmount, commissionAmount) || other.commissionAmount == commissionAmount)&&(identical(other.status, status) || other.status == status)&&(identical(other.settledAt, settledAt) || other.settledAt == settledAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userName,levelNo,sourceProfitAmount,commissionRateSnapshot,commissionAmount,status,settledAt,createdAt);

@override
String toString() {
  return 'CommissionRecord(userName: $userName, levelNo: $levelNo, sourceProfitAmount: $sourceProfitAmount, commissionRateSnapshot: $commissionRateSnapshot, commissionAmount: $commissionAmount, status: $status, settledAt: $settledAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $CommissionRecordCopyWith<$Res>  {
  factory $CommissionRecordCopyWith(CommissionRecord value, $Res Function(CommissionRecord) _then) = _$CommissionRecordCopyWithImpl;
@useResult
$Res call({
 String? userName, int? levelNo,@JsonKey(fromJson: _stringFromJson) String? sourceProfitAmount,@JsonKey(fromJson: _stringFromJson) String? commissionRateSnapshot,@JsonKey(fromJson: _stringFromJson) String? commissionAmount, String? status, String? settledAt, String? createdAt
});




}
/// @nodoc
class _$CommissionRecordCopyWithImpl<$Res>
    implements $CommissionRecordCopyWith<$Res> {
  _$CommissionRecordCopyWithImpl(this._self, this._then);

  final CommissionRecord _self;
  final $Res Function(CommissionRecord) _then;

/// Create a copy of CommissionRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userName = freezed,Object? levelNo = freezed,Object? sourceProfitAmount = freezed,Object? commissionRateSnapshot = freezed,Object? commissionAmount = freezed,Object? status = freezed,Object? settledAt = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,levelNo: freezed == levelNo ? _self.levelNo : levelNo // ignore: cast_nullable_to_non_nullable
as int?,sourceProfitAmount: freezed == sourceProfitAmount ? _self.sourceProfitAmount : sourceProfitAmount // ignore: cast_nullable_to_non_nullable
as String?,commissionRateSnapshot: freezed == commissionRateSnapshot ? _self.commissionRateSnapshot : commissionRateSnapshot // ignore: cast_nullable_to_non_nullable
as String?,commissionAmount: freezed == commissionAmount ? _self.commissionAmount : commissionAmount // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,settledAt: freezed == settledAt ? _self.settledAt : settledAt // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CommissionRecord].
extension CommissionRecordPatterns on CommissionRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommissionRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommissionRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommissionRecord value)  $default,){
final _that = this;
switch (_that) {
case _CommissionRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommissionRecord value)?  $default,){
final _that = this;
switch (_that) {
case _CommissionRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? userName,  int? levelNo, @JsonKey(fromJson: _stringFromJson)  String? sourceProfitAmount, @JsonKey(fromJson: _stringFromJson)  String? commissionRateSnapshot, @JsonKey(fromJson: _stringFromJson)  String? commissionAmount,  String? status,  String? settledAt,  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommissionRecord() when $default != null:
return $default(_that.userName,_that.levelNo,_that.sourceProfitAmount,_that.commissionRateSnapshot,_that.commissionAmount,_that.status,_that.settledAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? userName,  int? levelNo, @JsonKey(fromJson: _stringFromJson)  String? sourceProfitAmount, @JsonKey(fromJson: _stringFromJson)  String? commissionRateSnapshot, @JsonKey(fromJson: _stringFromJson)  String? commissionAmount,  String? status,  String? settledAt,  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _CommissionRecord():
return $default(_that.userName,_that.levelNo,_that.sourceProfitAmount,_that.commissionRateSnapshot,_that.commissionAmount,_that.status,_that.settledAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? userName,  int? levelNo, @JsonKey(fromJson: _stringFromJson)  String? sourceProfitAmount, @JsonKey(fromJson: _stringFromJson)  String? commissionRateSnapshot, @JsonKey(fromJson: _stringFromJson)  String? commissionAmount,  String? status,  String? settledAt,  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _CommissionRecord() when $default != null:
return $default(_that.userName,_that.levelNo,_that.sourceProfitAmount,_that.commissionRateSnapshot,_that.commissionAmount,_that.status,_that.settledAt,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommissionRecord implements CommissionRecord {
  const _CommissionRecord({this.userName, this.levelNo, @JsonKey(fromJson: _stringFromJson) this.sourceProfitAmount, @JsonKey(fromJson: _stringFromJson) this.commissionRateSnapshot, @JsonKey(fromJson: _stringFromJson) this.commissionAmount, this.status, this.settledAt, this.createdAt});
  factory _CommissionRecord.fromJson(Map<String, dynamic> json) => _$CommissionRecordFromJson(json);

@override final  String? userName;
@override final  int? levelNo;
@override@JsonKey(fromJson: _stringFromJson) final  String? sourceProfitAmount;
@override@JsonKey(fromJson: _stringFromJson) final  String? commissionRateSnapshot;
@override@JsonKey(fromJson: _stringFromJson) final  String? commissionAmount;
@override final  String? status;
@override final  String? settledAt;
@override final  String? createdAt;

/// Create a copy of CommissionRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommissionRecordCopyWith<_CommissionRecord> get copyWith => __$CommissionRecordCopyWithImpl<_CommissionRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommissionRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommissionRecord&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.levelNo, levelNo) || other.levelNo == levelNo)&&(identical(other.sourceProfitAmount, sourceProfitAmount) || other.sourceProfitAmount == sourceProfitAmount)&&(identical(other.commissionRateSnapshot, commissionRateSnapshot) || other.commissionRateSnapshot == commissionRateSnapshot)&&(identical(other.commissionAmount, commissionAmount) || other.commissionAmount == commissionAmount)&&(identical(other.status, status) || other.status == status)&&(identical(other.settledAt, settledAt) || other.settledAt == settledAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userName,levelNo,sourceProfitAmount,commissionRateSnapshot,commissionAmount,status,settledAt,createdAt);

@override
String toString() {
  return 'CommissionRecord(userName: $userName, levelNo: $levelNo, sourceProfitAmount: $sourceProfitAmount, commissionRateSnapshot: $commissionRateSnapshot, commissionAmount: $commissionAmount, status: $status, settledAt: $settledAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$CommissionRecordCopyWith<$Res> implements $CommissionRecordCopyWith<$Res> {
  factory _$CommissionRecordCopyWith(_CommissionRecord value, $Res Function(_CommissionRecord) _then) = __$CommissionRecordCopyWithImpl;
@override @useResult
$Res call({
 String? userName, int? levelNo,@JsonKey(fromJson: _stringFromJson) String? sourceProfitAmount,@JsonKey(fromJson: _stringFromJson) String? commissionRateSnapshot,@JsonKey(fromJson: _stringFromJson) String? commissionAmount, String? status, String? settledAt, String? createdAt
});




}
/// @nodoc
class __$CommissionRecordCopyWithImpl<$Res>
    implements _$CommissionRecordCopyWith<$Res> {
  __$CommissionRecordCopyWithImpl(this._self, this._then);

  final _CommissionRecord _self;
  final $Res Function(_CommissionRecord) _then;

/// Create a copy of CommissionRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userName = freezed,Object? levelNo = freezed,Object? sourceProfitAmount = freezed,Object? commissionRateSnapshot = freezed,Object? commissionAmount = freezed,Object? status = freezed,Object? settledAt = freezed,Object? createdAt = freezed,}) {
  return _then(_CommissionRecord(
userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,levelNo: freezed == levelNo ? _self.levelNo : levelNo // ignore: cast_nullable_to_non_nullable
as int?,sourceProfitAmount: freezed == sourceProfitAmount ? _self.sourceProfitAmount : sourceProfitAmount // ignore: cast_nullable_to_non_nullable
as String?,commissionRateSnapshot: freezed == commissionRateSnapshot ? _self.commissionRateSnapshot : commissionRateSnapshot // ignore: cast_nullable_to_non_nullable
as String?,commissionAmount: freezed == commissionAmount ? _self.commissionAmount : commissionAmount // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,settledAt: freezed == settledAt ? _self.settledAt : settledAt // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TeamSummary {

 int get totalTeamCount; int get directTeamCount; int get level2TeamCount; int get afterLevel2TeamCount;
/// Create a copy of TeamSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamSummaryCopyWith<TeamSummary> get copyWith => _$TeamSummaryCopyWithImpl<TeamSummary>(this as TeamSummary, _$identity);

  /// Serializes this TeamSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamSummary&&(identical(other.totalTeamCount, totalTeamCount) || other.totalTeamCount == totalTeamCount)&&(identical(other.directTeamCount, directTeamCount) || other.directTeamCount == directTeamCount)&&(identical(other.level2TeamCount, level2TeamCount) || other.level2TeamCount == level2TeamCount)&&(identical(other.afterLevel2TeamCount, afterLevel2TeamCount) || other.afterLevel2TeamCount == afterLevel2TeamCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalTeamCount,directTeamCount,level2TeamCount,afterLevel2TeamCount);

@override
String toString() {
  return 'TeamSummary(totalTeamCount: $totalTeamCount, directTeamCount: $directTeamCount, level2TeamCount: $level2TeamCount, afterLevel2TeamCount: $afterLevel2TeamCount)';
}


}

/// @nodoc
abstract mixin class $TeamSummaryCopyWith<$Res>  {
  factory $TeamSummaryCopyWith(TeamSummary value, $Res Function(TeamSummary) _then) = _$TeamSummaryCopyWithImpl;
@useResult
$Res call({
 int totalTeamCount, int directTeamCount, int level2TeamCount, int afterLevel2TeamCount
});




}
/// @nodoc
class _$TeamSummaryCopyWithImpl<$Res>
    implements $TeamSummaryCopyWith<$Res> {
  _$TeamSummaryCopyWithImpl(this._self, this._then);

  final TeamSummary _self;
  final $Res Function(TeamSummary) _then;

/// Create a copy of TeamSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalTeamCount = null,Object? directTeamCount = null,Object? level2TeamCount = null,Object? afterLevel2TeamCount = null,}) {
  return _then(_self.copyWith(
totalTeamCount: null == totalTeamCount ? _self.totalTeamCount : totalTeamCount // ignore: cast_nullable_to_non_nullable
as int,directTeamCount: null == directTeamCount ? _self.directTeamCount : directTeamCount // ignore: cast_nullable_to_non_nullable
as int,level2TeamCount: null == level2TeamCount ? _self.level2TeamCount : level2TeamCount // ignore: cast_nullable_to_non_nullable
as int,afterLevel2TeamCount: null == afterLevel2TeamCount ? _self.afterLevel2TeamCount : afterLevel2TeamCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TeamSummary].
extension TeamSummaryPatterns on TeamSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeamSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeamSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeamSummary value)  $default,){
final _that = this;
switch (_that) {
case _TeamSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeamSummary value)?  $default,){
final _that = this;
switch (_that) {
case _TeamSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalTeamCount,  int directTeamCount,  int level2TeamCount,  int afterLevel2TeamCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeamSummary() when $default != null:
return $default(_that.totalTeamCount,_that.directTeamCount,_that.level2TeamCount,_that.afterLevel2TeamCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalTeamCount,  int directTeamCount,  int level2TeamCount,  int afterLevel2TeamCount)  $default,) {final _that = this;
switch (_that) {
case _TeamSummary():
return $default(_that.totalTeamCount,_that.directTeamCount,_that.level2TeamCount,_that.afterLevel2TeamCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalTeamCount,  int directTeamCount,  int level2TeamCount,  int afterLevel2TeamCount)?  $default,) {final _that = this;
switch (_that) {
case _TeamSummary() when $default != null:
return $default(_that.totalTeamCount,_that.directTeamCount,_that.level2TeamCount,_that.afterLevel2TeamCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TeamSummary implements TeamSummary {
  const _TeamSummary({this.totalTeamCount = 0, this.directTeamCount = 0, this.level2TeamCount = 0, this.afterLevel2TeamCount = 0});
  factory _TeamSummary.fromJson(Map<String, dynamic> json) => _$TeamSummaryFromJson(json);

@override@JsonKey() final  int totalTeamCount;
@override@JsonKey() final  int directTeamCount;
@override@JsonKey() final  int level2TeamCount;
@override@JsonKey() final  int afterLevel2TeamCount;

/// Create a copy of TeamSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeamSummaryCopyWith<_TeamSummary> get copyWith => __$TeamSummaryCopyWithImpl<_TeamSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TeamSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeamSummary&&(identical(other.totalTeamCount, totalTeamCount) || other.totalTeamCount == totalTeamCount)&&(identical(other.directTeamCount, directTeamCount) || other.directTeamCount == directTeamCount)&&(identical(other.level2TeamCount, level2TeamCount) || other.level2TeamCount == level2TeamCount)&&(identical(other.afterLevel2TeamCount, afterLevel2TeamCount) || other.afterLevel2TeamCount == afterLevel2TeamCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalTeamCount,directTeamCount,level2TeamCount,afterLevel2TeamCount);

@override
String toString() {
  return 'TeamSummary(totalTeamCount: $totalTeamCount, directTeamCount: $directTeamCount, level2TeamCount: $level2TeamCount, afterLevel2TeamCount: $afterLevel2TeamCount)';
}


}

/// @nodoc
abstract mixin class _$TeamSummaryCopyWith<$Res> implements $TeamSummaryCopyWith<$Res> {
  factory _$TeamSummaryCopyWith(_TeamSummary value, $Res Function(_TeamSummary) _then) = __$TeamSummaryCopyWithImpl;
@override @useResult
$Res call({
 int totalTeamCount, int directTeamCount, int level2TeamCount, int afterLevel2TeamCount
});




}
/// @nodoc
class __$TeamSummaryCopyWithImpl<$Res>
    implements _$TeamSummaryCopyWith<$Res> {
  __$TeamSummaryCopyWithImpl(this._self, this._then);

  final _TeamSummary _self;
  final $Res Function(_TeamSummary) _then;

/// Create a copy of TeamSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalTeamCount = null,Object? directTeamCount = null,Object? level2TeamCount = null,Object? afterLevel2TeamCount = null,}) {
  return _then(_TeamSummary(
totalTeamCount: null == totalTeamCount ? _self.totalTeamCount : totalTeamCount // ignore: cast_nullable_to_non_nullable
as int,directTeamCount: null == directTeamCount ? _self.directTeamCount : directTeamCount // ignore: cast_nullable_to_non_nullable
as int,level2TeamCount: null == level2TeamCount ? _self.level2TeamCount : level2TeamCount // ignore: cast_nullable_to_non_nullable
as int,afterLevel2TeamCount: null == afterLevel2TeamCount ? _self.afterLevel2TeamCount : afterLevel2TeamCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TeamMember {

 String? get userName; int? get status; int? get levelDepth; String? get createdAt; int? get subTeamCount;
/// Create a copy of TeamMember
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamMemberCopyWith<TeamMember> get copyWith => _$TeamMemberCopyWithImpl<TeamMember>(this as TeamMember, _$identity);

  /// Serializes this TeamMember to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamMember&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.status, status) || other.status == status)&&(identical(other.levelDepth, levelDepth) || other.levelDepth == levelDepth)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.subTeamCount, subTeamCount) || other.subTeamCount == subTeamCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userName,status,levelDepth,createdAt,subTeamCount);

@override
String toString() {
  return 'TeamMember(userName: $userName, status: $status, levelDepth: $levelDepth, createdAt: $createdAt, subTeamCount: $subTeamCount)';
}


}

/// @nodoc
abstract mixin class $TeamMemberCopyWith<$Res>  {
  factory $TeamMemberCopyWith(TeamMember value, $Res Function(TeamMember) _then) = _$TeamMemberCopyWithImpl;
@useResult
$Res call({
 String? userName, int? status, int? levelDepth, String? createdAt, int? subTeamCount
});




}
/// @nodoc
class _$TeamMemberCopyWithImpl<$Res>
    implements $TeamMemberCopyWith<$Res> {
  _$TeamMemberCopyWithImpl(this._self, this._then);

  final TeamMember _self;
  final $Res Function(TeamMember) _then;

/// Create a copy of TeamMember
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userName = freezed,Object? status = freezed,Object? levelDepth = freezed,Object? createdAt = freezed,Object? subTeamCount = freezed,}) {
  return _then(_self.copyWith(
userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int?,levelDepth: freezed == levelDepth ? _self.levelDepth : levelDepth // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,subTeamCount: freezed == subTeamCount ? _self.subTeamCount : subTeamCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [TeamMember].
extension TeamMemberPatterns on TeamMember {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeamMember value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeamMember() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeamMember value)  $default,){
final _that = this;
switch (_that) {
case _TeamMember():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeamMember value)?  $default,){
final _that = this;
switch (_that) {
case _TeamMember() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? userName,  int? status,  int? levelDepth,  String? createdAt,  int? subTeamCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeamMember() when $default != null:
return $default(_that.userName,_that.status,_that.levelDepth,_that.createdAt,_that.subTeamCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? userName,  int? status,  int? levelDepth,  String? createdAt,  int? subTeamCount)  $default,) {final _that = this;
switch (_that) {
case _TeamMember():
return $default(_that.userName,_that.status,_that.levelDepth,_that.createdAt,_that.subTeamCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? userName,  int? status,  int? levelDepth,  String? createdAt,  int? subTeamCount)?  $default,) {final _that = this;
switch (_that) {
case _TeamMember() when $default != null:
return $default(_that.userName,_that.status,_that.levelDepth,_that.createdAt,_that.subTeamCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TeamMember implements TeamMember {
  const _TeamMember({this.userName, this.status, this.levelDepth, this.createdAt, this.subTeamCount});
  factory _TeamMember.fromJson(Map<String, dynamic> json) => _$TeamMemberFromJson(json);

@override final  String? userName;
@override final  int? status;
@override final  int? levelDepth;
@override final  String? createdAt;
@override final  int? subTeamCount;

/// Create a copy of TeamMember
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeamMemberCopyWith<_TeamMember> get copyWith => __$TeamMemberCopyWithImpl<_TeamMember>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TeamMemberToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeamMember&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.status, status) || other.status == status)&&(identical(other.levelDepth, levelDepth) || other.levelDepth == levelDepth)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.subTeamCount, subTeamCount) || other.subTeamCount == subTeamCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userName,status,levelDepth,createdAt,subTeamCount);

@override
String toString() {
  return 'TeamMember(userName: $userName, status: $status, levelDepth: $levelDepth, createdAt: $createdAt, subTeamCount: $subTeamCount)';
}


}

/// @nodoc
abstract mixin class _$TeamMemberCopyWith<$Res> implements $TeamMemberCopyWith<$Res> {
  factory _$TeamMemberCopyWith(_TeamMember value, $Res Function(_TeamMember) _then) = __$TeamMemberCopyWithImpl;
@override @useResult
$Res call({
 String? userName, int? status, int? levelDepth, String? createdAt, int? subTeamCount
});




}
/// @nodoc
class __$TeamMemberCopyWithImpl<$Res>
    implements _$TeamMemberCopyWith<$Res> {
  __$TeamMemberCopyWithImpl(this._self, this._then);

  final _TeamMember _self;
  final $Res Function(_TeamMember) _then;

/// Create a copy of TeamMember
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userName = freezed,Object? status = freezed,Object? levelDepth = freezed,Object? createdAt = freezed,Object? subTeamCount = freezed,}) {
  return _then(_TeamMember(
userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int?,levelDepth: freezed == levelDepth ? _self.levelDepth : levelDepth // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,subTeamCount: freezed == subTeamCount ? _self.subTeamCount : subTeamCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$TeamContributionRank {

 int? get rankNo; String? get userName; int? get userStatus; int? get levelDepth; String? get registeredAt;@JsonKey(fromJson: _stringFromJson) String? get totalCommission;@JsonKey(fromJson: _stringFromJson) String? get todayCommission;@JsonKey(fromJson: _stringFromJson) String? get monthCommission; int? get commissionRecordCount; String? get lastCommissionAt; String? get currency;
/// Create a copy of TeamContributionRank
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamContributionRankCopyWith<TeamContributionRank> get copyWith => _$TeamContributionRankCopyWithImpl<TeamContributionRank>(this as TeamContributionRank, _$identity);

  /// Serializes this TeamContributionRank to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamContributionRank&&(identical(other.rankNo, rankNo) || other.rankNo == rankNo)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.userStatus, userStatus) || other.userStatus == userStatus)&&(identical(other.levelDepth, levelDepth) || other.levelDepth == levelDepth)&&(identical(other.registeredAt, registeredAt) || other.registeredAt == registeredAt)&&(identical(other.totalCommission, totalCommission) || other.totalCommission == totalCommission)&&(identical(other.todayCommission, todayCommission) || other.todayCommission == todayCommission)&&(identical(other.monthCommission, monthCommission) || other.monthCommission == monthCommission)&&(identical(other.commissionRecordCount, commissionRecordCount) || other.commissionRecordCount == commissionRecordCount)&&(identical(other.lastCommissionAt, lastCommissionAt) || other.lastCommissionAt == lastCommissionAt)&&(identical(other.currency, currency) || other.currency == currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rankNo,userName,userStatus,levelDepth,registeredAt,totalCommission,todayCommission,monthCommission,commissionRecordCount,lastCommissionAt,currency);

@override
String toString() {
  return 'TeamContributionRank(rankNo: $rankNo, userName: $userName, userStatus: $userStatus, levelDepth: $levelDepth, registeredAt: $registeredAt, totalCommission: $totalCommission, todayCommission: $todayCommission, monthCommission: $monthCommission, commissionRecordCount: $commissionRecordCount, lastCommissionAt: $lastCommissionAt, currency: $currency)';
}


}

/// @nodoc
abstract mixin class $TeamContributionRankCopyWith<$Res>  {
  factory $TeamContributionRankCopyWith(TeamContributionRank value, $Res Function(TeamContributionRank) _then) = _$TeamContributionRankCopyWithImpl;
@useResult
$Res call({
 int? rankNo, String? userName, int? userStatus, int? levelDepth, String? registeredAt,@JsonKey(fromJson: _stringFromJson) String? totalCommission,@JsonKey(fromJson: _stringFromJson) String? todayCommission,@JsonKey(fromJson: _stringFromJson) String? monthCommission, int? commissionRecordCount, String? lastCommissionAt, String? currency
});




}
/// @nodoc
class _$TeamContributionRankCopyWithImpl<$Res>
    implements $TeamContributionRankCopyWith<$Res> {
  _$TeamContributionRankCopyWithImpl(this._self, this._then);

  final TeamContributionRank _self;
  final $Res Function(TeamContributionRank) _then;

/// Create a copy of TeamContributionRank
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rankNo = freezed,Object? userName = freezed,Object? userStatus = freezed,Object? levelDepth = freezed,Object? registeredAt = freezed,Object? totalCommission = freezed,Object? todayCommission = freezed,Object? monthCommission = freezed,Object? commissionRecordCount = freezed,Object? lastCommissionAt = freezed,Object? currency = freezed,}) {
  return _then(_self.copyWith(
rankNo: freezed == rankNo ? _self.rankNo : rankNo // ignore: cast_nullable_to_non_nullable
as int?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,userStatus: freezed == userStatus ? _self.userStatus : userStatus // ignore: cast_nullable_to_non_nullable
as int?,levelDepth: freezed == levelDepth ? _self.levelDepth : levelDepth // ignore: cast_nullable_to_non_nullable
as int?,registeredAt: freezed == registeredAt ? _self.registeredAt : registeredAt // ignore: cast_nullable_to_non_nullable
as String?,totalCommission: freezed == totalCommission ? _self.totalCommission : totalCommission // ignore: cast_nullable_to_non_nullable
as String?,todayCommission: freezed == todayCommission ? _self.todayCommission : todayCommission // ignore: cast_nullable_to_non_nullable
as String?,monthCommission: freezed == monthCommission ? _self.monthCommission : monthCommission // ignore: cast_nullable_to_non_nullable
as String?,commissionRecordCount: freezed == commissionRecordCount ? _self.commissionRecordCount : commissionRecordCount // ignore: cast_nullable_to_non_nullable
as int?,lastCommissionAt: freezed == lastCommissionAt ? _self.lastCommissionAt : lastCommissionAt // ignore: cast_nullable_to_non_nullable
as String?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TeamContributionRank].
extension TeamContributionRankPatterns on TeamContributionRank {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeamContributionRank value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeamContributionRank() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeamContributionRank value)  $default,){
final _that = this;
switch (_that) {
case _TeamContributionRank():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeamContributionRank value)?  $default,){
final _that = this;
switch (_that) {
case _TeamContributionRank() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? rankNo,  String? userName,  int? userStatus,  int? levelDepth,  String? registeredAt, @JsonKey(fromJson: _stringFromJson)  String? totalCommission, @JsonKey(fromJson: _stringFromJson)  String? todayCommission, @JsonKey(fromJson: _stringFromJson)  String? monthCommission,  int? commissionRecordCount,  String? lastCommissionAt,  String? currency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeamContributionRank() when $default != null:
return $default(_that.rankNo,_that.userName,_that.userStatus,_that.levelDepth,_that.registeredAt,_that.totalCommission,_that.todayCommission,_that.monthCommission,_that.commissionRecordCount,_that.lastCommissionAt,_that.currency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? rankNo,  String? userName,  int? userStatus,  int? levelDepth,  String? registeredAt, @JsonKey(fromJson: _stringFromJson)  String? totalCommission, @JsonKey(fromJson: _stringFromJson)  String? todayCommission, @JsonKey(fromJson: _stringFromJson)  String? monthCommission,  int? commissionRecordCount,  String? lastCommissionAt,  String? currency)  $default,) {final _that = this;
switch (_that) {
case _TeamContributionRank():
return $default(_that.rankNo,_that.userName,_that.userStatus,_that.levelDepth,_that.registeredAt,_that.totalCommission,_that.todayCommission,_that.monthCommission,_that.commissionRecordCount,_that.lastCommissionAt,_that.currency);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? rankNo,  String? userName,  int? userStatus,  int? levelDepth,  String? registeredAt, @JsonKey(fromJson: _stringFromJson)  String? totalCommission, @JsonKey(fromJson: _stringFromJson)  String? todayCommission, @JsonKey(fromJson: _stringFromJson)  String? monthCommission,  int? commissionRecordCount,  String? lastCommissionAt,  String? currency)?  $default,) {final _that = this;
switch (_that) {
case _TeamContributionRank() when $default != null:
return $default(_that.rankNo,_that.userName,_that.userStatus,_that.levelDepth,_that.registeredAt,_that.totalCommission,_that.todayCommission,_that.monthCommission,_that.commissionRecordCount,_that.lastCommissionAt,_that.currency);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TeamContributionRank implements TeamContributionRank {
  const _TeamContributionRank({this.rankNo, this.userName, this.userStatus, this.levelDepth, this.registeredAt, @JsonKey(fromJson: _stringFromJson) this.totalCommission, @JsonKey(fromJson: _stringFromJson) this.todayCommission, @JsonKey(fromJson: _stringFromJson) this.monthCommission, this.commissionRecordCount, this.lastCommissionAt, this.currency});
  factory _TeamContributionRank.fromJson(Map<String, dynamic> json) => _$TeamContributionRankFromJson(json);

@override final  int? rankNo;
@override final  String? userName;
@override final  int? userStatus;
@override final  int? levelDepth;
@override final  String? registeredAt;
@override@JsonKey(fromJson: _stringFromJson) final  String? totalCommission;
@override@JsonKey(fromJson: _stringFromJson) final  String? todayCommission;
@override@JsonKey(fromJson: _stringFromJson) final  String? monthCommission;
@override final  int? commissionRecordCount;
@override final  String? lastCommissionAt;
@override final  String? currency;

/// Create a copy of TeamContributionRank
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeamContributionRankCopyWith<_TeamContributionRank> get copyWith => __$TeamContributionRankCopyWithImpl<_TeamContributionRank>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TeamContributionRankToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeamContributionRank&&(identical(other.rankNo, rankNo) || other.rankNo == rankNo)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.userStatus, userStatus) || other.userStatus == userStatus)&&(identical(other.levelDepth, levelDepth) || other.levelDepth == levelDepth)&&(identical(other.registeredAt, registeredAt) || other.registeredAt == registeredAt)&&(identical(other.totalCommission, totalCommission) || other.totalCommission == totalCommission)&&(identical(other.todayCommission, todayCommission) || other.todayCommission == todayCommission)&&(identical(other.monthCommission, monthCommission) || other.monthCommission == monthCommission)&&(identical(other.commissionRecordCount, commissionRecordCount) || other.commissionRecordCount == commissionRecordCount)&&(identical(other.lastCommissionAt, lastCommissionAt) || other.lastCommissionAt == lastCommissionAt)&&(identical(other.currency, currency) || other.currency == currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rankNo,userName,userStatus,levelDepth,registeredAt,totalCommission,todayCommission,monthCommission,commissionRecordCount,lastCommissionAt,currency);

@override
String toString() {
  return 'TeamContributionRank(rankNo: $rankNo, userName: $userName, userStatus: $userStatus, levelDepth: $levelDepth, registeredAt: $registeredAt, totalCommission: $totalCommission, todayCommission: $todayCommission, monthCommission: $monthCommission, commissionRecordCount: $commissionRecordCount, lastCommissionAt: $lastCommissionAt, currency: $currency)';
}


}

/// @nodoc
abstract mixin class _$TeamContributionRankCopyWith<$Res> implements $TeamContributionRankCopyWith<$Res> {
  factory _$TeamContributionRankCopyWith(_TeamContributionRank value, $Res Function(_TeamContributionRank) _then) = __$TeamContributionRankCopyWithImpl;
@override @useResult
$Res call({
 int? rankNo, String? userName, int? userStatus, int? levelDepth, String? registeredAt,@JsonKey(fromJson: _stringFromJson) String? totalCommission,@JsonKey(fromJson: _stringFromJson) String? todayCommission,@JsonKey(fromJson: _stringFromJson) String? monthCommission, int? commissionRecordCount, String? lastCommissionAt, String? currency
});




}
/// @nodoc
class __$TeamContributionRankCopyWithImpl<$Res>
    implements _$TeamContributionRankCopyWith<$Res> {
  __$TeamContributionRankCopyWithImpl(this._self, this._then);

  final _TeamContributionRank _self;
  final $Res Function(_TeamContributionRank) _then;

/// Create a copy of TeamContributionRank
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rankNo = freezed,Object? userName = freezed,Object? userStatus = freezed,Object? levelDepth = freezed,Object? registeredAt = freezed,Object? totalCommission = freezed,Object? todayCommission = freezed,Object? monthCommission = freezed,Object? commissionRecordCount = freezed,Object? lastCommissionAt = freezed,Object? currency = freezed,}) {
  return _then(_TeamContributionRank(
rankNo: freezed == rankNo ? _self.rankNo : rankNo // ignore: cast_nullable_to_non_nullable
as int?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,userStatus: freezed == userStatus ? _self.userStatus : userStatus // ignore: cast_nullable_to_non_nullable
as int?,levelDepth: freezed == levelDepth ? _self.levelDepth : levelDepth // ignore: cast_nullable_to_non_nullable
as int?,registeredAt: freezed == registeredAt ? _self.registeredAt : registeredAt // ignore: cast_nullable_to_non_nullable
as String?,totalCommission: freezed == totalCommission ? _self.totalCommission : totalCommission // ignore: cast_nullable_to_non_nullable
as String?,todayCommission: freezed == todayCommission ? _self.todayCommission : todayCommission // ignore: cast_nullable_to_non_nullable
as String?,monthCommission: freezed == monthCommission ? _self.monthCommission : monthCommission // ignore: cast_nullable_to_non_nullable
as String?,commissionRecordCount: freezed == commissionRecordCount ? _self.commissionRecordCount : commissionRecordCount // ignore: cast_nullable_to_non_nullable
as int?,lastCommissionAt: freezed == lastCommissionAt ? _self.lastCommissionAt : lastCommissionAt // ignore: cast_nullable_to_non_nullable
as String?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SettlementOrder {

 String? get settlementNo; String? get settlementType; String? get currency;@JsonKey(fromJson: _stringFromJson) String? get principalAmount;@JsonKey(fromJson: _stringFromJson) String? get profitAmount;@JsonKey(fromJson: _stringFromJson) String? get penaltyAmount;@JsonKey(fromJson: _stringFromJson) String? get actualSettleAmount; String? get status; String? get reviewedAt; String? get settledAt; String? get remark; String? get createdAt;
/// Create a copy of SettlementOrder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettlementOrderCopyWith<SettlementOrder> get copyWith => _$SettlementOrderCopyWithImpl<SettlementOrder>(this as SettlementOrder, _$identity);

  /// Serializes this SettlementOrder to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettlementOrder&&(identical(other.settlementNo, settlementNo) || other.settlementNo == settlementNo)&&(identical(other.settlementType, settlementType) || other.settlementType == settlementType)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.principalAmount, principalAmount) || other.principalAmount == principalAmount)&&(identical(other.profitAmount, profitAmount) || other.profitAmount == profitAmount)&&(identical(other.penaltyAmount, penaltyAmount) || other.penaltyAmount == penaltyAmount)&&(identical(other.actualSettleAmount, actualSettleAmount) || other.actualSettleAmount == actualSettleAmount)&&(identical(other.status, status) || other.status == status)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt)&&(identical(other.settledAt, settledAt) || other.settledAt == settledAt)&&(identical(other.remark, remark) || other.remark == remark)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,settlementNo,settlementType,currency,principalAmount,profitAmount,penaltyAmount,actualSettleAmount,status,reviewedAt,settledAt,remark,createdAt);

@override
String toString() {
  return 'SettlementOrder(settlementNo: $settlementNo, settlementType: $settlementType, currency: $currency, principalAmount: $principalAmount, profitAmount: $profitAmount, penaltyAmount: $penaltyAmount, actualSettleAmount: $actualSettleAmount, status: $status, reviewedAt: $reviewedAt, settledAt: $settledAt, remark: $remark, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $SettlementOrderCopyWith<$Res>  {
  factory $SettlementOrderCopyWith(SettlementOrder value, $Res Function(SettlementOrder) _then) = _$SettlementOrderCopyWithImpl;
@useResult
$Res call({
 String? settlementNo, String? settlementType, String? currency,@JsonKey(fromJson: _stringFromJson) String? principalAmount,@JsonKey(fromJson: _stringFromJson) String? profitAmount,@JsonKey(fromJson: _stringFromJson) String? penaltyAmount,@JsonKey(fromJson: _stringFromJson) String? actualSettleAmount, String? status, String? reviewedAt, String? settledAt, String? remark, String? createdAt
});




}
/// @nodoc
class _$SettlementOrderCopyWithImpl<$Res>
    implements $SettlementOrderCopyWith<$Res> {
  _$SettlementOrderCopyWithImpl(this._self, this._then);

  final SettlementOrder _self;
  final $Res Function(SettlementOrder) _then;

/// Create a copy of SettlementOrder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? settlementNo = freezed,Object? settlementType = freezed,Object? currency = freezed,Object? principalAmount = freezed,Object? profitAmount = freezed,Object? penaltyAmount = freezed,Object? actualSettleAmount = freezed,Object? status = freezed,Object? reviewedAt = freezed,Object? settledAt = freezed,Object? remark = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
settlementNo: freezed == settlementNo ? _self.settlementNo : settlementNo // ignore: cast_nullable_to_non_nullable
as String?,settlementType: freezed == settlementType ? _self.settlementType : settlementType // ignore: cast_nullable_to_non_nullable
as String?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,principalAmount: freezed == principalAmount ? _self.principalAmount : principalAmount // ignore: cast_nullable_to_non_nullable
as String?,profitAmount: freezed == profitAmount ? _self.profitAmount : profitAmount // ignore: cast_nullable_to_non_nullable
as String?,penaltyAmount: freezed == penaltyAmount ? _self.penaltyAmount : penaltyAmount // ignore: cast_nullable_to_non_nullable
as String?,actualSettleAmount: freezed == actualSettleAmount ? _self.actualSettleAmount : actualSettleAmount // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as String?,settledAt: freezed == settledAt ? _self.settledAt : settledAt // ignore: cast_nullable_to_non_nullable
as String?,remark: freezed == remark ? _self.remark : remark // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SettlementOrder].
extension SettlementOrderPatterns on SettlementOrder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettlementOrder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettlementOrder() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettlementOrder value)  $default,){
final _that = this;
switch (_that) {
case _SettlementOrder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettlementOrder value)?  $default,){
final _that = this;
switch (_that) {
case _SettlementOrder() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? settlementNo,  String? settlementType,  String? currency, @JsonKey(fromJson: _stringFromJson)  String? principalAmount, @JsonKey(fromJson: _stringFromJson)  String? profitAmount, @JsonKey(fromJson: _stringFromJson)  String? penaltyAmount, @JsonKey(fromJson: _stringFromJson)  String? actualSettleAmount,  String? status,  String? reviewedAt,  String? settledAt,  String? remark,  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettlementOrder() when $default != null:
return $default(_that.settlementNo,_that.settlementType,_that.currency,_that.principalAmount,_that.profitAmount,_that.penaltyAmount,_that.actualSettleAmount,_that.status,_that.reviewedAt,_that.settledAt,_that.remark,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? settlementNo,  String? settlementType,  String? currency, @JsonKey(fromJson: _stringFromJson)  String? principalAmount, @JsonKey(fromJson: _stringFromJson)  String? profitAmount, @JsonKey(fromJson: _stringFromJson)  String? penaltyAmount, @JsonKey(fromJson: _stringFromJson)  String? actualSettleAmount,  String? status,  String? reviewedAt,  String? settledAt,  String? remark,  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _SettlementOrder():
return $default(_that.settlementNo,_that.settlementType,_that.currency,_that.principalAmount,_that.profitAmount,_that.penaltyAmount,_that.actualSettleAmount,_that.status,_that.reviewedAt,_that.settledAt,_that.remark,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? settlementNo,  String? settlementType,  String? currency, @JsonKey(fromJson: _stringFromJson)  String? principalAmount, @JsonKey(fromJson: _stringFromJson)  String? profitAmount, @JsonKey(fromJson: _stringFromJson)  String? penaltyAmount, @JsonKey(fromJson: _stringFromJson)  String? actualSettleAmount,  String? status,  String? reviewedAt,  String? settledAt,  String? remark,  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _SettlementOrder() when $default != null:
return $default(_that.settlementNo,_that.settlementType,_that.currency,_that.principalAmount,_that.profitAmount,_that.penaltyAmount,_that.actualSettleAmount,_that.status,_that.reviewedAt,_that.settledAt,_that.remark,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SettlementOrder implements SettlementOrder {
  const _SettlementOrder({this.settlementNo, this.settlementType, this.currency, @JsonKey(fromJson: _stringFromJson) this.principalAmount, @JsonKey(fromJson: _stringFromJson) this.profitAmount, @JsonKey(fromJson: _stringFromJson) this.penaltyAmount, @JsonKey(fromJson: _stringFromJson) this.actualSettleAmount, this.status, this.reviewedAt, this.settledAt, this.remark, this.createdAt});
  factory _SettlementOrder.fromJson(Map<String, dynamic> json) => _$SettlementOrderFromJson(json);

@override final  String? settlementNo;
@override final  String? settlementType;
@override final  String? currency;
@override@JsonKey(fromJson: _stringFromJson) final  String? principalAmount;
@override@JsonKey(fromJson: _stringFromJson) final  String? profitAmount;
@override@JsonKey(fromJson: _stringFromJson) final  String? penaltyAmount;
@override@JsonKey(fromJson: _stringFromJson) final  String? actualSettleAmount;
@override final  String? status;
@override final  String? reviewedAt;
@override final  String? settledAt;
@override final  String? remark;
@override final  String? createdAt;

/// Create a copy of SettlementOrder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettlementOrderCopyWith<_SettlementOrder> get copyWith => __$SettlementOrderCopyWithImpl<_SettlementOrder>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SettlementOrderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettlementOrder&&(identical(other.settlementNo, settlementNo) || other.settlementNo == settlementNo)&&(identical(other.settlementType, settlementType) || other.settlementType == settlementType)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.principalAmount, principalAmount) || other.principalAmount == principalAmount)&&(identical(other.profitAmount, profitAmount) || other.profitAmount == profitAmount)&&(identical(other.penaltyAmount, penaltyAmount) || other.penaltyAmount == penaltyAmount)&&(identical(other.actualSettleAmount, actualSettleAmount) || other.actualSettleAmount == actualSettleAmount)&&(identical(other.status, status) || other.status == status)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt)&&(identical(other.settledAt, settledAt) || other.settledAt == settledAt)&&(identical(other.remark, remark) || other.remark == remark)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,settlementNo,settlementType,currency,principalAmount,profitAmount,penaltyAmount,actualSettleAmount,status,reviewedAt,settledAt,remark,createdAt);

@override
String toString() {
  return 'SettlementOrder(settlementNo: $settlementNo, settlementType: $settlementType, currency: $currency, principalAmount: $principalAmount, profitAmount: $profitAmount, penaltyAmount: $penaltyAmount, actualSettleAmount: $actualSettleAmount, status: $status, reviewedAt: $reviewedAt, settledAt: $settledAt, remark: $remark, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$SettlementOrderCopyWith<$Res> implements $SettlementOrderCopyWith<$Res> {
  factory _$SettlementOrderCopyWith(_SettlementOrder value, $Res Function(_SettlementOrder) _then) = __$SettlementOrderCopyWithImpl;
@override @useResult
$Res call({
 String? settlementNo, String? settlementType, String? currency,@JsonKey(fromJson: _stringFromJson) String? principalAmount,@JsonKey(fromJson: _stringFromJson) String? profitAmount,@JsonKey(fromJson: _stringFromJson) String? penaltyAmount,@JsonKey(fromJson: _stringFromJson) String? actualSettleAmount, String? status, String? reviewedAt, String? settledAt, String? remark, String? createdAt
});




}
/// @nodoc
class __$SettlementOrderCopyWithImpl<$Res>
    implements _$SettlementOrderCopyWith<$Res> {
  __$SettlementOrderCopyWithImpl(this._self, this._then);

  final _SettlementOrder _self;
  final $Res Function(_SettlementOrder) _then;

/// Create a copy of SettlementOrder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? settlementNo = freezed,Object? settlementType = freezed,Object? currency = freezed,Object? principalAmount = freezed,Object? profitAmount = freezed,Object? penaltyAmount = freezed,Object? actualSettleAmount = freezed,Object? status = freezed,Object? reviewedAt = freezed,Object? settledAt = freezed,Object? remark = freezed,Object? createdAt = freezed,}) {
  return _then(_SettlementOrder(
settlementNo: freezed == settlementNo ? _self.settlementNo : settlementNo // ignore: cast_nullable_to_non_nullable
as String?,settlementType: freezed == settlementType ? _self.settlementType : settlementType // ignore: cast_nullable_to_non_nullable
as String?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,principalAmount: freezed == principalAmount ? _self.principalAmount : principalAmount // ignore: cast_nullable_to_non_nullable
as String?,profitAmount: freezed == profitAmount ? _self.profitAmount : profitAmount // ignore: cast_nullable_to_non_nullable
as String?,penaltyAmount: freezed == penaltyAmount ? _self.penaltyAmount : penaltyAmount // ignore: cast_nullable_to_non_nullable
as String?,actualSettleAmount: freezed == actualSettleAmount ? _self.actualSettleAmount : actualSettleAmount // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as String?,settledAt: freezed == settledAt ? _self.settledAt : settledAt // ignore: cast_nullable_to_non_nullable
as String?,remark: freezed == remark ? _self.remark : remark // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$NotificationItem {

 int? get id; String? get title; String? get content; String? get type; String? get bizType; int? get readStatus; String? get readAt; String? get createdAt; String? get locale; String? get requestedLocale; bool? get localeFallback;
/// Create a copy of NotificationItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationItemCopyWith<NotificationItem> get copyWith => _$NotificationItemCopyWithImpl<NotificationItem>(this as NotificationItem, _$identity);

  /// Serializes this NotificationItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&(identical(other.bizType, bizType) || other.bizType == bizType)&&(identical(other.readStatus, readStatus) || other.readStatus == readStatus)&&(identical(other.readAt, readAt) || other.readAt == readAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.requestedLocale, requestedLocale) || other.requestedLocale == requestedLocale)&&(identical(other.localeFallback, localeFallback) || other.localeFallback == localeFallback));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,content,type,bizType,readStatus,readAt,createdAt,locale,requestedLocale,localeFallback);

@override
String toString() {
  return 'NotificationItem(id: $id, title: $title, content: $content, type: $type, bizType: $bizType, readStatus: $readStatus, readAt: $readAt, createdAt: $createdAt, locale: $locale, requestedLocale: $requestedLocale, localeFallback: $localeFallback)';
}


}

/// @nodoc
abstract mixin class $NotificationItemCopyWith<$Res>  {
  factory $NotificationItemCopyWith(NotificationItem value, $Res Function(NotificationItem) _then) = _$NotificationItemCopyWithImpl;
@useResult
$Res call({
 int? id, String? title, String? content, String? type, String? bizType, int? readStatus, String? readAt, String? createdAt, String? locale, String? requestedLocale, bool? localeFallback
});




}
/// @nodoc
class _$NotificationItemCopyWithImpl<$Res>
    implements $NotificationItemCopyWith<$Res> {
  _$NotificationItemCopyWithImpl(this._self, this._then);

  final NotificationItem _self;
  final $Res Function(NotificationItem) _then;

/// Create a copy of NotificationItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? title = freezed,Object? content = freezed,Object? type = freezed,Object? bizType = freezed,Object? readStatus = freezed,Object? readAt = freezed,Object? createdAt = freezed,Object? locale = freezed,Object? requestedLocale = freezed,Object? localeFallback = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,bizType: freezed == bizType ? _self.bizType : bizType // ignore: cast_nullable_to_non_nullable
as String?,readStatus: freezed == readStatus ? _self.readStatus : readStatus // ignore: cast_nullable_to_non_nullable
as int?,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,locale: freezed == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String?,requestedLocale: freezed == requestedLocale ? _self.requestedLocale : requestedLocale // ignore: cast_nullable_to_non_nullable
as String?,localeFallback: freezed == localeFallback ? _self.localeFallback : localeFallback // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationItem].
extension NotificationItemPatterns on NotificationItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationItem value)  $default,){
final _that = this;
switch (_that) {
case _NotificationItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationItem value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String? title,  String? content,  String? type,  String? bizType,  int? readStatus,  String? readAt,  String? createdAt,  String? locale,  String? requestedLocale,  bool? localeFallback)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationItem() when $default != null:
return $default(_that.id,_that.title,_that.content,_that.type,_that.bizType,_that.readStatus,_that.readAt,_that.createdAt,_that.locale,_that.requestedLocale,_that.localeFallback);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String? title,  String? content,  String? type,  String? bizType,  int? readStatus,  String? readAt,  String? createdAt,  String? locale,  String? requestedLocale,  bool? localeFallback)  $default,) {final _that = this;
switch (_that) {
case _NotificationItem():
return $default(_that.id,_that.title,_that.content,_that.type,_that.bizType,_that.readStatus,_that.readAt,_that.createdAt,_that.locale,_that.requestedLocale,_that.localeFallback);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String? title,  String? content,  String? type,  String? bizType,  int? readStatus,  String? readAt,  String? createdAt,  String? locale,  String? requestedLocale,  bool? localeFallback)?  $default,) {final _that = this;
switch (_that) {
case _NotificationItem() when $default != null:
return $default(_that.id,_that.title,_that.content,_that.type,_that.bizType,_that.readStatus,_that.readAt,_that.createdAt,_that.locale,_that.requestedLocale,_that.localeFallback);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationItem implements NotificationItem {
  const _NotificationItem({this.id, this.title, this.content, this.type, this.bizType, this.readStatus, this.readAt, this.createdAt, this.locale, this.requestedLocale, this.localeFallback});
  factory _NotificationItem.fromJson(Map<String, dynamic> json) => _$NotificationItemFromJson(json);

@override final  int? id;
@override final  String? title;
@override final  String? content;
@override final  String? type;
@override final  String? bizType;
@override final  int? readStatus;
@override final  String? readAt;
@override final  String? createdAt;
@override final  String? locale;
@override final  String? requestedLocale;
@override final  bool? localeFallback;

/// Create a copy of NotificationItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationItemCopyWith<_NotificationItem> get copyWith => __$NotificationItemCopyWithImpl<_NotificationItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&(identical(other.bizType, bizType) || other.bizType == bizType)&&(identical(other.readStatus, readStatus) || other.readStatus == readStatus)&&(identical(other.readAt, readAt) || other.readAt == readAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.requestedLocale, requestedLocale) || other.requestedLocale == requestedLocale)&&(identical(other.localeFallback, localeFallback) || other.localeFallback == localeFallback));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,content,type,bizType,readStatus,readAt,createdAt,locale,requestedLocale,localeFallback);

@override
String toString() {
  return 'NotificationItem(id: $id, title: $title, content: $content, type: $type, bizType: $bizType, readStatus: $readStatus, readAt: $readAt, createdAt: $createdAt, locale: $locale, requestedLocale: $requestedLocale, localeFallback: $localeFallback)';
}


}

/// @nodoc
abstract mixin class _$NotificationItemCopyWith<$Res> implements $NotificationItemCopyWith<$Res> {
  factory _$NotificationItemCopyWith(_NotificationItem value, $Res Function(_NotificationItem) _then) = __$NotificationItemCopyWithImpl;
@override @useResult
$Res call({
 int? id, String? title, String? content, String? type, String? bizType, int? readStatus, String? readAt, String? createdAt, String? locale, String? requestedLocale, bool? localeFallback
});




}
/// @nodoc
class __$NotificationItemCopyWithImpl<$Res>
    implements _$NotificationItemCopyWith<$Res> {
  __$NotificationItemCopyWithImpl(this._self, this._then);

  final _NotificationItem _self;
  final $Res Function(_NotificationItem) _then;

/// Create a copy of NotificationItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? title = freezed,Object? content = freezed,Object? type = freezed,Object? bizType = freezed,Object? readStatus = freezed,Object? readAt = freezed,Object? createdAt = freezed,Object? locale = freezed,Object? requestedLocale = freezed,Object? localeFallback = freezed,}) {
  return _then(_NotificationItem(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,bizType: freezed == bizType ? _self.bizType : bizType // ignore: cast_nullable_to_non_nullable
as String?,readStatus: freezed == readStatus ? _self.readStatus : readStatus // ignore: cast_nullable_to_non_nullable
as int?,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,locale: freezed == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String?,requestedLocale: freezed == requestedLocale ? _self.requestedLocale : requestedLocale // ignore: cast_nullable_to_non_nullable
as String?,localeFallback: freezed == localeFallback ? _self.localeFallback : localeFallback // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
