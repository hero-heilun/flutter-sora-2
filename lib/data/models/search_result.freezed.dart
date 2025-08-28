// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SearchItem _$SearchItemFromJson(Map<String, dynamic> json) {
  return _SearchItem.fromJson(json);
}

/// @nodoc
mixin _$SearchItem {
  String get title => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  String get href => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;

  /// Serializes this SearchItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SearchItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SearchItemCopyWith<SearchItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchItemCopyWith<$Res> {
  factory $SearchItemCopyWith(
          SearchItem value, $Res Function(SearchItem) then) =
      _$SearchItemCopyWithImpl<$Res, SearchItem>;
  @useResult
  $Res call({String title, String imageUrl, String href, String? id});
}

/// @nodoc
class _$SearchItemCopyWithImpl<$Res, $Val extends SearchItem>
    implements $SearchItemCopyWith<$Res> {
  _$SearchItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? imageUrl = null,
    Object? href = null,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      href: null == href
          ? _value.href
          : href // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchItemImplCopyWith<$Res>
    implements $SearchItemCopyWith<$Res> {
  factory _$$SearchItemImplCopyWith(
          _$SearchItemImpl value, $Res Function(_$SearchItemImpl) then) =
      __$$SearchItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String imageUrl, String href, String? id});
}

/// @nodoc
class __$$SearchItemImplCopyWithImpl<$Res>
    extends _$SearchItemCopyWithImpl<$Res, _$SearchItemImpl>
    implements _$$SearchItemImplCopyWith<$Res> {
  __$$SearchItemImplCopyWithImpl(
      _$SearchItemImpl _value, $Res Function(_$SearchItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of SearchItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? imageUrl = null,
    Object? href = null,
    Object? id = freezed,
  }) {
    return _then(_$SearchItemImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      href: null == href
          ? _value.href
          : href // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SearchItemImpl implements _SearchItem {
  const _$SearchItemImpl(
      {required this.title,
      required this.imageUrl,
      required this.href,
      this.id});

  factory _$SearchItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$SearchItemImplFromJson(json);

  @override
  final String title;
  @override
  final String imageUrl;
  @override
  final String href;
  @override
  final String? id;

  @override
  String toString() {
    return 'SearchItem(title: $title, imageUrl: $imageUrl, href: $href, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchItemImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.href, href) || other.href == href) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, imageUrl, href, id);

  /// Create a copy of SearchItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchItemImplCopyWith<_$SearchItemImpl> get copyWith =>
      __$$SearchItemImplCopyWithImpl<_$SearchItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchItemImplToJson(
      this,
    );
  }
}

abstract class _SearchItem implements SearchItem {
  const factory _SearchItem(
      {required final String title,
      required final String imageUrl,
      required final String href,
      final String? id}) = _$SearchItemImpl;

  factory _SearchItem.fromJson(Map<String, dynamic> json) =
      _$SearchItemImpl.fromJson;

  @override
  String get title;
  @override
  String get imageUrl;
  @override
  String get href;
  @override
  String? get id;

  /// Create a copy of SearchItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchItemImplCopyWith<_$SearchItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MediaItem _$MediaItemFromJson(Map<String, dynamic> json) {
  return _MediaItem.fromJson(json);
}

/// @nodoc
mixin _$MediaItem {
  String get description => throw _privateConstructorUsedError;
  String get aliases => throw _privateConstructorUsedError;
  String get airdate => throw _privateConstructorUsedError;

  /// Serializes this MediaItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MediaItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MediaItemCopyWith<MediaItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediaItemCopyWith<$Res> {
  factory $MediaItemCopyWith(MediaItem value, $Res Function(MediaItem) then) =
      _$MediaItemCopyWithImpl<$Res, MediaItem>;
  @useResult
  $Res call({String description, String aliases, String airdate});
}

/// @nodoc
class _$MediaItemCopyWithImpl<$Res, $Val extends MediaItem>
    implements $MediaItemCopyWith<$Res> {
  _$MediaItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MediaItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? aliases = null,
    Object? airdate = null,
  }) {
    return _then(_value.copyWith(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      aliases: null == aliases
          ? _value.aliases
          : aliases // ignore: cast_nullable_to_non_nullable
              as String,
      airdate: null == airdate
          ? _value.airdate
          : airdate // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MediaItemImplCopyWith<$Res>
    implements $MediaItemCopyWith<$Res> {
  factory _$$MediaItemImplCopyWith(
          _$MediaItemImpl value, $Res Function(_$MediaItemImpl) then) =
      __$$MediaItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String description, String aliases, String airdate});
}

/// @nodoc
class __$$MediaItemImplCopyWithImpl<$Res>
    extends _$MediaItemCopyWithImpl<$Res, _$MediaItemImpl>
    implements _$$MediaItemImplCopyWith<$Res> {
  __$$MediaItemImplCopyWithImpl(
      _$MediaItemImpl _value, $Res Function(_$MediaItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of MediaItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? aliases = null,
    Object? airdate = null,
  }) {
    return _then(_$MediaItemImpl(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      aliases: null == aliases
          ? _value.aliases
          : aliases // ignore: cast_nullable_to_non_nullable
              as String,
      airdate: null == airdate
          ? _value.airdate
          : airdate // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MediaItemImpl implements _MediaItem {
  const _$MediaItemImpl(
      {required this.description,
      required this.aliases,
      required this.airdate});

  factory _$MediaItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$MediaItemImplFromJson(json);

  @override
  final String description;
  @override
  final String aliases;
  @override
  final String airdate;

  @override
  String toString() {
    return 'MediaItem(description: $description, aliases: $aliases, airdate: $airdate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MediaItemImpl &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.aliases, aliases) || other.aliases == aliases) &&
            (identical(other.airdate, airdate) || other.airdate == airdate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, description, aliases, airdate);

  /// Create a copy of MediaItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MediaItemImplCopyWith<_$MediaItemImpl> get copyWith =>
      __$$MediaItemImplCopyWithImpl<_$MediaItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MediaItemImplToJson(
      this,
    );
  }
}

abstract class _MediaItem implements MediaItem {
  const factory _MediaItem(
      {required final String description,
      required final String aliases,
      required final String airdate}) = _$MediaItemImpl;

  factory _MediaItem.fromJson(Map<String, dynamic> json) =
      _$MediaItemImpl.fromJson;

  @override
  String get description;
  @override
  String get aliases;
  @override
  String get airdate;

  /// Create a copy of MediaItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MediaItemImplCopyWith<_$MediaItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EpisodeLink _$EpisodeLinkFromJson(Map<String, dynamic> json) {
  return _EpisodeLink.fromJson(json);
}

/// @nodoc
mixin _$EpisodeLink {
  int get number => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get href => throw _privateConstructorUsedError;
  int? get duration => throw _privateConstructorUsedError;

  /// Serializes this EpisodeLink to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EpisodeLink
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EpisodeLinkCopyWith<EpisodeLink> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EpisodeLinkCopyWith<$Res> {
  factory $EpisodeLinkCopyWith(
          EpisodeLink value, $Res Function(EpisodeLink) then) =
      _$EpisodeLinkCopyWithImpl<$Res, EpisodeLink>;
  @useResult
  $Res call({int number, String title, String href, int? duration});
}

/// @nodoc
class _$EpisodeLinkCopyWithImpl<$Res, $Val extends EpisodeLink>
    implements $EpisodeLinkCopyWith<$Res> {
  _$EpisodeLinkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EpisodeLink
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? number = null,
    Object? title = null,
    Object? href = null,
    Object? duration = freezed,
  }) {
    return _then(_value.copyWith(
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      href: null == href
          ? _value.href
          : href // ignore: cast_nullable_to_non_nullable
              as String,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EpisodeLinkImplCopyWith<$Res>
    implements $EpisodeLinkCopyWith<$Res> {
  factory _$$EpisodeLinkImplCopyWith(
          _$EpisodeLinkImpl value, $Res Function(_$EpisodeLinkImpl) then) =
      __$$EpisodeLinkImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int number, String title, String href, int? duration});
}

/// @nodoc
class __$$EpisodeLinkImplCopyWithImpl<$Res>
    extends _$EpisodeLinkCopyWithImpl<$Res, _$EpisodeLinkImpl>
    implements _$$EpisodeLinkImplCopyWith<$Res> {
  __$$EpisodeLinkImplCopyWithImpl(
      _$EpisodeLinkImpl _value, $Res Function(_$EpisodeLinkImpl) _then)
      : super(_value, _then);

  /// Create a copy of EpisodeLink
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? number = null,
    Object? title = null,
    Object? href = null,
    Object? duration = freezed,
  }) {
    return _then(_$EpisodeLinkImpl(
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      href: null == href
          ? _value.href
          : href // ignore: cast_nullable_to_non_nullable
              as String,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EpisodeLinkImpl implements _EpisodeLink {
  const _$EpisodeLinkImpl(
      {required this.number,
      required this.title,
      required this.href,
      this.duration});

  factory _$EpisodeLinkImpl.fromJson(Map<String, dynamic> json) =>
      _$$EpisodeLinkImplFromJson(json);

  @override
  final int number;
  @override
  final String title;
  @override
  final String href;
  @override
  final int? duration;

  @override
  String toString() {
    return 'EpisodeLink(number: $number, title: $title, href: $href, duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EpisodeLinkImpl &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.href, href) || other.href == href) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, number, title, href, duration);

  /// Create a copy of EpisodeLink
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EpisodeLinkImplCopyWith<_$EpisodeLinkImpl> get copyWith =>
      __$$EpisodeLinkImplCopyWithImpl<_$EpisodeLinkImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EpisodeLinkImplToJson(
      this,
    );
  }
}

abstract class _EpisodeLink implements EpisodeLink {
  const factory _EpisodeLink(
      {required final int number,
      required final String title,
      required final String href,
      final int? duration}) = _$EpisodeLinkImpl;

  factory _EpisodeLink.fromJson(Map<String, dynamic> json) =
      _$EpisodeLinkImpl.fromJson;

  @override
  int get number;
  @override
  String get title;
  @override
  String get href;
  @override
  int? get duration;

  /// Create a copy of EpisodeLink
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EpisodeLinkImplCopyWith<_$EpisodeLinkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StreamData _$StreamDataFromJson(Map<String, dynamic> json) {
  return _StreamData.fromJson(json);
}

/// @nodoc
mixin _$StreamData {
  List<StreamSource> get streams => throw _privateConstructorUsedError;
  List<String> get subtitles => throw _privateConstructorUsedError;

  /// Serializes this StreamData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StreamData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StreamDataCopyWith<StreamData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StreamDataCopyWith<$Res> {
  factory $StreamDataCopyWith(
          StreamData value, $Res Function(StreamData) then) =
      _$StreamDataCopyWithImpl<$Res, StreamData>;
  @useResult
  $Res call({List<StreamSource> streams, List<String> subtitles});
}

/// @nodoc
class _$StreamDataCopyWithImpl<$Res, $Val extends StreamData>
    implements $StreamDataCopyWith<$Res> {
  _$StreamDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StreamData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? streams = null,
    Object? subtitles = null,
  }) {
    return _then(_value.copyWith(
      streams: null == streams
          ? _value.streams
          : streams // ignore: cast_nullable_to_non_nullable
              as List<StreamSource>,
      subtitles: null == subtitles
          ? _value.subtitles
          : subtitles // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StreamDataImplCopyWith<$Res>
    implements $StreamDataCopyWith<$Res> {
  factory _$$StreamDataImplCopyWith(
          _$StreamDataImpl value, $Res Function(_$StreamDataImpl) then) =
      __$$StreamDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<StreamSource> streams, List<String> subtitles});
}

/// @nodoc
class __$$StreamDataImplCopyWithImpl<$Res>
    extends _$StreamDataCopyWithImpl<$Res, _$StreamDataImpl>
    implements _$$StreamDataImplCopyWith<$Res> {
  __$$StreamDataImplCopyWithImpl(
      _$StreamDataImpl _value, $Res Function(_$StreamDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of StreamData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? streams = null,
    Object? subtitles = null,
  }) {
    return _then(_$StreamDataImpl(
      streams: null == streams
          ? _value._streams
          : streams // ignore: cast_nullable_to_non_nullable
              as List<StreamSource>,
      subtitles: null == subtitles
          ? _value._subtitles
          : subtitles // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StreamDataImpl implements _StreamData {
  const _$StreamDataImpl(
      {required final List<StreamSource> streams,
      final List<String> subtitles = const []})
      : _streams = streams,
        _subtitles = subtitles;

  factory _$StreamDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$StreamDataImplFromJson(json);

  final List<StreamSource> _streams;
  @override
  List<StreamSource> get streams {
    if (_streams is EqualUnmodifiableListView) return _streams;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_streams);
  }

  final List<String> _subtitles;
  @override
  @JsonKey()
  List<String> get subtitles {
    if (_subtitles is EqualUnmodifiableListView) return _subtitles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subtitles);
  }

  @override
  String toString() {
    return 'StreamData(streams: $streams, subtitles: $subtitles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StreamDataImpl &&
            const DeepCollectionEquality().equals(other._streams, _streams) &&
            const DeepCollectionEquality()
                .equals(other._subtitles, _subtitles));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_streams),
      const DeepCollectionEquality().hash(_subtitles));

  /// Create a copy of StreamData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StreamDataImplCopyWith<_$StreamDataImpl> get copyWith =>
      __$$StreamDataImplCopyWithImpl<_$StreamDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StreamDataImplToJson(
      this,
    );
  }
}

abstract class _StreamData implements StreamData {
  const factory _StreamData(
      {required final List<StreamSource> streams,
      final List<String> subtitles}) = _$StreamDataImpl;

  factory _StreamData.fromJson(Map<String, dynamic> json) =
      _$StreamDataImpl.fromJson;

  @override
  List<StreamSource> get streams;
  @override
  List<String> get subtitles;

  /// Create a copy of StreamData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StreamDataImplCopyWith<_$StreamDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StreamSource _$StreamSourceFromJson(Map<String, dynamic> json) {
  return _StreamSource.fromJson(json);
}

/// @nodoc
mixin _$StreamSource {
  String get url => throw _privateConstructorUsedError;
  Map<String, String>? get headers => throw _privateConstructorUsedError;

  /// Serializes this StreamSource to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StreamSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StreamSourceCopyWith<StreamSource> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StreamSourceCopyWith<$Res> {
  factory $StreamSourceCopyWith(
          StreamSource value, $Res Function(StreamSource) then) =
      _$StreamSourceCopyWithImpl<$Res, StreamSource>;
  @useResult
  $Res call({String url, Map<String, String>? headers});
}

/// @nodoc
class _$StreamSourceCopyWithImpl<$Res, $Val extends StreamSource>
    implements $StreamSourceCopyWith<$Res> {
  _$StreamSourceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StreamSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? headers = freezed,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      headers: freezed == headers
          ? _value.headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StreamSourceImplCopyWith<$Res>
    implements $StreamSourceCopyWith<$Res> {
  factory _$$StreamSourceImplCopyWith(
          _$StreamSourceImpl value, $Res Function(_$StreamSourceImpl) then) =
      __$$StreamSourceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url, Map<String, String>? headers});
}

/// @nodoc
class __$$StreamSourceImplCopyWithImpl<$Res>
    extends _$StreamSourceCopyWithImpl<$Res, _$StreamSourceImpl>
    implements _$$StreamSourceImplCopyWith<$Res> {
  __$$StreamSourceImplCopyWithImpl(
      _$StreamSourceImpl _value, $Res Function(_$StreamSourceImpl) _then)
      : super(_value, _then);

  /// Create a copy of StreamSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? headers = freezed,
  }) {
    return _then(_$StreamSourceImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      headers: freezed == headers
          ? _value._headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StreamSourceImpl implements _StreamSource {
  const _$StreamSourceImpl(
      {required this.url, final Map<String, String>? headers})
      : _headers = headers;

  factory _$StreamSourceImpl.fromJson(Map<String, dynamic> json) =>
      _$$StreamSourceImplFromJson(json);

  @override
  final String url;
  final Map<String, String>? _headers;
  @override
  Map<String, String>? get headers {
    final value = _headers;
    if (value == null) return null;
    if (_headers is EqualUnmodifiableMapView) return _headers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'StreamSource(url: $url, headers: $headers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StreamSourceImpl &&
            (identical(other.url, url) || other.url == url) &&
            const DeepCollectionEquality().equals(other._headers, _headers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, url, const DeepCollectionEquality().hash(_headers));

  /// Create a copy of StreamSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StreamSourceImplCopyWith<_$StreamSourceImpl> get copyWith =>
      __$$StreamSourceImplCopyWithImpl<_$StreamSourceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StreamSourceImplToJson(
      this,
    );
  }
}

abstract class _StreamSource implements StreamSource {
  const factory _StreamSource(
      {required final String url,
      final Map<String, String>? headers}) = _$StreamSourceImpl;

  factory _StreamSource.fromJson(Map<String, dynamic> json) =
      _$StreamSourceImpl.fromJson;

  @override
  String get url;
  @override
  Map<String, String>? get headers;

  /// Create a copy of StreamSource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StreamSourceImplCopyWith<_$StreamSourceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
