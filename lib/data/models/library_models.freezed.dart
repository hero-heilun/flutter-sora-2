// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'library_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FavoriteItem _$FavoriteItemFromJson(Map<String, dynamic> json) {
  return _FavoriteItem.fromJson(json);
}

/// @nodoc
mixin _$FavoriteItem {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError; // 'movie' or 'tv'
  String? get posterPath => throw _privateConstructorUsedError;
  String? get overview => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  DateTime get addedAt => throw _privateConstructorUsedError;
  Map<String, dynamic>? get tmdbData => throw _privateConstructorUsedError;

  /// Serializes this FavoriteItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FavoriteItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FavoriteItemCopyWith<FavoriteItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoriteItemCopyWith<$Res> {
  factory $FavoriteItemCopyWith(
          FavoriteItem value, $Res Function(FavoriteItem) then) =
      _$FavoriteItemCopyWithImpl<$Res, FavoriteItem>;
  @useResult
  $Res call(
      {String id,
      String title,
      String type,
      String? posterPath,
      String? overview,
      double rating,
      DateTime addedAt,
      Map<String, dynamic>? tmdbData});
}

/// @nodoc
class _$FavoriteItemCopyWithImpl<$Res, $Val extends FavoriteItem>
    implements $FavoriteItemCopyWith<$Res> {
  _$FavoriteItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FavoriteItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? type = null,
    Object? posterPath = freezed,
    Object? overview = freezed,
    Object? rating = null,
    Object? addedAt = null,
    Object? tmdbData = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      posterPath: freezed == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      addedAt: null == addedAt
          ? _value.addedAt
          : addedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      tmdbData: freezed == tmdbData
          ? _value.tmdbData
          : tmdbData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FavoriteItemImplCopyWith<$Res>
    implements $FavoriteItemCopyWith<$Res> {
  factory _$$FavoriteItemImplCopyWith(
          _$FavoriteItemImpl value, $Res Function(_$FavoriteItemImpl) then) =
      __$$FavoriteItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String type,
      String? posterPath,
      String? overview,
      double rating,
      DateTime addedAt,
      Map<String, dynamic>? tmdbData});
}

/// @nodoc
class __$$FavoriteItemImplCopyWithImpl<$Res>
    extends _$FavoriteItemCopyWithImpl<$Res, _$FavoriteItemImpl>
    implements _$$FavoriteItemImplCopyWith<$Res> {
  __$$FavoriteItemImplCopyWithImpl(
      _$FavoriteItemImpl _value, $Res Function(_$FavoriteItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of FavoriteItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? type = null,
    Object? posterPath = freezed,
    Object? overview = freezed,
    Object? rating = null,
    Object? addedAt = null,
    Object? tmdbData = freezed,
  }) {
    return _then(_$FavoriteItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      posterPath: freezed == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      addedAt: null == addedAt
          ? _value.addedAt
          : addedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      tmdbData: freezed == tmdbData
          ? _value._tmdbData
          : tmdbData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FavoriteItemImpl implements _FavoriteItem {
  const _$FavoriteItemImpl(
      {required this.id,
      required this.title,
      required this.type,
      this.posterPath,
      this.overview,
      this.rating = 0.0,
      required this.addedAt,
      final Map<String, dynamic>? tmdbData})
      : _tmdbData = tmdbData;

  factory _$FavoriteItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$FavoriteItemImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String type;
// 'movie' or 'tv'
  @override
  final String? posterPath;
  @override
  final String? overview;
  @override
  @JsonKey()
  final double rating;
  @override
  final DateTime addedAt;
  final Map<String, dynamic>? _tmdbData;
  @override
  Map<String, dynamic>? get tmdbData {
    final value = _tmdbData;
    if (value == null) return null;
    if (_tmdbData is EqualUnmodifiableMapView) return _tmdbData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'FavoriteItem(id: $id, title: $title, type: $type, posterPath: $posterPath, overview: $overview, rating: $rating, addedAt: $addedAt, tmdbData: $tmdbData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoriteItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.posterPath, posterPath) ||
                other.posterPath == posterPath) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.addedAt, addedAt) || other.addedAt == addedAt) &&
            const DeepCollectionEquality().equals(other._tmdbData, _tmdbData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      type,
      posterPath,
      overview,
      rating,
      addedAt,
      const DeepCollectionEquality().hash(_tmdbData));

  /// Create a copy of FavoriteItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FavoriteItemImplCopyWith<_$FavoriteItemImpl> get copyWith =>
      __$$FavoriteItemImplCopyWithImpl<_$FavoriteItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FavoriteItemImplToJson(
      this,
    );
  }
}

abstract class _FavoriteItem implements FavoriteItem {
  const factory _FavoriteItem(
      {required final String id,
      required final String title,
      required final String type,
      final String? posterPath,
      final String? overview,
      final double rating,
      required final DateTime addedAt,
      final Map<String, dynamic>? tmdbData}) = _$FavoriteItemImpl;

  factory _FavoriteItem.fromJson(Map<String, dynamic> json) =
      _$FavoriteItemImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get type; // 'movie' or 'tv'
  @override
  String? get posterPath;
  @override
  String? get overview;
  @override
  double get rating;
  @override
  DateTime get addedAt;
  @override
  Map<String, dynamic>? get tmdbData;

  /// Create a copy of FavoriteItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FavoriteItemImplCopyWith<_$FavoriteItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WatchHistoryItem _$WatchHistoryItemFromJson(Map<String, dynamic> json) {
  return _WatchHistoryItem.fromJson(json);
}

/// @nodoc
mixin _$WatchHistoryItem {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String? get posterPath => throw _privateConstructorUsedError;
  DateTime get lastWatched => throw _privateConstructorUsedError;
  int get progress => throw _privateConstructorUsedError; // Progress in seconds
  int get duration =>
      throw _privateConstructorUsedError; // Total duration in seconds
  String? get episodeTitle => throw _privateConstructorUsedError;
  int? get episodeNumber => throw _privateConstructorUsedError;
  int? get seasonNumber => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this WatchHistoryItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WatchHistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WatchHistoryItemCopyWith<WatchHistoryItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WatchHistoryItemCopyWith<$Res> {
  factory $WatchHistoryItemCopyWith(
          WatchHistoryItem value, $Res Function(WatchHistoryItem) then) =
      _$WatchHistoryItemCopyWithImpl<$Res, WatchHistoryItem>;
  @useResult
  $Res call(
      {String id,
      String title,
      String type,
      String? posterPath,
      DateTime lastWatched,
      int progress,
      int duration,
      String? episodeTitle,
      int? episodeNumber,
      int? seasonNumber,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$WatchHistoryItemCopyWithImpl<$Res, $Val extends WatchHistoryItem>
    implements $WatchHistoryItemCopyWith<$Res> {
  _$WatchHistoryItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WatchHistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? type = null,
    Object? posterPath = freezed,
    Object? lastWatched = null,
    Object? progress = null,
    Object? duration = null,
    Object? episodeTitle = freezed,
    Object? episodeNumber = freezed,
    Object? seasonNumber = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      posterPath: freezed == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      lastWatched: null == lastWatched
          ? _value.lastWatched
          : lastWatched // ignore: cast_nullable_to_non_nullable
              as DateTime,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      episodeTitle: freezed == episodeTitle
          ? _value.episodeTitle
          : episodeTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      episodeNumber: freezed == episodeNumber
          ? _value.episodeNumber
          : episodeNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      seasonNumber: freezed == seasonNumber
          ? _value.seasonNumber
          : seasonNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WatchHistoryItemImplCopyWith<$Res>
    implements $WatchHistoryItemCopyWith<$Res> {
  factory _$$WatchHistoryItemImplCopyWith(_$WatchHistoryItemImpl value,
          $Res Function(_$WatchHistoryItemImpl) then) =
      __$$WatchHistoryItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String type,
      String? posterPath,
      DateTime lastWatched,
      int progress,
      int duration,
      String? episodeTitle,
      int? episodeNumber,
      int? seasonNumber,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$WatchHistoryItemImplCopyWithImpl<$Res>
    extends _$WatchHistoryItemCopyWithImpl<$Res, _$WatchHistoryItemImpl>
    implements _$$WatchHistoryItemImplCopyWith<$Res> {
  __$$WatchHistoryItemImplCopyWithImpl(_$WatchHistoryItemImpl _value,
      $Res Function(_$WatchHistoryItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of WatchHistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? type = null,
    Object? posterPath = freezed,
    Object? lastWatched = null,
    Object? progress = null,
    Object? duration = null,
    Object? episodeTitle = freezed,
    Object? episodeNumber = freezed,
    Object? seasonNumber = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$WatchHistoryItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      posterPath: freezed == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      lastWatched: null == lastWatched
          ? _value.lastWatched
          : lastWatched // ignore: cast_nullable_to_non_nullable
              as DateTime,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      episodeTitle: freezed == episodeTitle
          ? _value.episodeTitle
          : episodeTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      episodeNumber: freezed == episodeNumber
          ? _value.episodeNumber
          : episodeNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      seasonNumber: freezed == seasonNumber
          ? _value.seasonNumber
          : seasonNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WatchHistoryItemImpl implements _WatchHistoryItem {
  const _$WatchHistoryItemImpl(
      {required this.id,
      required this.title,
      required this.type,
      this.posterPath,
      required this.lastWatched,
      this.progress = 0,
      this.duration = 0,
      this.episodeTitle,
      this.episodeNumber,
      this.seasonNumber,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$WatchHistoryItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$WatchHistoryItemImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String type;
  @override
  final String? posterPath;
  @override
  final DateTime lastWatched;
  @override
  @JsonKey()
  final int progress;
// Progress in seconds
  @override
  @JsonKey()
  final int duration;
// Total duration in seconds
  @override
  final String? episodeTitle;
  @override
  final int? episodeNumber;
  @override
  final int? seasonNumber;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'WatchHistoryItem(id: $id, title: $title, type: $type, posterPath: $posterPath, lastWatched: $lastWatched, progress: $progress, duration: $duration, episodeTitle: $episodeTitle, episodeNumber: $episodeNumber, seasonNumber: $seasonNumber, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WatchHistoryItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.posterPath, posterPath) ||
                other.posterPath == posterPath) &&
            (identical(other.lastWatched, lastWatched) ||
                other.lastWatched == lastWatched) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.episodeTitle, episodeTitle) ||
                other.episodeTitle == episodeTitle) &&
            (identical(other.episodeNumber, episodeNumber) ||
                other.episodeNumber == episodeNumber) &&
            (identical(other.seasonNumber, seasonNumber) ||
                other.seasonNumber == seasonNumber) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      type,
      posterPath,
      lastWatched,
      progress,
      duration,
      episodeTitle,
      episodeNumber,
      seasonNumber,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of WatchHistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WatchHistoryItemImplCopyWith<_$WatchHistoryItemImpl> get copyWith =>
      __$$WatchHistoryItemImplCopyWithImpl<_$WatchHistoryItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WatchHistoryItemImplToJson(
      this,
    );
  }
}

abstract class _WatchHistoryItem implements WatchHistoryItem {
  const factory _WatchHistoryItem(
      {required final String id,
      required final String title,
      required final String type,
      final String? posterPath,
      required final DateTime lastWatched,
      final int progress,
      final int duration,
      final String? episodeTitle,
      final int? episodeNumber,
      final int? seasonNumber,
      final Map<String, dynamic>? metadata}) = _$WatchHistoryItemImpl;

  factory _WatchHistoryItem.fromJson(Map<String, dynamic> json) =
      _$WatchHistoryItemImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get type;
  @override
  String? get posterPath;
  @override
  DateTime get lastWatched;
  @override
  int get progress; // Progress in seconds
  @override
  int get duration; // Total duration in seconds
  @override
  String? get episodeTitle;
  @override
  int? get episodeNumber;
  @override
  int? get seasonNumber;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of WatchHistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WatchHistoryItemImplCopyWith<_$WatchHistoryItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Bookmark _$BookmarkFromJson(Map<String, dynamic> json) {
  return _Bookmark.fromJson(json);
}

/// @nodoc
mixin _$Bookmark {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;

  /// Serializes this Bookmark to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Bookmark
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookmarkCopyWith<Bookmark> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookmarkCopyWith<$Res> {
  factory $BookmarkCopyWith(Bookmark value, $Res Function(Bookmark) then) =
      _$BookmarkCopyWithImpl<$Res, Bookmark>;
  @useResult
  $Res call(
      {String id,
      String title,
      String url,
      String? description,
      String? imageUrl,
      DateTime createdAt,
      List<String> tags});
}

/// @nodoc
class _$BookmarkCopyWithImpl<$Res, $Val extends Bookmark>
    implements $BookmarkCopyWith<$Res> {
  _$BookmarkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Bookmark
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? url = null,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? createdAt = null,
    Object? tags = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookmarkImplCopyWith<$Res>
    implements $BookmarkCopyWith<$Res> {
  factory _$$BookmarkImplCopyWith(
          _$BookmarkImpl value, $Res Function(_$BookmarkImpl) then) =
      __$$BookmarkImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String url,
      String? description,
      String? imageUrl,
      DateTime createdAt,
      List<String> tags});
}

/// @nodoc
class __$$BookmarkImplCopyWithImpl<$Res>
    extends _$BookmarkCopyWithImpl<$Res, _$BookmarkImpl>
    implements _$$BookmarkImplCopyWith<$Res> {
  __$$BookmarkImplCopyWithImpl(
      _$BookmarkImpl _value, $Res Function(_$BookmarkImpl) _then)
      : super(_value, _then);

  /// Create a copy of Bookmark
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? url = null,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? createdAt = null,
    Object? tags = null,
  }) {
    return _then(_$BookmarkImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookmarkImpl implements _Bookmark {
  const _$BookmarkImpl(
      {required this.id,
      required this.title,
      required this.url,
      this.description,
      this.imageUrl,
      required this.createdAt,
      final List<String> tags = const []})
      : _tags = tags;

  factory _$BookmarkImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookmarkImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String url;
  @override
  final String? description;
  @override
  final String? imageUrl;
  @override
  final DateTime createdAt;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  String toString() {
    return 'Bookmark(id: $id, title: $title, url: $url, description: $description, imageUrl: $imageUrl, createdAt: $createdAt, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookmarkImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, url, description,
      imageUrl, createdAt, const DeepCollectionEquality().hash(_tags));

  /// Create a copy of Bookmark
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookmarkImplCopyWith<_$BookmarkImpl> get copyWith =>
      __$$BookmarkImplCopyWithImpl<_$BookmarkImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookmarkImplToJson(
      this,
    );
  }
}

abstract class _Bookmark implements Bookmark {
  const factory _Bookmark(
      {required final String id,
      required final String title,
      required final String url,
      final String? description,
      final String? imageUrl,
      required final DateTime createdAt,
      final List<String> tags}) = _$BookmarkImpl;

  factory _Bookmark.fromJson(Map<String, dynamic> json) =
      _$BookmarkImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get url;
  @override
  String? get description;
  @override
  String? get imageUrl;
  @override
  DateTime get createdAt;
  @override
  List<String> get tags;

  /// Create a copy of Bookmark
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookmarkImplCopyWith<_$BookmarkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
