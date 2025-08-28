// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ServiceMetadata _$ServiceMetadataFromJson(Map<String, dynamic> json) {
  return _ServiceMetadata.fromJson(json);
}

/// @nodoc
mixin _$ServiceMetadata {
  String get sourceName => throw _privateConstructorUsedError;
  ServiceAuthor get author => throw _privateConstructorUsedError;
  String get iconUrl => throw _privateConstructorUsedError;
  String get version => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;
  String get baseUrl => throw _privateConstructorUsedError;
  String get streamType => throw _privateConstructorUsedError;
  String get quality => throw _privateConstructorUsedError;
  String get searchBaseUrl => throw _privateConstructorUsedError;
  String get scriptUrl => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  bool? get softsub => throw _privateConstructorUsedError;
  bool? get multiStream => throw _privateConstructorUsedError;
  bool? get multiSubs => throw _privateConstructorUsedError;
  bool? get novel => throw _privateConstructorUsedError;
  bool? get settings => throw _privateConstructorUsedError;
  bool? get asyncJS => throw _privateConstructorUsedError;
  bool? get streamAsyncJS => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  bool? get downloadSupport => throw _privateConstructorUsedError;

  /// Serializes this ServiceMetadata to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ServiceMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServiceMetadataCopyWith<ServiceMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceMetadataCopyWith<$Res> {
  factory $ServiceMetadataCopyWith(
          ServiceMetadata value, $Res Function(ServiceMetadata) then) =
      _$ServiceMetadataCopyWithImpl<$Res, ServiceMetadata>;
  @useResult
  $Res call(
      {String sourceName,
      ServiceAuthor author,
      String iconUrl,
      String version,
      String language,
      String baseUrl,
      String streamType,
      String quality,
      String searchBaseUrl,
      String scriptUrl,
      String? type,
      bool? softsub,
      bool? multiStream,
      bool? multiSubs,
      bool? novel,
      bool? settings,
      bool? asyncJS,
      bool? streamAsyncJS,
      String? note,
      bool? downloadSupport});

  $ServiceAuthorCopyWith<$Res> get author;
}

/// @nodoc
class _$ServiceMetadataCopyWithImpl<$Res, $Val extends ServiceMetadata>
    implements $ServiceMetadataCopyWith<$Res> {
  _$ServiceMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServiceMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sourceName = null,
    Object? author = null,
    Object? iconUrl = null,
    Object? version = null,
    Object? language = null,
    Object? baseUrl = null,
    Object? streamType = null,
    Object? quality = null,
    Object? searchBaseUrl = null,
    Object? scriptUrl = null,
    Object? type = freezed,
    Object? softsub = freezed,
    Object? multiStream = freezed,
    Object? multiSubs = freezed,
    Object? novel = freezed,
    Object? settings = freezed,
    Object? asyncJS = freezed,
    Object? streamAsyncJS = freezed,
    Object? note = freezed,
    Object? downloadSupport = freezed,
  }) {
    return _then(_value.copyWith(
      sourceName: null == sourceName
          ? _value.sourceName
          : sourceName // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as ServiceAuthor,
      iconUrl: null == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      baseUrl: null == baseUrl
          ? _value.baseUrl
          : baseUrl // ignore: cast_nullable_to_non_nullable
              as String,
      streamType: null == streamType
          ? _value.streamType
          : streamType // ignore: cast_nullable_to_non_nullable
              as String,
      quality: null == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as String,
      searchBaseUrl: null == searchBaseUrl
          ? _value.searchBaseUrl
          : searchBaseUrl // ignore: cast_nullable_to_non_nullable
              as String,
      scriptUrl: null == scriptUrl
          ? _value.scriptUrl
          : scriptUrl // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      softsub: freezed == softsub
          ? _value.softsub
          : softsub // ignore: cast_nullable_to_non_nullable
              as bool?,
      multiStream: freezed == multiStream
          ? _value.multiStream
          : multiStream // ignore: cast_nullable_to_non_nullable
              as bool?,
      multiSubs: freezed == multiSubs
          ? _value.multiSubs
          : multiSubs // ignore: cast_nullable_to_non_nullable
              as bool?,
      novel: freezed == novel
          ? _value.novel
          : novel // ignore: cast_nullable_to_non_nullable
              as bool?,
      settings: freezed == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as bool?,
      asyncJS: freezed == asyncJS
          ? _value.asyncJS
          : asyncJS // ignore: cast_nullable_to_non_nullable
              as bool?,
      streamAsyncJS: freezed == streamAsyncJS
          ? _value.streamAsyncJS
          : streamAsyncJS // ignore: cast_nullable_to_non_nullable
              as bool?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      downloadSupport: freezed == downloadSupport
          ? _value.downloadSupport
          : downloadSupport // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  /// Create a copy of ServiceMetadata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ServiceAuthorCopyWith<$Res> get author {
    return $ServiceAuthorCopyWith<$Res>(_value.author, (value) {
      return _then(_value.copyWith(author: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ServiceMetadataImplCopyWith<$Res>
    implements $ServiceMetadataCopyWith<$Res> {
  factory _$$ServiceMetadataImplCopyWith(_$ServiceMetadataImpl value,
          $Res Function(_$ServiceMetadataImpl) then) =
      __$$ServiceMetadataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String sourceName,
      ServiceAuthor author,
      String iconUrl,
      String version,
      String language,
      String baseUrl,
      String streamType,
      String quality,
      String searchBaseUrl,
      String scriptUrl,
      String? type,
      bool? softsub,
      bool? multiStream,
      bool? multiSubs,
      bool? novel,
      bool? settings,
      bool? asyncJS,
      bool? streamAsyncJS,
      String? note,
      bool? downloadSupport});

  @override
  $ServiceAuthorCopyWith<$Res> get author;
}

/// @nodoc
class __$$ServiceMetadataImplCopyWithImpl<$Res>
    extends _$ServiceMetadataCopyWithImpl<$Res, _$ServiceMetadataImpl>
    implements _$$ServiceMetadataImplCopyWith<$Res> {
  __$$ServiceMetadataImplCopyWithImpl(
      _$ServiceMetadataImpl _value, $Res Function(_$ServiceMetadataImpl) _then)
      : super(_value, _then);

  /// Create a copy of ServiceMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sourceName = null,
    Object? author = null,
    Object? iconUrl = null,
    Object? version = null,
    Object? language = null,
    Object? baseUrl = null,
    Object? streamType = null,
    Object? quality = null,
    Object? searchBaseUrl = null,
    Object? scriptUrl = null,
    Object? type = freezed,
    Object? softsub = freezed,
    Object? multiStream = freezed,
    Object? multiSubs = freezed,
    Object? novel = freezed,
    Object? settings = freezed,
    Object? asyncJS = freezed,
    Object? streamAsyncJS = freezed,
    Object? note = freezed,
    Object? downloadSupport = freezed,
  }) {
    return _then(_$ServiceMetadataImpl(
      sourceName: null == sourceName
          ? _value.sourceName
          : sourceName // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as ServiceAuthor,
      iconUrl: null == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      baseUrl: null == baseUrl
          ? _value.baseUrl
          : baseUrl // ignore: cast_nullable_to_non_nullable
              as String,
      streamType: null == streamType
          ? _value.streamType
          : streamType // ignore: cast_nullable_to_non_nullable
              as String,
      quality: null == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as String,
      searchBaseUrl: null == searchBaseUrl
          ? _value.searchBaseUrl
          : searchBaseUrl // ignore: cast_nullable_to_non_nullable
              as String,
      scriptUrl: null == scriptUrl
          ? _value.scriptUrl
          : scriptUrl // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      softsub: freezed == softsub
          ? _value.softsub
          : softsub // ignore: cast_nullable_to_non_nullable
              as bool?,
      multiStream: freezed == multiStream
          ? _value.multiStream
          : multiStream // ignore: cast_nullable_to_non_nullable
              as bool?,
      multiSubs: freezed == multiSubs
          ? _value.multiSubs
          : multiSubs // ignore: cast_nullable_to_non_nullable
              as bool?,
      novel: freezed == novel
          ? _value.novel
          : novel // ignore: cast_nullable_to_non_nullable
              as bool?,
      settings: freezed == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as bool?,
      asyncJS: freezed == asyncJS
          ? _value.asyncJS
          : asyncJS // ignore: cast_nullable_to_non_nullable
              as bool?,
      streamAsyncJS: freezed == streamAsyncJS
          ? _value.streamAsyncJS
          : streamAsyncJS // ignore: cast_nullable_to_non_nullable
              as bool?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      downloadSupport: freezed == downloadSupport
          ? _value.downloadSupport
          : downloadSupport // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceMetadataImpl implements _ServiceMetadata {
  const _$ServiceMetadataImpl(
      {required this.sourceName,
      required this.author,
      required this.iconUrl,
      required this.version,
      required this.language,
      required this.baseUrl,
      required this.streamType,
      required this.quality,
      required this.searchBaseUrl,
      required this.scriptUrl,
      this.type,
      this.softsub,
      this.multiStream,
      this.multiSubs,
      this.novel,
      this.settings,
      this.asyncJS,
      this.streamAsyncJS,
      this.note,
      this.downloadSupport});

  factory _$ServiceMetadataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceMetadataImplFromJson(json);

  @override
  final String sourceName;
  @override
  final ServiceAuthor author;
  @override
  final String iconUrl;
  @override
  final String version;
  @override
  final String language;
  @override
  final String baseUrl;
  @override
  final String streamType;
  @override
  final String quality;
  @override
  final String searchBaseUrl;
  @override
  final String scriptUrl;
  @override
  final String? type;
  @override
  final bool? softsub;
  @override
  final bool? multiStream;
  @override
  final bool? multiSubs;
  @override
  final bool? novel;
  @override
  final bool? settings;
  @override
  final bool? asyncJS;
  @override
  final bool? streamAsyncJS;
  @override
  final String? note;
  @override
  final bool? downloadSupport;

  @override
  String toString() {
    return 'ServiceMetadata(sourceName: $sourceName, author: $author, iconUrl: $iconUrl, version: $version, language: $language, baseUrl: $baseUrl, streamType: $streamType, quality: $quality, searchBaseUrl: $searchBaseUrl, scriptUrl: $scriptUrl, type: $type, softsub: $softsub, multiStream: $multiStream, multiSubs: $multiSubs, novel: $novel, settings: $settings, asyncJS: $asyncJS, streamAsyncJS: $streamAsyncJS, note: $note, downloadSupport: $downloadSupport)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceMetadataImpl &&
            (identical(other.sourceName, sourceName) ||
                other.sourceName == sourceName) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl) &&
            (identical(other.streamType, streamType) ||
                other.streamType == streamType) &&
            (identical(other.quality, quality) || other.quality == quality) &&
            (identical(other.searchBaseUrl, searchBaseUrl) ||
                other.searchBaseUrl == searchBaseUrl) &&
            (identical(other.scriptUrl, scriptUrl) ||
                other.scriptUrl == scriptUrl) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.softsub, softsub) || other.softsub == softsub) &&
            (identical(other.multiStream, multiStream) ||
                other.multiStream == multiStream) &&
            (identical(other.multiSubs, multiSubs) ||
                other.multiSubs == multiSubs) &&
            (identical(other.novel, novel) || other.novel == novel) &&
            (identical(other.settings, settings) ||
                other.settings == settings) &&
            (identical(other.asyncJS, asyncJS) || other.asyncJS == asyncJS) &&
            (identical(other.streamAsyncJS, streamAsyncJS) ||
                other.streamAsyncJS == streamAsyncJS) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.downloadSupport, downloadSupport) ||
                other.downloadSupport == downloadSupport));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        sourceName,
        author,
        iconUrl,
        version,
        language,
        baseUrl,
        streamType,
        quality,
        searchBaseUrl,
        scriptUrl,
        type,
        softsub,
        multiStream,
        multiSubs,
        novel,
        settings,
        asyncJS,
        streamAsyncJS,
        note,
        downloadSupport
      ]);

  /// Create a copy of ServiceMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceMetadataImplCopyWith<_$ServiceMetadataImpl> get copyWith =>
      __$$ServiceMetadataImplCopyWithImpl<_$ServiceMetadataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceMetadataImplToJson(
      this,
    );
  }
}

abstract class _ServiceMetadata implements ServiceMetadata {
  const factory _ServiceMetadata(
      {required final String sourceName,
      required final ServiceAuthor author,
      required final String iconUrl,
      required final String version,
      required final String language,
      required final String baseUrl,
      required final String streamType,
      required final String quality,
      required final String searchBaseUrl,
      required final String scriptUrl,
      final String? type,
      final bool? softsub,
      final bool? multiStream,
      final bool? multiSubs,
      final bool? novel,
      final bool? settings,
      final bool? asyncJS,
      final bool? streamAsyncJS,
      final String? note,
      final bool? downloadSupport}) = _$ServiceMetadataImpl;

  factory _ServiceMetadata.fromJson(Map<String, dynamic> json) =
      _$ServiceMetadataImpl.fromJson;

  @override
  String get sourceName;
  @override
  ServiceAuthor get author;
  @override
  String get iconUrl;
  @override
  String get version;
  @override
  String get language;
  @override
  String get baseUrl;
  @override
  String get streamType;
  @override
  String get quality;
  @override
  String get searchBaseUrl;
  @override
  String get scriptUrl;
  @override
  String? get type;
  @override
  bool? get softsub;
  @override
  bool? get multiStream;
  @override
  bool? get multiSubs;
  @override
  bool? get novel;
  @override
  bool? get settings;
  @override
  bool? get asyncJS;
  @override
  bool? get streamAsyncJS;
  @override
  String? get note;
  @override
  bool? get downloadSupport;

  /// Create a copy of ServiceMetadata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServiceMetadataImplCopyWith<_$ServiceMetadataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ServiceAuthor _$ServiceAuthorFromJson(Map<String, dynamic> json) {
  return _ServiceAuthor.fromJson(json);
}

/// @nodoc
mixin _$ServiceAuthor {
  String get name => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;

  /// Serializes this ServiceAuthor to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ServiceAuthor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServiceAuthorCopyWith<ServiceAuthor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceAuthorCopyWith<$Res> {
  factory $ServiceAuthorCopyWith(
          ServiceAuthor value, $Res Function(ServiceAuthor) then) =
      _$ServiceAuthorCopyWithImpl<$Res, ServiceAuthor>;
  @useResult
  $Res call({String name, String icon, String? url});
}

/// @nodoc
class _$ServiceAuthorCopyWithImpl<$Res, $Val extends ServiceAuthor>
    implements $ServiceAuthorCopyWith<$Res> {
  _$ServiceAuthorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServiceAuthor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? icon = null,
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServiceAuthorImplCopyWith<$Res>
    implements $ServiceAuthorCopyWith<$Res> {
  factory _$$ServiceAuthorImplCopyWith(
          _$ServiceAuthorImpl value, $Res Function(_$ServiceAuthorImpl) then) =
      __$$ServiceAuthorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String icon, String? url});
}

/// @nodoc
class __$$ServiceAuthorImplCopyWithImpl<$Res>
    extends _$ServiceAuthorCopyWithImpl<$Res, _$ServiceAuthorImpl>
    implements _$$ServiceAuthorImplCopyWith<$Res> {
  __$$ServiceAuthorImplCopyWithImpl(
      _$ServiceAuthorImpl _value, $Res Function(_$ServiceAuthorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ServiceAuthor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? icon = null,
    Object? url = freezed,
  }) {
    return _then(_$ServiceAuthorImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceAuthorImpl implements _ServiceAuthor {
  const _$ServiceAuthorImpl({required this.name, required this.icon, this.url});

  factory _$ServiceAuthorImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceAuthorImplFromJson(json);

  @override
  final String name;
  @override
  final String icon;
  @override
  final String? url;

  @override
  String toString() {
    return 'ServiceAuthor(name: $name, icon: $icon, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceAuthorImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, icon, url);

  /// Create a copy of ServiceAuthor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceAuthorImplCopyWith<_$ServiceAuthorImpl> get copyWith =>
      __$$ServiceAuthorImplCopyWithImpl<_$ServiceAuthorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceAuthorImplToJson(
      this,
    );
  }
}

abstract class _ServiceAuthor implements ServiceAuthor {
  const factory _ServiceAuthor(
      {required final String name,
      required final String icon,
      final String? url}) = _$ServiceAuthorImpl;

  factory _ServiceAuthor.fromJson(Map<String, dynamic> json) =
      _$ServiceAuthorImpl.fromJson;

  @override
  String get name;
  @override
  String get icon;
  @override
  String? get url;

  /// Create a copy of ServiceAuthor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServiceAuthorImplCopyWith<_$ServiceAuthorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
