// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ModelProvider {

 String get id; String get name; String get type; String? get website; String? get apiKey; String? get apiHost; String? get apiPath; String? get endpoint; String? get apiVersion; List<ModelInfo> get models;
/// Create a copy of ModelProvider
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModelProviderCopyWith<ModelProvider> get copyWith => _$ModelProviderCopyWithImpl<ModelProvider>(this as ModelProvider, _$identity);

  /// Serializes this ModelProvider to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModelProvider&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.website, website) || other.website == website)&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey)&&(identical(other.apiHost, apiHost) || other.apiHost == apiHost)&&(identical(other.apiPath, apiPath) || other.apiPath == apiPath)&&(identical(other.endpoint, endpoint) || other.endpoint == endpoint)&&(identical(other.apiVersion, apiVersion) || other.apiVersion == apiVersion)&&const DeepCollectionEquality().equals(other.models, models));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,website,apiKey,apiHost,apiPath,endpoint,apiVersion,const DeepCollectionEquality().hash(models));

@override
String toString() {
  return 'ModelProvider(id: $id, name: $name, type: $type, website: $website, apiKey: $apiKey, apiHost: $apiHost, apiPath: $apiPath, endpoint: $endpoint, apiVersion: $apiVersion, models: $models)';
}


}

/// @nodoc
abstract mixin class $ModelProviderCopyWith<$Res>  {
  factory $ModelProviderCopyWith(ModelProvider value, $Res Function(ModelProvider) _then) = _$ModelProviderCopyWithImpl;
@useResult
$Res call({
 String id, String name, String type, String? website, String? apiKey, String? apiHost, String? apiPath, String? endpoint, String? apiVersion, List<ModelInfo> models
});




}
/// @nodoc
class _$ModelProviderCopyWithImpl<$Res>
    implements $ModelProviderCopyWith<$Res> {
  _$ModelProviderCopyWithImpl(this._self, this._then);

  final ModelProvider _self;
  final $Res Function(ModelProvider) _then;

/// Create a copy of ModelProvider
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? type = null,Object? website = freezed,Object? apiKey = freezed,Object? apiHost = freezed,Object? apiPath = freezed,Object? endpoint = freezed,Object? apiVersion = freezed,Object? models = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,apiKey: freezed == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String?,apiHost: freezed == apiHost ? _self.apiHost : apiHost // ignore: cast_nullable_to_non_nullable
as String?,apiPath: freezed == apiPath ? _self.apiPath : apiPath // ignore: cast_nullable_to_non_nullable
as String?,endpoint: freezed == endpoint ? _self.endpoint : endpoint // ignore: cast_nullable_to_non_nullable
as String?,apiVersion: freezed == apiVersion ? _self.apiVersion : apiVersion // ignore: cast_nullable_to_non_nullable
as String?,models: null == models ? _self.models : models // ignore: cast_nullable_to_non_nullable
as List<ModelInfo>,
  ));
}

}


/// Adds pattern-matching-related methods to [ModelProvider].
extension ModelProviderPatterns on ModelProvider {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ModelProvider value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ModelProvider() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ModelProvider value)  $default,){
final _that = this;
switch (_that) {
case _ModelProvider():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ModelProvider value)?  $default,){
final _that = this;
switch (_that) {
case _ModelProvider() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String type,  String? website,  String? apiKey,  String? apiHost,  String? apiPath,  String? endpoint,  String? apiVersion,  List<ModelInfo> models)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ModelProvider() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.website,_that.apiKey,_that.apiHost,_that.apiPath,_that.endpoint,_that.apiVersion,_that.models);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String type,  String? website,  String? apiKey,  String? apiHost,  String? apiPath,  String? endpoint,  String? apiVersion,  List<ModelInfo> models)  $default,) {final _that = this;
switch (_that) {
case _ModelProvider():
return $default(_that.id,_that.name,_that.type,_that.website,_that.apiKey,_that.apiHost,_that.apiPath,_that.endpoint,_that.apiVersion,_that.models);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String type,  String? website,  String? apiKey,  String? apiHost,  String? apiPath,  String? endpoint,  String? apiVersion,  List<ModelInfo> models)?  $default,) {final _that = this;
switch (_that) {
case _ModelProvider() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.website,_that.apiKey,_that.apiHost,_that.apiPath,_that.endpoint,_that.apiVersion,_that.models);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ModelProvider implements ModelProvider {
  const _ModelProvider({required this.id, required this.name, required this.type, this.website, this.apiKey, this.apiHost, this.apiPath, this.endpoint, this.apiVersion, required final  List<ModelInfo> models}): _models = models;
  factory _ModelProvider.fromJson(Map<String, dynamic> json) => _$ModelProviderFromJson(json);

@override final  String id;
@override final  String name;
@override final  String type;
@override final  String? website;
@override final  String? apiKey;
@override final  String? apiHost;
@override final  String? apiPath;
@override final  String? endpoint;
@override final  String? apiVersion;
 final  List<ModelInfo> _models;
@override List<ModelInfo> get models {
  if (_models is EqualUnmodifiableListView) return _models;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_models);
}


/// Create a copy of ModelProvider
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ModelProviderCopyWith<_ModelProvider> get copyWith => __$ModelProviderCopyWithImpl<_ModelProvider>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ModelProviderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ModelProvider&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.website, website) || other.website == website)&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey)&&(identical(other.apiHost, apiHost) || other.apiHost == apiHost)&&(identical(other.apiPath, apiPath) || other.apiPath == apiPath)&&(identical(other.endpoint, endpoint) || other.endpoint == endpoint)&&(identical(other.apiVersion, apiVersion) || other.apiVersion == apiVersion)&&const DeepCollectionEquality().equals(other._models, _models));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,website,apiKey,apiHost,apiPath,endpoint,apiVersion,const DeepCollectionEquality().hash(_models));

@override
String toString() {
  return 'ModelProvider(id: $id, name: $name, type: $type, website: $website, apiKey: $apiKey, apiHost: $apiHost, apiPath: $apiPath, endpoint: $endpoint, apiVersion: $apiVersion, models: $models)';
}


}

/// @nodoc
abstract mixin class _$ModelProviderCopyWith<$Res> implements $ModelProviderCopyWith<$Res> {
  factory _$ModelProviderCopyWith(_ModelProvider value, $Res Function(_ModelProvider) _then) = __$ModelProviderCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String type, String? website, String? apiKey, String? apiHost, String? apiPath, String? endpoint, String? apiVersion, List<ModelInfo> models
});




}
/// @nodoc
class __$ModelProviderCopyWithImpl<$Res>
    implements _$ModelProviderCopyWith<$Res> {
  __$ModelProviderCopyWithImpl(this._self, this._then);

  final _ModelProvider _self;
  final $Res Function(_ModelProvider) _then;

/// Create a copy of ModelProvider
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? type = null,Object? website = freezed,Object? apiKey = freezed,Object? apiHost = freezed,Object? apiPath = freezed,Object? endpoint = freezed,Object? apiVersion = freezed,Object? models = null,}) {
  return _then(_ModelProvider(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,apiKey: freezed == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String?,apiHost: freezed == apiHost ? _self.apiHost : apiHost // ignore: cast_nullable_to_non_nullable
as String?,apiPath: freezed == apiPath ? _self.apiPath : apiPath // ignore: cast_nullable_to_non_nullable
as String?,endpoint: freezed == endpoint ? _self.endpoint : endpoint // ignore: cast_nullable_to_non_nullable
as String?,apiVersion: freezed == apiVersion ? _self.apiVersion : apiVersion // ignore: cast_nullable_to_non_nullable
as String?,models: null == models ? _self._models : models // ignore: cast_nullable_to_non_nullable
as List<ModelInfo>,
  ));
}


}


/// @nodoc
mixin _$ModelInfo {

 String get modelId; String? get type; String? get nickname; List<String> get capabilities; int? get contextWindow; int? get maxOutput;
/// Create a copy of ModelInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModelInfoCopyWith<ModelInfo> get copyWith => _$ModelInfoCopyWithImpl<ModelInfo>(this as ModelInfo, _$identity);

  /// Serializes this ModelInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModelInfo&&(identical(other.modelId, modelId) || other.modelId == modelId)&&(identical(other.type, type) || other.type == type)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&const DeepCollectionEquality().equals(other.capabilities, capabilities)&&(identical(other.contextWindow, contextWindow) || other.contextWindow == contextWindow)&&(identical(other.maxOutput, maxOutput) || other.maxOutput == maxOutput));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,modelId,type,nickname,const DeepCollectionEquality().hash(capabilities),contextWindow,maxOutput);

@override
String toString() {
  return 'ModelInfo(modelId: $modelId, type: $type, nickname: $nickname, capabilities: $capabilities, contextWindow: $contextWindow, maxOutput: $maxOutput)';
}


}

/// @nodoc
abstract mixin class $ModelInfoCopyWith<$Res>  {
  factory $ModelInfoCopyWith(ModelInfo value, $Res Function(ModelInfo) _then) = _$ModelInfoCopyWithImpl;
@useResult
$Res call({
 String modelId, String? type, String? nickname, List<String> capabilities, int? contextWindow, int? maxOutput
});




}
/// @nodoc
class _$ModelInfoCopyWithImpl<$Res>
    implements $ModelInfoCopyWith<$Res> {
  _$ModelInfoCopyWithImpl(this._self, this._then);

  final ModelInfo _self;
  final $Res Function(ModelInfo) _then;

/// Create a copy of ModelInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? modelId = null,Object? type = freezed,Object? nickname = freezed,Object? capabilities = null,Object? contextWindow = freezed,Object? maxOutput = freezed,}) {
  return _then(_self.copyWith(
modelId: null == modelId ? _self.modelId : modelId // ignore: cast_nullable_to_non_nullable
as String,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,nickname: freezed == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String?,capabilities: null == capabilities ? _self.capabilities : capabilities // ignore: cast_nullable_to_non_nullable
as List<String>,contextWindow: freezed == contextWindow ? _self.contextWindow : contextWindow // ignore: cast_nullable_to_non_nullable
as int?,maxOutput: freezed == maxOutput ? _self.maxOutput : maxOutput // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ModelInfo].
extension ModelInfoPatterns on ModelInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ModelInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ModelInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ModelInfo value)  $default,){
final _that = this;
switch (_that) {
case _ModelInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ModelInfo value)?  $default,){
final _that = this;
switch (_that) {
case _ModelInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String modelId,  String? type,  String? nickname,  List<String> capabilities,  int? contextWindow,  int? maxOutput)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ModelInfo() when $default != null:
return $default(_that.modelId,_that.type,_that.nickname,_that.capabilities,_that.contextWindow,_that.maxOutput);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String modelId,  String? type,  String? nickname,  List<String> capabilities,  int? contextWindow,  int? maxOutput)  $default,) {final _that = this;
switch (_that) {
case _ModelInfo():
return $default(_that.modelId,_that.type,_that.nickname,_that.capabilities,_that.contextWindow,_that.maxOutput);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String modelId,  String? type,  String? nickname,  List<String> capabilities,  int? contextWindow,  int? maxOutput)?  $default,) {final _that = this;
switch (_that) {
case _ModelInfo() when $default != null:
return $default(_that.modelId,_that.type,_that.nickname,_that.capabilities,_that.contextWindow,_that.maxOutput);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ModelInfo implements ModelInfo {
  const _ModelInfo({required this.modelId, this.type, this.nickname, required final  List<String> capabilities, this.contextWindow, this.maxOutput}): _capabilities = capabilities;
  factory _ModelInfo.fromJson(Map<String, dynamic> json) => _$ModelInfoFromJson(json);

@override final  String modelId;
@override final  String? type;
@override final  String? nickname;
 final  List<String> _capabilities;
@override List<String> get capabilities {
  if (_capabilities is EqualUnmodifiableListView) return _capabilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_capabilities);
}

@override final  int? contextWindow;
@override final  int? maxOutput;

/// Create a copy of ModelInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ModelInfoCopyWith<_ModelInfo> get copyWith => __$ModelInfoCopyWithImpl<_ModelInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ModelInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ModelInfo&&(identical(other.modelId, modelId) || other.modelId == modelId)&&(identical(other.type, type) || other.type == type)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&const DeepCollectionEquality().equals(other._capabilities, _capabilities)&&(identical(other.contextWindow, contextWindow) || other.contextWindow == contextWindow)&&(identical(other.maxOutput, maxOutput) || other.maxOutput == maxOutput));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,modelId,type,nickname,const DeepCollectionEquality().hash(_capabilities),contextWindow,maxOutput);

@override
String toString() {
  return 'ModelInfo(modelId: $modelId, type: $type, nickname: $nickname, capabilities: $capabilities, contextWindow: $contextWindow, maxOutput: $maxOutput)';
}


}

/// @nodoc
abstract mixin class _$ModelInfoCopyWith<$Res> implements $ModelInfoCopyWith<$Res> {
  factory _$ModelInfoCopyWith(_ModelInfo value, $Res Function(_ModelInfo) _then) = __$ModelInfoCopyWithImpl;
@override @useResult
$Res call({
 String modelId, String? type, String? nickname, List<String> capabilities, int? contextWindow, int? maxOutput
});




}
/// @nodoc
class __$ModelInfoCopyWithImpl<$Res>
    implements _$ModelInfoCopyWith<$Res> {
  __$ModelInfoCopyWithImpl(this._self, this._then);

  final _ModelInfo _self;
  final $Res Function(_ModelInfo) _then;

/// Create a copy of ModelInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? modelId = null,Object? type = freezed,Object? nickname = freezed,Object? capabilities = null,Object? contextWindow = freezed,Object? maxOutput = freezed,}) {
  return _then(_ModelInfo(
modelId: null == modelId ? _self.modelId : modelId // ignore: cast_nullable_to_non_nullable
as String,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,nickname: freezed == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String?,capabilities: null == capabilities ? _self._capabilities : capabilities // ignore: cast_nullable_to_non_nullable
as List<String>,contextWindow: freezed == contextWindow ? _self.contextWindow : contextWindow // ignore: cast_nullable_to_non_nullable
as int?,maxOutput: freezed == maxOutput ? _self.maxOutput : maxOutput // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
