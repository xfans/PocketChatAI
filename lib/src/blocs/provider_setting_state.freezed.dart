// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'provider_setting_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProviderSettingLoaded {

 ModelProvider? get provider; List<ModelProvider>? get providers; bool? get isApiKeyValid; bool? get isCheckingApiKey;
/// Create a copy of ProviderSettingLoaded
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProviderSettingLoadedCopyWith<ProviderSettingState> get copyWith => _$ProviderSettingLoadedCopyWithImpl<ProviderSettingState>(this as ProviderSettingState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProviderSettingState&&(identical(other.provider, provider) || other.provider == provider)&&const DeepCollectionEquality().equals(other.providers, providers)&&(identical(other.isApiKeyValid, isApiKeyValid) || other.isApiKeyValid == isApiKeyValid)&&(identical(other.isCheckingApiKey, isCheckingApiKey) || other.isCheckingApiKey == isCheckingApiKey));
}


@override
int get hashCode => Object.hash(runtimeType,provider,const DeepCollectionEquality().hash(providers),isApiKeyValid,isCheckingApiKey);

@override
String toString() {
  return 'ProviderSettingLoaded(provider: $provider, providers: $providers, isApiKeyValid: $isApiKeyValid, isCheckingApiKey: $isCheckingApiKey)';
}


}

/// @nodoc
abstract mixin class $ProviderSettingLoadedCopyWith<$Res>  {
  factory $ProviderSettingLoadedCopyWith(ProviderSettingState value, $Res Function(ProviderSettingState) _then) = _$ProviderSettingLoadedCopyWithImpl;
@useResult
$Res call({
 ModelProvider? provider, List<ModelProvider>? providers, bool? isApiKeyValid, bool? isCheckingApiKey
});


$ModelProviderCopyWith<$Res>? get provider;

}
/// @nodoc
class _$ProviderSettingLoadedCopyWithImpl<$Res>
    implements $ProviderSettingLoadedCopyWith<$Res> {
  _$ProviderSettingLoadedCopyWithImpl(this._self, this._then);

  final ProviderSettingState _self;
  final $Res Function(ProviderSettingState) _then;

/// Create a copy of ProviderSettingLoaded
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? provider = freezed,Object? providers = freezed,Object? isApiKeyValid = freezed,Object? isCheckingApiKey = freezed,}) {
  return _then(_self.copyWith(
provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as ModelProvider?,providers: freezed == providers ? _self.providers : providers // ignore: cast_nullable_to_non_nullable
as List<ModelProvider>?,isApiKeyValid: freezed == isApiKeyValid ? _self.isApiKeyValid : isApiKeyValid // ignore: cast_nullable_to_non_nullable
as bool?,isCheckingApiKey: freezed == isCheckingApiKey ? _self.isCheckingApiKey : isCheckingApiKey // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}
/// Create a copy of ProviderSettingLoaded
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ModelProviderCopyWith<$Res>? get provider {
    if (_self.provider == null) {
    return null;
  }

  return $ModelProviderCopyWith<$Res>(_self.provider!, (value) {
    return _then(_self.copyWith(provider: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProviderSettingState].
extension ProviderSettingLoadedPatterns on ProviderSettingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProviderSettingLoaded value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProviderSettingLoaded() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProviderSettingLoaded value)  $default,){
final _that = this;
switch (_that) {
case _ProviderSettingLoaded():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProviderSettingLoaded value)?  $default,){
final _that = this;
switch (_that) {
case _ProviderSettingLoaded() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ModelProvider? provider,  List<ModelProvider>? providers,  bool? isApiKeyValid,  bool? isCheckingApiKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProviderSettingLoaded() when $default != null:
return $default(_that.provider,_that.providers,_that.isApiKeyValid,_that.isCheckingApiKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ModelProvider? provider,  List<ModelProvider>? providers,  bool? isApiKeyValid,  bool? isCheckingApiKey)  $default,) {final _that = this;
switch (_that) {
case _ProviderSettingLoaded():
return $default(_that.provider,_that.providers,_that.isApiKeyValid,_that.isCheckingApiKey);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ModelProvider? provider,  List<ModelProvider>? providers,  bool? isApiKeyValid,  bool? isCheckingApiKey)?  $default,) {final _that = this;
switch (_that) {
case _ProviderSettingLoaded() when $default != null:
return $default(_that.provider,_that.providers,_that.isApiKeyValid,_that.isCheckingApiKey);case _:
  return null;

}
}

}

/// @nodoc


class _ProviderSettingLoaded implements ProviderSettingState {
  const _ProviderSettingLoaded({this.provider, final  List<ModelProvider>? providers, this.isApiKeyValid, this.isCheckingApiKey}): _providers = providers;
  

@override final  ModelProvider? provider;
 final  List<ModelProvider>? _providers;
@override List<ModelProvider>? get providers {
  final value = _providers;
  if (value == null) return null;
  if (_providers is EqualUnmodifiableListView) return _providers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  bool? isApiKeyValid;
@override final  bool? isCheckingApiKey;

/// Create a copy of ProviderSettingLoaded
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProviderSettingLoadedCopyWith<_ProviderSettingLoaded> get copyWith => __$ProviderSettingLoadedCopyWithImpl<_ProviderSettingLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProviderSettingLoaded&&(identical(other.provider, provider) || other.provider == provider)&&const DeepCollectionEquality().equals(other._providers, _providers)&&(identical(other.isApiKeyValid, isApiKeyValid) || other.isApiKeyValid == isApiKeyValid)&&(identical(other.isCheckingApiKey, isCheckingApiKey) || other.isCheckingApiKey == isCheckingApiKey));
}


@override
int get hashCode => Object.hash(runtimeType,provider,const DeepCollectionEquality().hash(_providers),isApiKeyValid,isCheckingApiKey);

@override
String toString() {
  return 'ProviderSettingLoaded(provider: $provider, providers: $providers, isApiKeyValid: $isApiKeyValid, isCheckingApiKey: $isCheckingApiKey)';
}


}

/// @nodoc
abstract mixin class _$ProviderSettingLoadedCopyWith<$Res> implements $ProviderSettingLoadedCopyWith<$Res> {
  factory _$ProviderSettingLoadedCopyWith(_ProviderSettingLoaded value, $Res Function(_ProviderSettingLoaded) _then) = __$ProviderSettingLoadedCopyWithImpl;
@override @useResult
$Res call({
 ModelProvider? provider, List<ModelProvider>? providers, bool? isApiKeyValid, bool? isCheckingApiKey
});


@override $ModelProviderCopyWith<$Res>? get provider;

}
/// @nodoc
class __$ProviderSettingLoadedCopyWithImpl<$Res>
    implements _$ProviderSettingLoadedCopyWith<$Res> {
  __$ProviderSettingLoadedCopyWithImpl(this._self, this._then);

  final _ProviderSettingLoaded _self;
  final $Res Function(_ProviderSettingLoaded) _then;

/// Create a copy of ProviderSettingLoaded
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? provider = freezed,Object? providers = freezed,Object? isApiKeyValid = freezed,Object? isCheckingApiKey = freezed,}) {
  return _then(_ProviderSettingLoaded(
provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as ModelProvider?,providers: freezed == providers ? _self._providers : providers // ignore: cast_nullable_to_non_nullable
as List<ModelProvider>?,isApiKeyValid: freezed == isApiKeyValid ? _self.isApiKeyValid : isApiKeyValid // ignore: cast_nullable_to_non_nullable
as bool?,isCheckingApiKey: freezed == isCheckingApiKey ? _self.isCheckingApiKey : isCheckingApiKey // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

/// Create a copy of ProviderSettingLoaded
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ModelProviderCopyWith<$Res>? get provider {
    if (_self.provider == null) {
    return null;
  }

  return $ModelProviderCopyWith<$Res>(_self.provider!, (value) {
    return _then(_self.copyWith(provider: value));
  });
}
}

// dart format on
