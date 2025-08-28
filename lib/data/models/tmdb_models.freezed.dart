// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tmdb_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TMDBMovie _$TMDBMovieFromJson(Map<String, dynamic> json) {
  return _TMDBMovie.fromJson(json);
}

/// @nodoc
mixin _$TMDBMovie {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'original_title')
  String? get originalTitle => throw _privateConstructorUsedError;
  String? get overview => throw _privateConstructorUsedError;
  @JsonKey(name: 'poster_path')
  String? get posterPath => throw _privateConstructorUsedError;
  @JsonKey(name: 'backdrop_path')
  String? get backdropPath => throw _privateConstructorUsedError;
  @JsonKey(name: 'release_date')
  String? get releaseDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'vote_average')
  double get voteAverage => throw _privateConstructorUsedError;
  @JsonKey(name: 'vote_count')
  int get voteCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'genre_ids')
  List<int> get genreIds => throw _privateConstructorUsedError;
  bool get adult => throw _privateConstructorUsedError;
  double get popularity => throw _privateConstructorUsedError;

  /// Serializes this TMDBMovie to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TMDBMovie
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TMDBMovieCopyWith<TMDBMovie> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TMDBMovieCopyWith<$Res> {
  factory $TMDBMovieCopyWith(TMDBMovie value, $Res Function(TMDBMovie) then) =
      _$TMDBMovieCopyWithImpl<$Res, TMDBMovie>;
  @useResult
  $Res call(
      {int id,
      String title,
      @JsonKey(name: 'original_title') String? originalTitle,
      String? overview,
      @JsonKey(name: 'poster_path') String? posterPath,
      @JsonKey(name: 'backdrop_path') String? backdropPath,
      @JsonKey(name: 'release_date') String? releaseDate,
      @JsonKey(name: 'vote_average') double voteAverage,
      @JsonKey(name: 'vote_count') int voteCount,
      @JsonKey(name: 'genre_ids') List<int> genreIds,
      bool adult,
      double popularity});
}

/// @nodoc
class _$TMDBMovieCopyWithImpl<$Res, $Val extends TMDBMovie>
    implements $TMDBMovieCopyWith<$Res> {
  _$TMDBMovieCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TMDBMovie
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? originalTitle = freezed,
    Object? overview = freezed,
    Object? posterPath = freezed,
    Object? backdropPath = freezed,
    Object? releaseDate = freezed,
    Object? voteAverage = null,
    Object? voteCount = null,
    Object? genreIds = null,
    Object? adult = null,
    Object? popularity = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      originalTitle: freezed == originalTitle
          ? _value.originalTitle
          : originalTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      posterPath: freezed == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      backdropPath: freezed == backdropPath
          ? _value.backdropPath
          : backdropPath // ignore: cast_nullable_to_non_nullable
              as String?,
      releaseDate: freezed == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as String?,
      voteAverage: null == voteAverage
          ? _value.voteAverage
          : voteAverage // ignore: cast_nullable_to_non_nullable
              as double,
      voteCount: null == voteCount
          ? _value.voteCount
          : voteCount // ignore: cast_nullable_to_non_nullable
              as int,
      genreIds: null == genreIds
          ? _value.genreIds
          : genreIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
      adult: null == adult
          ? _value.adult
          : adult // ignore: cast_nullable_to_non_nullable
              as bool,
      popularity: null == popularity
          ? _value.popularity
          : popularity // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TMDBMovieImplCopyWith<$Res>
    implements $TMDBMovieCopyWith<$Res> {
  factory _$$TMDBMovieImplCopyWith(
          _$TMDBMovieImpl value, $Res Function(_$TMDBMovieImpl) then) =
      __$$TMDBMovieImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      @JsonKey(name: 'original_title') String? originalTitle,
      String? overview,
      @JsonKey(name: 'poster_path') String? posterPath,
      @JsonKey(name: 'backdrop_path') String? backdropPath,
      @JsonKey(name: 'release_date') String? releaseDate,
      @JsonKey(name: 'vote_average') double voteAverage,
      @JsonKey(name: 'vote_count') int voteCount,
      @JsonKey(name: 'genre_ids') List<int> genreIds,
      bool adult,
      double popularity});
}

/// @nodoc
class __$$TMDBMovieImplCopyWithImpl<$Res>
    extends _$TMDBMovieCopyWithImpl<$Res, _$TMDBMovieImpl>
    implements _$$TMDBMovieImplCopyWith<$Res> {
  __$$TMDBMovieImplCopyWithImpl(
      _$TMDBMovieImpl _value, $Res Function(_$TMDBMovieImpl) _then)
      : super(_value, _then);

  /// Create a copy of TMDBMovie
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? originalTitle = freezed,
    Object? overview = freezed,
    Object? posterPath = freezed,
    Object? backdropPath = freezed,
    Object? releaseDate = freezed,
    Object? voteAverage = null,
    Object? voteCount = null,
    Object? genreIds = null,
    Object? adult = null,
    Object? popularity = null,
  }) {
    return _then(_$TMDBMovieImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      originalTitle: freezed == originalTitle
          ? _value.originalTitle
          : originalTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      posterPath: freezed == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      backdropPath: freezed == backdropPath
          ? _value.backdropPath
          : backdropPath // ignore: cast_nullable_to_non_nullable
              as String?,
      releaseDate: freezed == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as String?,
      voteAverage: null == voteAverage
          ? _value.voteAverage
          : voteAverage // ignore: cast_nullable_to_non_nullable
              as double,
      voteCount: null == voteCount
          ? _value.voteCount
          : voteCount // ignore: cast_nullable_to_non_nullable
              as int,
      genreIds: null == genreIds
          ? _value._genreIds
          : genreIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
      adult: null == adult
          ? _value.adult
          : adult // ignore: cast_nullable_to_non_nullable
              as bool,
      popularity: null == popularity
          ? _value.popularity
          : popularity // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TMDBMovieImpl implements _TMDBMovie {
  const _$TMDBMovieImpl(
      {required this.id,
      required this.title,
      @JsonKey(name: 'original_title') this.originalTitle,
      this.overview,
      @JsonKey(name: 'poster_path') this.posterPath,
      @JsonKey(name: 'backdrop_path') this.backdropPath,
      @JsonKey(name: 'release_date') this.releaseDate,
      @JsonKey(name: 'vote_average') this.voteAverage = 0.0,
      @JsonKey(name: 'vote_count') this.voteCount = 0,
      @JsonKey(name: 'genre_ids') final List<int> genreIds = const [],
      this.adult = false,
      this.popularity = 0.0})
      : _genreIds = genreIds;

  factory _$TMDBMovieImpl.fromJson(Map<String, dynamic> json) =>
      _$$TMDBMovieImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  @JsonKey(name: 'original_title')
  final String? originalTitle;
  @override
  final String? overview;
  @override
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @override
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @override
  @JsonKey(name: 'release_date')
  final String? releaseDate;
  @override
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @override
  @JsonKey(name: 'vote_count')
  final int voteCount;
  final List<int> _genreIds;
  @override
  @JsonKey(name: 'genre_ids')
  List<int> get genreIds {
    if (_genreIds is EqualUnmodifiableListView) return _genreIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_genreIds);
  }

  @override
  @JsonKey()
  final bool adult;
  @override
  @JsonKey()
  final double popularity;

  @override
  String toString() {
    return 'TMDBMovie(id: $id, title: $title, originalTitle: $originalTitle, overview: $overview, posterPath: $posterPath, backdropPath: $backdropPath, releaseDate: $releaseDate, voteAverage: $voteAverage, voteCount: $voteCount, genreIds: $genreIds, adult: $adult, popularity: $popularity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TMDBMovieImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.originalTitle, originalTitle) ||
                other.originalTitle == originalTitle) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            (identical(other.posterPath, posterPath) ||
                other.posterPath == posterPath) &&
            (identical(other.backdropPath, backdropPath) ||
                other.backdropPath == backdropPath) &&
            (identical(other.releaseDate, releaseDate) ||
                other.releaseDate == releaseDate) &&
            (identical(other.voteAverage, voteAverage) ||
                other.voteAverage == voteAverage) &&
            (identical(other.voteCount, voteCount) ||
                other.voteCount == voteCount) &&
            const DeepCollectionEquality().equals(other._genreIds, _genreIds) &&
            (identical(other.adult, adult) || other.adult == adult) &&
            (identical(other.popularity, popularity) ||
                other.popularity == popularity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      originalTitle,
      overview,
      posterPath,
      backdropPath,
      releaseDate,
      voteAverage,
      voteCount,
      const DeepCollectionEquality().hash(_genreIds),
      adult,
      popularity);

  /// Create a copy of TMDBMovie
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TMDBMovieImplCopyWith<_$TMDBMovieImpl> get copyWith =>
      __$$TMDBMovieImplCopyWithImpl<_$TMDBMovieImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TMDBMovieImplToJson(
      this,
    );
  }
}

abstract class _TMDBMovie implements TMDBMovie {
  const factory _TMDBMovie(
      {required final int id,
      required final String title,
      @JsonKey(name: 'original_title') final String? originalTitle,
      final String? overview,
      @JsonKey(name: 'poster_path') final String? posterPath,
      @JsonKey(name: 'backdrop_path') final String? backdropPath,
      @JsonKey(name: 'release_date') final String? releaseDate,
      @JsonKey(name: 'vote_average') final double voteAverage,
      @JsonKey(name: 'vote_count') final int voteCount,
      @JsonKey(name: 'genre_ids') final List<int> genreIds,
      final bool adult,
      final double popularity}) = _$TMDBMovieImpl;

  factory _TMDBMovie.fromJson(Map<String, dynamic> json) =
      _$TMDBMovieImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  @JsonKey(name: 'original_title')
  String? get originalTitle;
  @override
  String? get overview;
  @override
  @JsonKey(name: 'poster_path')
  String? get posterPath;
  @override
  @JsonKey(name: 'backdrop_path')
  String? get backdropPath;
  @override
  @JsonKey(name: 'release_date')
  String? get releaseDate;
  @override
  @JsonKey(name: 'vote_average')
  double get voteAverage;
  @override
  @JsonKey(name: 'vote_count')
  int get voteCount;
  @override
  @JsonKey(name: 'genre_ids')
  List<int> get genreIds;
  @override
  bool get adult;
  @override
  double get popularity;

  /// Create a copy of TMDBMovie
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TMDBMovieImplCopyWith<_$TMDBMovieImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TMDBTVShow _$TMDBTVShowFromJson(Map<String, dynamic> json) {
  return _TMDBTVShow.fromJson(json);
}

/// @nodoc
mixin _$TMDBTVShow {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'original_name')
  String? get originalName => throw _privateConstructorUsedError;
  String? get overview => throw _privateConstructorUsedError;
  @JsonKey(name: 'poster_path')
  String? get posterPath => throw _privateConstructorUsedError;
  @JsonKey(name: 'backdrop_path')
  String? get backdropPath => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_air_date')
  String? get firstAirDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'vote_average')
  double get voteAverage => throw _privateConstructorUsedError;
  @JsonKey(name: 'vote_count')
  int get voteCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'genre_ids')
  List<int> get genreIds => throw _privateConstructorUsedError;
  @JsonKey(name: 'origin_country')
  List<String> get originCountry => throw _privateConstructorUsedError;

  /// Serializes this TMDBTVShow to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TMDBTVShow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TMDBTVShowCopyWith<TMDBTVShow> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TMDBTVShowCopyWith<$Res> {
  factory $TMDBTVShowCopyWith(
          TMDBTVShow value, $Res Function(TMDBTVShow) then) =
      _$TMDBTVShowCopyWithImpl<$Res, TMDBTVShow>;
  @useResult
  $Res call(
      {int id,
      String name,
      @JsonKey(name: 'original_name') String? originalName,
      String? overview,
      @JsonKey(name: 'poster_path') String? posterPath,
      @JsonKey(name: 'backdrop_path') String? backdropPath,
      @JsonKey(name: 'first_air_date') String? firstAirDate,
      @JsonKey(name: 'vote_average') double voteAverage,
      @JsonKey(name: 'vote_count') int voteCount,
      @JsonKey(name: 'genre_ids') List<int> genreIds,
      @JsonKey(name: 'origin_country') List<String> originCountry});
}

/// @nodoc
class _$TMDBTVShowCopyWithImpl<$Res, $Val extends TMDBTVShow>
    implements $TMDBTVShowCopyWith<$Res> {
  _$TMDBTVShowCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TMDBTVShow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? originalName = freezed,
    Object? overview = freezed,
    Object? posterPath = freezed,
    Object? backdropPath = freezed,
    Object? firstAirDate = freezed,
    Object? voteAverage = null,
    Object? voteCount = null,
    Object? genreIds = null,
    Object? originCountry = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      originalName: freezed == originalName
          ? _value.originalName
          : originalName // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      posterPath: freezed == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      backdropPath: freezed == backdropPath
          ? _value.backdropPath
          : backdropPath // ignore: cast_nullable_to_non_nullable
              as String?,
      firstAirDate: freezed == firstAirDate
          ? _value.firstAirDate
          : firstAirDate // ignore: cast_nullable_to_non_nullable
              as String?,
      voteAverage: null == voteAverage
          ? _value.voteAverage
          : voteAverage // ignore: cast_nullable_to_non_nullable
              as double,
      voteCount: null == voteCount
          ? _value.voteCount
          : voteCount // ignore: cast_nullable_to_non_nullable
              as int,
      genreIds: null == genreIds
          ? _value.genreIds
          : genreIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
      originCountry: null == originCountry
          ? _value.originCountry
          : originCountry // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TMDBTVShowImplCopyWith<$Res>
    implements $TMDBTVShowCopyWith<$Res> {
  factory _$$TMDBTVShowImplCopyWith(
          _$TMDBTVShowImpl value, $Res Function(_$TMDBTVShowImpl) then) =
      __$$TMDBTVShowImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      @JsonKey(name: 'original_name') String? originalName,
      String? overview,
      @JsonKey(name: 'poster_path') String? posterPath,
      @JsonKey(name: 'backdrop_path') String? backdropPath,
      @JsonKey(name: 'first_air_date') String? firstAirDate,
      @JsonKey(name: 'vote_average') double voteAverage,
      @JsonKey(name: 'vote_count') int voteCount,
      @JsonKey(name: 'genre_ids') List<int> genreIds,
      @JsonKey(name: 'origin_country') List<String> originCountry});
}

/// @nodoc
class __$$TMDBTVShowImplCopyWithImpl<$Res>
    extends _$TMDBTVShowCopyWithImpl<$Res, _$TMDBTVShowImpl>
    implements _$$TMDBTVShowImplCopyWith<$Res> {
  __$$TMDBTVShowImplCopyWithImpl(
      _$TMDBTVShowImpl _value, $Res Function(_$TMDBTVShowImpl) _then)
      : super(_value, _then);

  /// Create a copy of TMDBTVShow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? originalName = freezed,
    Object? overview = freezed,
    Object? posterPath = freezed,
    Object? backdropPath = freezed,
    Object? firstAirDate = freezed,
    Object? voteAverage = null,
    Object? voteCount = null,
    Object? genreIds = null,
    Object? originCountry = null,
  }) {
    return _then(_$TMDBTVShowImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      originalName: freezed == originalName
          ? _value.originalName
          : originalName // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      posterPath: freezed == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      backdropPath: freezed == backdropPath
          ? _value.backdropPath
          : backdropPath // ignore: cast_nullable_to_non_nullable
              as String?,
      firstAirDate: freezed == firstAirDate
          ? _value.firstAirDate
          : firstAirDate // ignore: cast_nullable_to_non_nullable
              as String?,
      voteAverage: null == voteAverage
          ? _value.voteAverage
          : voteAverage // ignore: cast_nullable_to_non_nullable
              as double,
      voteCount: null == voteCount
          ? _value.voteCount
          : voteCount // ignore: cast_nullable_to_non_nullable
              as int,
      genreIds: null == genreIds
          ? _value._genreIds
          : genreIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
      originCountry: null == originCountry
          ? _value._originCountry
          : originCountry // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TMDBTVShowImpl implements _TMDBTVShow {
  const _$TMDBTVShowImpl(
      {required this.id,
      required this.name,
      @JsonKey(name: 'original_name') this.originalName,
      this.overview,
      @JsonKey(name: 'poster_path') this.posterPath,
      @JsonKey(name: 'backdrop_path') this.backdropPath,
      @JsonKey(name: 'first_air_date') this.firstAirDate,
      @JsonKey(name: 'vote_average') this.voteAverage = 0.0,
      @JsonKey(name: 'vote_count') this.voteCount = 0,
      @JsonKey(name: 'genre_ids') final List<int> genreIds = const [],
      @JsonKey(name: 'origin_country')
      final List<String> originCountry = const []})
      : _genreIds = genreIds,
        _originCountry = originCountry;

  factory _$TMDBTVShowImpl.fromJson(Map<String, dynamic> json) =>
      _$$TMDBTVShowImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  @JsonKey(name: 'original_name')
  final String? originalName;
  @override
  final String? overview;
  @override
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @override
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @override
  @JsonKey(name: 'first_air_date')
  final String? firstAirDate;
  @override
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @override
  @JsonKey(name: 'vote_count')
  final int voteCount;
  final List<int> _genreIds;
  @override
  @JsonKey(name: 'genre_ids')
  List<int> get genreIds {
    if (_genreIds is EqualUnmodifiableListView) return _genreIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_genreIds);
  }

  final List<String> _originCountry;
  @override
  @JsonKey(name: 'origin_country')
  List<String> get originCountry {
    if (_originCountry is EqualUnmodifiableListView) return _originCountry;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_originCountry);
  }

  @override
  String toString() {
    return 'TMDBTVShow(id: $id, name: $name, originalName: $originalName, overview: $overview, posterPath: $posterPath, backdropPath: $backdropPath, firstAirDate: $firstAirDate, voteAverage: $voteAverage, voteCount: $voteCount, genreIds: $genreIds, originCountry: $originCountry)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TMDBTVShowImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.originalName, originalName) ||
                other.originalName == originalName) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            (identical(other.posterPath, posterPath) ||
                other.posterPath == posterPath) &&
            (identical(other.backdropPath, backdropPath) ||
                other.backdropPath == backdropPath) &&
            (identical(other.firstAirDate, firstAirDate) ||
                other.firstAirDate == firstAirDate) &&
            (identical(other.voteAverage, voteAverage) ||
                other.voteAverage == voteAverage) &&
            (identical(other.voteCount, voteCount) ||
                other.voteCount == voteCount) &&
            const DeepCollectionEquality().equals(other._genreIds, _genreIds) &&
            const DeepCollectionEquality()
                .equals(other._originCountry, _originCountry));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      originalName,
      overview,
      posterPath,
      backdropPath,
      firstAirDate,
      voteAverage,
      voteCount,
      const DeepCollectionEquality().hash(_genreIds),
      const DeepCollectionEquality().hash(_originCountry));

  /// Create a copy of TMDBTVShow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TMDBTVShowImplCopyWith<_$TMDBTVShowImpl> get copyWith =>
      __$$TMDBTVShowImplCopyWithImpl<_$TMDBTVShowImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TMDBTVShowImplToJson(
      this,
    );
  }
}

abstract class _TMDBTVShow implements TMDBTVShow {
  const factory _TMDBTVShow(
          {required final int id,
          required final String name,
          @JsonKey(name: 'original_name') final String? originalName,
          final String? overview,
          @JsonKey(name: 'poster_path') final String? posterPath,
          @JsonKey(name: 'backdrop_path') final String? backdropPath,
          @JsonKey(name: 'first_air_date') final String? firstAirDate,
          @JsonKey(name: 'vote_average') final double voteAverage,
          @JsonKey(name: 'vote_count') final int voteCount,
          @JsonKey(name: 'genre_ids') final List<int> genreIds,
          @JsonKey(name: 'origin_country') final List<String> originCountry}) =
      _$TMDBTVShowImpl;

  factory _TMDBTVShow.fromJson(Map<String, dynamic> json) =
      _$TMDBTVShowImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'original_name')
  String? get originalName;
  @override
  String? get overview;
  @override
  @JsonKey(name: 'poster_path')
  String? get posterPath;
  @override
  @JsonKey(name: 'backdrop_path')
  String? get backdropPath;
  @override
  @JsonKey(name: 'first_air_date')
  String? get firstAirDate;
  @override
  @JsonKey(name: 'vote_average')
  double get voteAverage;
  @override
  @JsonKey(name: 'vote_count')
  int get voteCount;
  @override
  @JsonKey(name: 'genre_ids')
  List<int> get genreIds;
  @override
  @JsonKey(name: 'origin_country')
  List<String> get originCountry;

  /// Create a copy of TMDBTVShow
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TMDBTVShowImplCopyWith<_$TMDBTVShowImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TMDBPerson _$TMDBPersonFromJson(Map<String, dynamic> json) {
  return _TMDBPerson.fromJson(json);
}

/// @nodoc
mixin _$TMDBPerson {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get profilePath => throw _privateConstructorUsedError;
  bool get adult => throw _privateConstructorUsedError;
  String? get knownForDepartment => throw _privateConstructorUsedError;
  List<Map<String, dynamic>> get knownFor => throw _privateConstructorUsedError;

  /// Serializes this TMDBPerson to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TMDBPerson
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TMDBPersonCopyWith<TMDBPerson> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TMDBPersonCopyWith<$Res> {
  factory $TMDBPersonCopyWith(
          TMDBPerson value, $Res Function(TMDBPerson) then) =
      _$TMDBPersonCopyWithImpl<$Res, TMDBPerson>;
  @useResult
  $Res call(
      {int id,
      String name,
      String? profilePath,
      bool adult,
      String? knownForDepartment,
      List<Map<String, dynamic>> knownFor});
}

/// @nodoc
class _$TMDBPersonCopyWithImpl<$Res, $Val extends TMDBPerson>
    implements $TMDBPersonCopyWith<$Res> {
  _$TMDBPersonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TMDBPerson
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? profilePath = freezed,
    Object? adult = null,
    Object? knownForDepartment = freezed,
    Object? knownFor = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      profilePath: freezed == profilePath
          ? _value.profilePath
          : profilePath // ignore: cast_nullable_to_non_nullable
              as String?,
      adult: null == adult
          ? _value.adult
          : adult // ignore: cast_nullable_to_non_nullable
              as bool,
      knownForDepartment: freezed == knownForDepartment
          ? _value.knownForDepartment
          : knownForDepartment // ignore: cast_nullable_to_non_nullable
              as String?,
      knownFor: null == knownFor
          ? _value.knownFor
          : knownFor // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TMDBPersonImplCopyWith<$Res>
    implements $TMDBPersonCopyWith<$Res> {
  factory _$$TMDBPersonImplCopyWith(
          _$TMDBPersonImpl value, $Res Function(_$TMDBPersonImpl) then) =
      __$$TMDBPersonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String? profilePath,
      bool adult,
      String? knownForDepartment,
      List<Map<String, dynamic>> knownFor});
}

/// @nodoc
class __$$TMDBPersonImplCopyWithImpl<$Res>
    extends _$TMDBPersonCopyWithImpl<$Res, _$TMDBPersonImpl>
    implements _$$TMDBPersonImplCopyWith<$Res> {
  __$$TMDBPersonImplCopyWithImpl(
      _$TMDBPersonImpl _value, $Res Function(_$TMDBPersonImpl) _then)
      : super(_value, _then);

  /// Create a copy of TMDBPerson
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? profilePath = freezed,
    Object? adult = null,
    Object? knownForDepartment = freezed,
    Object? knownFor = null,
  }) {
    return _then(_$TMDBPersonImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      profilePath: freezed == profilePath
          ? _value.profilePath
          : profilePath // ignore: cast_nullable_to_non_nullable
              as String?,
      adult: null == adult
          ? _value.adult
          : adult // ignore: cast_nullable_to_non_nullable
              as bool,
      knownForDepartment: freezed == knownForDepartment
          ? _value.knownForDepartment
          : knownForDepartment // ignore: cast_nullable_to_non_nullable
              as String?,
      knownFor: null == knownFor
          ? _value._knownFor
          : knownFor // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TMDBPersonImpl implements _TMDBPerson {
  const _$TMDBPersonImpl(
      {required this.id,
      required this.name,
      this.profilePath,
      this.adult = false,
      this.knownForDepartment,
      final List<Map<String, dynamic>> knownFor = const []})
      : _knownFor = knownFor;

  factory _$TMDBPersonImpl.fromJson(Map<String, dynamic> json) =>
      _$$TMDBPersonImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? profilePath;
  @override
  @JsonKey()
  final bool adult;
  @override
  final String? knownForDepartment;
  final List<Map<String, dynamic>> _knownFor;
  @override
  @JsonKey()
  List<Map<String, dynamic>> get knownFor {
    if (_knownFor is EqualUnmodifiableListView) return _knownFor;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_knownFor);
  }

  @override
  String toString() {
    return 'TMDBPerson(id: $id, name: $name, profilePath: $profilePath, adult: $adult, knownForDepartment: $knownForDepartment, knownFor: $knownFor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TMDBPersonImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.profilePath, profilePath) ||
                other.profilePath == profilePath) &&
            (identical(other.adult, adult) || other.adult == adult) &&
            (identical(other.knownForDepartment, knownForDepartment) ||
                other.knownForDepartment == knownForDepartment) &&
            const DeepCollectionEquality().equals(other._knownFor, _knownFor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, profilePath, adult,
      knownForDepartment, const DeepCollectionEquality().hash(_knownFor));

  /// Create a copy of TMDBPerson
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TMDBPersonImplCopyWith<_$TMDBPersonImpl> get copyWith =>
      __$$TMDBPersonImplCopyWithImpl<_$TMDBPersonImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TMDBPersonImplToJson(
      this,
    );
  }
}

abstract class _TMDBPerson implements TMDBPerson {
  const factory _TMDBPerson(
      {required final int id,
      required final String name,
      final String? profilePath,
      final bool adult,
      final String? knownForDepartment,
      final List<Map<String, dynamic>> knownFor}) = _$TMDBPersonImpl;

  factory _TMDBPerson.fromJson(Map<String, dynamic> json) =
      _$TMDBPersonImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get profilePath;
  @override
  bool get adult;
  @override
  String? get knownForDepartment;
  @override
  List<Map<String, dynamic>> get knownFor;

  /// Create a copy of TMDBPerson
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TMDBPersonImplCopyWith<_$TMDBPersonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TMDBSearchResult _$TMDBSearchResultFromJson(Map<String, dynamic> json) {
  return _TMDBSearchResult.fromJson(json);
}

/// @nodoc
mixin _$TMDBSearchResult {
  int get page => throw _privateConstructorUsedError;
  int get totalResults => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  List<TMDBMovie> get movies => throw _privateConstructorUsedError;
  List<TMDBTVShow> get tvShows => throw _privateConstructorUsedError;
  List<TMDBPerson> get people => throw _privateConstructorUsedError;

  /// Serializes this TMDBSearchResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TMDBSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TMDBSearchResultCopyWith<TMDBSearchResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TMDBSearchResultCopyWith<$Res> {
  factory $TMDBSearchResultCopyWith(
          TMDBSearchResult value, $Res Function(TMDBSearchResult) then) =
      _$TMDBSearchResultCopyWithImpl<$Res, TMDBSearchResult>;
  @useResult
  $Res call(
      {int page,
      int totalResults,
      int totalPages,
      List<TMDBMovie> movies,
      List<TMDBTVShow> tvShows,
      List<TMDBPerson> people});
}

/// @nodoc
class _$TMDBSearchResultCopyWithImpl<$Res, $Val extends TMDBSearchResult>
    implements $TMDBSearchResultCopyWith<$Res> {
  _$TMDBSearchResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TMDBSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? totalResults = null,
    Object? totalPages = null,
    Object? movies = null,
    Object? tvShows = null,
    Object? people = null,
  }) {
    return _then(_value.copyWith(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      totalResults: null == totalResults
          ? _value.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      movies: null == movies
          ? _value.movies
          : movies // ignore: cast_nullable_to_non_nullable
              as List<TMDBMovie>,
      tvShows: null == tvShows
          ? _value.tvShows
          : tvShows // ignore: cast_nullable_to_non_nullable
              as List<TMDBTVShow>,
      people: null == people
          ? _value.people
          : people // ignore: cast_nullable_to_non_nullable
              as List<TMDBPerson>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TMDBSearchResultImplCopyWith<$Res>
    implements $TMDBSearchResultCopyWith<$Res> {
  factory _$$TMDBSearchResultImplCopyWith(_$TMDBSearchResultImpl value,
          $Res Function(_$TMDBSearchResultImpl) then) =
      __$$TMDBSearchResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int page,
      int totalResults,
      int totalPages,
      List<TMDBMovie> movies,
      List<TMDBTVShow> tvShows,
      List<TMDBPerson> people});
}

/// @nodoc
class __$$TMDBSearchResultImplCopyWithImpl<$Res>
    extends _$TMDBSearchResultCopyWithImpl<$Res, _$TMDBSearchResultImpl>
    implements _$$TMDBSearchResultImplCopyWith<$Res> {
  __$$TMDBSearchResultImplCopyWithImpl(_$TMDBSearchResultImpl _value,
      $Res Function(_$TMDBSearchResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of TMDBSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? totalResults = null,
    Object? totalPages = null,
    Object? movies = null,
    Object? tvShows = null,
    Object? people = null,
  }) {
    return _then(_$TMDBSearchResultImpl(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      totalResults: null == totalResults
          ? _value.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      movies: null == movies
          ? _value._movies
          : movies // ignore: cast_nullable_to_non_nullable
              as List<TMDBMovie>,
      tvShows: null == tvShows
          ? _value._tvShows
          : tvShows // ignore: cast_nullable_to_non_nullable
              as List<TMDBTVShow>,
      people: null == people
          ? _value._people
          : people // ignore: cast_nullable_to_non_nullable
              as List<TMDBPerson>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TMDBSearchResultImpl implements _TMDBSearchResult {
  const _$TMDBSearchResultImpl(
      {this.page = 1,
      this.totalResults = 0,
      this.totalPages = 0,
      final List<TMDBMovie> movies = const [],
      final List<TMDBTVShow> tvShows = const [],
      final List<TMDBPerson> people = const []})
      : _movies = movies,
        _tvShows = tvShows,
        _people = people;

  factory _$TMDBSearchResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$TMDBSearchResultImplFromJson(json);

  @override
  @JsonKey()
  final int page;
  @override
  @JsonKey()
  final int totalResults;
  @override
  @JsonKey()
  final int totalPages;
  final List<TMDBMovie> _movies;
  @override
  @JsonKey()
  List<TMDBMovie> get movies {
    if (_movies is EqualUnmodifiableListView) return _movies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_movies);
  }

  final List<TMDBTVShow> _tvShows;
  @override
  @JsonKey()
  List<TMDBTVShow> get tvShows {
    if (_tvShows is EqualUnmodifiableListView) return _tvShows;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tvShows);
  }

  final List<TMDBPerson> _people;
  @override
  @JsonKey()
  List<TMDBPerson> get people {
    if (_people is EqualUnmodifiableListView) return _people;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_people);
  }

  @override
  String toString() {
    return 'TMDBSearchResult(page: $page, totalResults: $totalResults, totalPages: $totalPages, movies: $movies, tvShows: $tvShows, people: $people)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TMDBSearchResultImpl &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.totalResults, totalResults) ||
                other.totalResults == totalResults) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            const DeepCollectionEquality().equals(other._movies, _movies) &&
            const DeepCollectionEquality().equals(other._tvShows, _tvShows) &&
            const DeepCollectionEquality().equals(other._people, _people));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      page,
      totalResults,
      totalPages,
      const DeepCollectionEquality().hash(_movies),
      const DeepCollectionEquality().hash(_tvShows),
      const DeepCollectionEquality().hash(_people));

  /// Create a copy of TMDBSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TMDBSearchResultImplCopyWith<_$TMDBSearchResultImpl> get copyWith =>
      __$$TMDBSearchResultImplCopyWithImpl<_$TMDBSearchResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TMDBSearchResultImplToJson(
      this,
    );
  }
}

abstract class _TMDBSearchResult implements TMDBSearchResult {
  const factory _TMDBSearchResult(
      {final int page,
      final int totalResults,
      final int totalPages,
      final List<TMDBMovie> movies,
      final List<TMDBTVShow> tvShows,
      final List<TMDBPerson> people}) = _$TMDBSearchResultImpl;

  factory _TMDBSearchResult.fromJson(Map<String, dynamic> json) =
      _$TMDBSearchResultImpl.fromJson;

  @override
  int get page;
  @override
  int get totalResults;
  @override
  int get totalPages;
  @override
  List<TMDBMovie> get movies;
  @override
  List<TMDBTVShow> get tvShows;
  @override
  List<TMDBPerson> get people;

  /// Create a copy of TMDBSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TMDBSearchResultImplCopyWith<_$TMDBSearchResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TMDBGenre _$TMDBGenreFromJson(Map<String, dynamic> json) {
  return _TMDBGenre.fromJson(json);
}

/// @nodoc
mixin _$TMDBGenre {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this TMDBGenre to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TMDBGenre
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TMDBGenreCopyWith<TMDBGenre> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TMDBGenreCopyWith<$Res> {
  factory $TMDBGenreCopyWith(TMDBGenre value, $Res Function(TMDBGenre) then) =
      _$TMDBGenreCopyWithImpl<$Res, TMDBGenre>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$TMDBGenreCopyWithImpl<$Res, $Val extends TMDBGenre>
    implements $TMDBGenreCopyWith<$Res> {
  _$TMDBGenreCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TMDBGenre
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TMDBGenreImplCopyWith<$Res>
    implements $TMDBGenreCopyWith<$Res> {
  factory _$$TMDBGenreImplCopyWith(
          _$TMDBGenreImpl value, $Res Function(_$TMDBGenreImpl) then) =
      __$$TMDBGenreImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$TMDBGenreImplCopyWithImpl<$Res>
    extends _$TMDBGenreCopyWithImpl<$Res, _$TMDBGenreImpl>
    implements _$$TMDBGenreImplCopyWith<$Res> {
  __$$TMDBGenreImplCopyWithImpl(
      _$TMDBGenreImpl _value, $Res Function(_$TMDBGenreImpl) _then)
      : super(_value, _then);

  /// Create a copy of TMDBGenre
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$TMDBGenreImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TMDBGenreImpl implements _TMDBGenre {
  const _$TMDBGenreImpl({required this.id, required this.name});

  factory _$TMDBGenreImpl.fromJson(Map<String, dynamic> json) =>
      _$$TMDBGenreImplFromJson(json);

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'TMDBGenre(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TMDBGenreImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of TMDBGenre
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TMDBGenreImplCopyWith<_$TMDBGenreImpl> get copyWith =>
      __$$TMDBGenreImplCopyWithImpl<_$TMDBGenreImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TMDBGenreImplToJson(
      this,
    );
  }
}

abstract class _TMDBGenre implements TMDBGenre {
  const factory _TMDBGenre(
      {required final int id, required final String name}) = _$TMDBGenreImpl;

  factory _TMDBGenre.fromJson(Map<String, dynamic> json) =
      _$TMDBGenreImpl.fromJson;

  @override
  int get id;
  @override
  String get name;

  /// Create a copy of TMDBGenre
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TMDBGenreImplCopyWith<_$TMDBGenreImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TMDBMovieDetail _$TMDBMovieDetailFromJson(Map<String, dynamic> json) {
  return _TMDBMovieDetail.fromJson(json);
}

/// @nodoc
mixin _$TMDBMovieDetail {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'original_title')
  String? get originalTitle => throw _privateConstructorUsedError;
  String? get overview => throw _privateConstructorUsedError;
  @JsonKey(name: 'poster_path')
  String? get posterPath => throw _privateConstructorUsedError;
  @JsonKey(name: 'backdrop_path')
  String? get backdropPath => throw _privateConstructorUsedError;
  @JsonKey(name: 'release_date')
  String? get releaseDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'vote_average')
  double get voteAverage => throw _privateConstructorUsedError;
  @JsonKey(name: 'vote_count')
  int get voteCount => throw _privateConstructorUsedError;
  List<TMDBGenre> get genres => throw _privateConstructorUsedError;
  bool get adult => throw _privateConstructorUsedError;
  double get popularity => throw _privateConstructorUsedError;
  int? get runtime => throw _privateConstructorUsedError;
  String? get tagline => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  int? get budget => throw _privateConstructorUsedError;
  int? get revenue => throw _privateConstructorUsedError;
  @JsonKey(name: 'imdb_id')
  String? get imdbId => throw _privateConstructorUsedError;
  @JsonKey(name: 'original_language')
  String? get originalLanguage => throw _privateConstructorUsedError;

  /// Serializes this TMDBMovieDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TMDBMovieDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TMDBMovieDetailCopyWith<TMDBMovieDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TMDBMovieDetailCopyWith<$Res> {
  factory $TMDBMovieDetailCopyWith(
          TMDBMovieDetail value, $Res Function(TMDBMovieDetail) then) =
      _$TMDBMovieDetailCopyWithImpl<$Res, TMDBMovieDetail>;
  @useResult
  $Res call(
      {int id,
      String title,
      @JsonKey(name: 'original_title') String? originalTitle,
      String? overview,
      @JsonKey(name: 'poster_path') String? posterPath,
      @JsonKey(name: 'backdrop_path') String? backdropPath,
      @JsonKey(name: 'release_date') String? releaseDate,
      @JsonKey(name: 'vote_average') double voteAverage,
      @JsonKey(name: 'vote_count') int voteCount,
      List<TMDBGenre> genres,
      bool adult,
      double popularity,
      int? runtime,
      String? tagline,
      String? status,
      int? budget,
      int? revenue,
      @JsonKey(name: 'imdb_id') String? imdbId,
      @JsonKey(name: 'original_language') String? originalLanguage});
}

/// @nodoc
class _$TMDBMovieDetailCopyWithImpl<$Res, $Val extends TMDBMovieDetail>
    implements $TMDBMovieDetailCopyWith<$Res> {
  _$TMDBMovieDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TMDBMovieDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? originalTitle = freezed,
    Object? overview = freezed,
    Object? posterPath = freezed,
    Object? backdropPath = freezed,
    Object? releaseDate = freezed,
    Object? voteAverage = null,
    Object? voteCount = null,
    Object? genres = null,
    Object? adult = null,
    Object? popularity = null,
    Object? runtime = freezed,
    Object? tagline = freezed,
    Object? status = freezed,
    Object? budget = freezed,
    Object? revenue = freezed,
    Object? imdbId = freezed,
    Object? originalLanguage = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      originalTitle: freezed == originalTitle
          ? _value.originalTitle
          : originalTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      posterPath: freezed == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      backdropPath: freezed == backdropPath
          ? _value.backdropPath
          : backdropPath // ignore: cast_nullable_to_non_nullable
              as String?,
      releaseDate: freezed == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as String?,
      voteAverage: null == voteAverage
          ? _value.voteAverage
          : voteAverage // ignore: cast_nullable_to_non_nullable
              as double,
      voteCount: null == voteCount
          ? _value.voteCount
          : voteCount // ignore: cast_nullable_to_non_nullable
              as int,
      genres: null == genres
          ? _value.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<TMDBGenre>,
      adult: null == adult
          ? _value.adult
          : adult // ignore: cast_nullable_to_non_nullable
              as bool,
      popularity: null == popularity
          ? _value.popularity
          : popularity // ignore: cast_nullable_to_non_nullable
              as double,
      runtime: freezed == runtime
          ? _value.runtime
          : runtime // ignore: cast_nullable_to_non_nullable
              as int?,
      tagline: freezed == tagline
          ? _value.tagline
          : tagline // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      budget: freezed == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as int?,
      revenue: freezed == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as int?,
      imdbId: freezed == imdbId
          ? _value.imdbId
          : imdbId // ignore: cast_nullable_to_non_nullable
              as String?,
      originalLanguage: freezed == originalLanguage
          ? _value.originalLanguage
          : originalLanguage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TMDBMovieDetailImplCopyWith<$Res>
    implements $TMDBMovieDetailCopyWith<$Res> {
  factory _$$TMDBMovieDetailImplCopyWith(_$TMDBMovieDetailImpl value,
          $Res Function(_$TMDBMovieDetailImpl) then) =
      __$$TMDBMovieDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      @JsonKey(name: 'original_title') String? originalTitle,
      String? overview,
      @JsonKey(name: 'poster_path') String? posterPath,
      @JsonKey(name: 'backdrop_path') String? backdropPath,
      @JsonKey(name: 'release_date') String? releaseDate,
      @JsonKey(name: 'vote_average') double voteAverage,
      @JsonKey(name: 'vote_count') int voteCount,
      List<TMDBGenre> genres,
      bool adult,
      double popularity,
      int? runtime,
      String? tagline,
      String? status,
      int? budget,
      int? revenue,
      @JsonKey(name: 'imdb_id') String? imdbId,
      @JsonKey(name: 'original_language') String? originalLanguage});
}

/// @nodoc
class __$$TMDBMovieDetailImplCopyWithImpl<$Res>
    extends _$TMDBMovieDetailCopyWithImpl<$Res, _$TMDBMovieDetailImpl>
    implements _$$TMDBMovieDetailImplCopyWith<$Res> {
  __$$TMDBMovieDetailImplCopyWithImpl(
      _$TMDBMovieDetailImpl _value, $Res Function(_$TMDBMovieDetailImpl) _then)
      : super(_value, _then);

  /// Create a copy of TMDBMovieDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? originalTitle = freezed,
    Object? overview = freezed,
    Object? posterPath = freezed,
    Object? backdropPath = freezed,
    Object? releaseDate = freezed,
    Object? voteAverage = null,
    Object? voteCount = null,
    Object? genres = null,
    Object? adult = null,
    Object? popularity = null,
    Object? runtime = freezed,
    Object? tagline = freezed,
    Object? status = freezed,
    Object? budget = freezed,
    Object? revenue = freezed,
    Object? imdbId = freezed,
    Object? originalLanguage = freezed,
  }) {
    return _then(_$TMDBMovieDetailImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      originalTitle: freezed == originalTitle
          ? _value.originalTitle
          : originalTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      posterPath: freezed == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      backdropPath: freezed == backdropPath
          ? _value.backdropPath
          : backdropPath // ignore: cast_nullable_to_non_nullable
              as String?,
      releaseDate: freezed == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as String?,
      voteAverage: null == voteAverage
          ? _value.voteAverage
          : voteAverage // ignore: cast_nullable_to_non_nullable
              as double,
      voteCount: null == voteCount
          ? _value.voteCount
          : voteCount // ignore: cast_nullable_to_non_nullable
              as int,
      genres: null == genres
          ? _value._genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<TMDBGenre>,
      adult: null == adult
          ? _value.adult
          : adult // ignore: cast_nullable_to_non_nullable
              as bool,
      popularity: null == popularity
          ? _value.popularity
          : popularity // ignore: cast_nullable_to_non_nullable
              as double,
      runtime: freezed == runtime
          ? _value.runtime
          : runtime // ignore: cast_nullable_to_non_nullable
              as int?,
      tagline: freezed == tagline
          ? _value.tagline
          : tagline // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      budget: freezed == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as int?,
      revenue: freezed == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as int?,
      imdbId: freezed == imdbId
          ? _value.imdbId
          : imdbId // ignore: cast_nullable_to_non_nullable
              as String?,
      originalLanguage: freezed == originalLanguage
          ? _value.originalLanguage
          : originalLanguage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TMDBMovieDetailImpl implements _TMDBMovieDetail {
  const _$TMDBMovieDetailImpl(
      {required this.id,
      required this.title,
      @JsonKey(name: 'original_title') this.originalTitle,
      this.overview,
      @JsonKey(name: 'poster_path') this.posterPath,
      @JsonKey(name: 'backdrop_path') this.backdropPath,
      @JsonKey(name: 'release_date') this.releaseDate,
      @JsonKey(name: 'vote_average') this.voteAverage = 0.0,
      @JsonKey(name: 'vote_count') this.voteCount = 0,
      final List<TMDBGenre> genres = const [],
      this.adult = false,
      this.popularity = 0.0,
      this.runtime,
      this.tagline,
      this.status,
      this.budget,
      this.revenue,
      @JsonKey(name: 'imdb_id') this.imdbId,
      @JsonKey(name: 'original_language') this.originalLanguage})
      : _genres = genres;

  factory _$TMDBMovieDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$TMDBMovieDetailImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  @JsonKey(name: 'original_title')
  final String? originalTitle;
  @override
  final String? overview;
  @override
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @override
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @override
  @JsonKey(name: 'release_date')
  final String? releaseDate;
  @override
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @override
  @JsonKey(name: 'vote_count')
  final int voteCount;
  final List<TMDBGenre> _genres;
  @override
  @JsonKey()
  List<TMDBGenre> get genres {
    if (_genres is EqualUnmodifiableListView) return _genres;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_genres);
  }

  @override
  @JsonKey()
  final bool adult;
  @override
  @JsonKey()
  final double popularity;
  @override
  final int? runtime;
  @override
  final String? tagline;
  @override
  final String? status;
  @override
  final int? budget;
  @override
  final int? revenue;
  @override
  @JsonKey(name: 'imdb_id')
  final String? imdbId;
  @override
  @JsonKey(name: 'original_language')
  final String? originalLanguage;

  @override
  String toString() {
    return 'TMDBMovieDetail(id: $id, title: $title, originalTitle: $originalTitle, overview: $overview, posterPath: $posterPath, backdropPath: $backdropPath, releaseDate: $releaseDate, voteAverage: $voteAverage, voteCount: $voteCount, genres: $genres, adult: $adult, popularity: $popularity, runtime: $runtime, tagline: $tagline, status: $status, budget: $budget, revenue: $revenue, imdbId: $imdbId, originalLanguage: $originalLanguage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TMDBMovieDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.originalTitle, originalTitle) ||
                other.originalTitle == originalTitle) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            (identical(other.posterPath, posterPath) ||
                other.posterPath == posterPath) &&
            (identical(other.backdropPath, backdropPath) ||
                other.backdropPath == backdropPath) &&
            (identical(other.releaseDate, releaseDate) ||
                other.releaseDate == releaseDate) &&
            (identical(other.voteAverage, voteAverage) ||
                other.voteAverage == voteAverage) &&
            (identical(other.voteCount, voteCount) ||
                other.voteCount == voteCount) &&
            const DeepCollectionEquality().equals(other._genres, _genres) &&
            (identical(other.adult, adult) || other.adult == adult) &&
            (identical(other.popularity, popularity) ||
                other.popularity == popularity) &&
            (identical(other.runtime, runtime) || other.runtime == runtime) &&
            (identical(other.tagline, tagline) || other.tagline == tagline) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.budget, budget) || other.budget == budget) &&
            (identical(other.revenue, revenue) || other.revenue == revenue) &&
            (identical(other.imdbId, imdbId) || other.imdbId == imdbId) &&
            (identical(other.originalLanguage, originalLanguage) ||
                other.originalLanguage == originalLanguage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        title,
        originalTitle,
        overview,
        posterPath,
        backdropPath,
        releaseDate,
        voteAverage,
        voteCount,
        const DeepCollectionEquality().hash(_genres),
        adult,
        popularity,
        runtime,
        tagline,
        status,
        budget,
        revenue,
        imdbId,
        originalLanguage
      ]);

  /// Create a copy of TMDBMovieDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TMDBMovieDetailImplCopyWith<_$TMDBMovieDetailImpl> get copyWith =>
      __$$TMDBMovieDetailImplCopyWithImpl<_$TMDBMovieDetailImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TMDBMovieDetailImplToJson(
      this,
    );
  }
}

abstract class _TMDBMovieDetail implements TMDBMovieDetail {
  const factory _TMDBMovieDetail(
          {required final int id,
          required final String title,
          @JsonKey(name: 'original_title') final String? originalTitle,
          final String? overview,
          @JsonKey(name: 'poster_path') final String? posterPath,
          @JsonKey(name: 'backdrop_path') final String? backdropPath,
          @JsonKey(name: 'release_date') final String? releaseDate,
          @JsonKey(name: 'vote_average') final double voteAverage,
          @JsonKey(name: 'vote_count') final int voteCount,
          final List<TMDBGenre> genres,
          final bool adult,
          final double popularity,
          final int? runtime,
          final String? tagline,
          final String? status,
          final int? budget,
          final int? revenue,
          @JsonKey(name: 'imdb_id') final String? imdbId,
          @JsonKey(name: 'original_language') final String? originalLanguage}) =
      _$TMDBMovieDetailImpl;

  factory _TMDBMovieDetail.fromJson(Map<String, dynamic> json) =
      _$TMDBMovieDetailImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  @JsonKey(name: 'original_title')
  String? get originalTitle;
  @override
  String? get overview;
  @override
  @JsonKey(name: 'poster_path')
  String? get posterPath;
  @override
  @JsonKey(name: 'backdrop_path')
  String? get backdropPath;
  @override
  @JsonKey(name: 'release_date')
  String? get releaseDate;
  @override
  @JsonKey(name: 'vote_average')
  double get voteAverage;
  @override
  @JsonKey(name: 'vote_count')
  int get voteCount;
  @override
  List<TMDBGenre> get genres;
  @override
  bool get adult;
  @override
  double get popularity;
  @override
  int? get runtime;
  @override
  String? get tagline;
  @override
  String? get status;
  @override
  int? get budget;
  @override
  int? get revenue;
  @override
  @JsonKey(name: 'imdb_id')
  String? get imdbId;
  @override
  @JsonKey(name: 'original_language')
  String? get originalLanguage;

  /// Create a copy of TMDBMovieDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TMDBMovieDetailImplCopyWith<_$TMDBMovieDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TMDBTVShowDetail _$TMDBTVShowDetailFromJson(Map<String, dynamic> json) {
  return _TMDBTVShowDetail.fromJson(json);
}

/// @nodoc
mixin _$TMDBTVShowDetail {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'original_name')
  String? get originalName => throw _privateConstructorUsedError;
  String? get overview => throw _privateConstructorUsedError;
  @JsonKey(name: 'poster_path')
  String? get posterPath => throw _privateConstructorUsedError;
  @JsonKey(name: 'backdrop_path')
  String? get backdropPath => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_air_date')
  String? get firstAirDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_air_date')
  String? get lastAirDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'vote_average')
  double get voteAverage => throw _privateConstructorUsedError;
  @JsonKey(name: 'vote_count')
  int get voteCount => throw _privateConstructorUsedError;
  List<TMDBGenre> get genres => throw _privateConstructorUsedError;
  @JsonKey(name: 'origin_country')
  List<String> get originCountry => throw _privateConstructorUsedError;
  double get popularity => throw _privateConstructorUsedError;
  String? get tagline => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'original_language')
  String? get originalLanguage => throw _privateConstructorUsedError;
  @JsonKey(name: 'number_of_seasons')
  int? get numberOfSeasons => throw _privateConstructorUsedError;
  @JsonKey(name: 'number_of_episodes')
  int? get numberOfEpisodes => throw _privateConstructorUsedError;
  @JsonKey(name: 'episode_run_time')
  List<int> get episodeRunTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'in_production')
  bool get inProduction => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;

  /// Serializes this TMDBTVShowDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TMDBTVShowDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TMDBTVShowDetailCopyWith<TMDBTVShowDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TMDBTVShowDetailCopyWith<$Res> {
  factory $TMDBTVShowDetailCopyWith(
          TMDBTVShowDetail value, $Res Function(TMDBTVShowDetail) then) =
      _$TMDBTVShowDetailCopyWithImpl<$Res, TMDBTVShowDetail>;
  @useResult
  $Res call(
      {int id,
      String name,
      @JsonKey(name: 'original_name') String? originalName,
      String? overview,
      @JsonKey(name: 'poster_path') String? posterPath,
      @JsonKey(name: 'backdrop_path') String? backdropPath,
      @JsonKey(name: 'first_air_date') String? firstAirDate,
      @JsonKey(name: 'last_air_date') String? lastAirDate,
      @JsonKey(name: 'vote_average') double voteAverage,
      @JsonKey(name: 'vote_count') int voteCount,
      List<TMDBGenre> genres,
      @JsonKey(name: 'origin_country') List<String> originCountry,
      double popularity,
      String? tagline,
      String? status,
      @JsonKey(name: 'original_language') String? originalLanguage,
      @JsonKey(name: 'number_of_seasons') int? numberOfSeasons,
      @JsonKey(name: 'number_of_episodes') int? numberOfEpisodes,
      @JsonKey(name: 'episode_run_time') List<int> episodeRunTime,
      @JsonKey(name: 'in_production') bool inProduction,
      String? type});
}

/// @nodoc
class _$TMDBTVShowDetailCopyWithImpl<$Res, $Val extends TMDBTVShowDetail>
    implements $TMDBTVShowDetailCopyWith<$Res> {
  _$TMDBTVShowDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TMDBTVShowDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? originalName = freezed,
    Object? overview = freezed,
    Object? posterPath = freezed,
    Object? backdropPath = freezed,
    Object? firstAirDate = freezed,
    Object? lastAirDate = freezed,
    Object? voteAverage = null,
    Object? voteCount = null,
    Object? genres = null,
    Object? originCountry = null,
    Object? popularity = null,
    Object? tagline = freezed,
    Object? status = freezed,
    Object? originalLanguage = freezed,
    Object? numberOfSeasons = freezed,
    Object? numberOfEpisodes = freezed,
    Object? episodeRunTime = null,
    Object? inProduction = null,
    Object? type = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      originalName: freezed == originalName
          ? _value.originalName
          : originalName // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      posterPath: freezed == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      backdropPath: freezed == backdropPath
          ? _value.backdropPath
          : backdropPath // ignore: cast_nullable_to_non_nullable
              as String?,
      firstAirDate: freezed == firstAirDate
          ? _value.firstAirDate
          : firstAirDate // ignore: cast_nullable_to_non_nullable
              as String?,
      lastAirDate: freezed == lastAirDate
          ? _value.lastAirDate
          : lastAirDate // ignore: cast_nullable_to_non_nullable
              as String?,
      voteAverage: null == voteAverage
          ? _value.voteAverage
          : voteAverage // ignore: cast_nullable_to_non_nullable
              as double,
      voteCount: null == voteCount
          ? _value.voteCount
          : voteCount // ignore: cast_nullable_to_non_nullable
              as int,
      genres: null == genres
          ? _value.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<TMDBGenre>,
      originCountry: null == originCountry
          ? _value.originCountry
          : originCountry // ignore: cast_nullable_to_non_nullable
              as List<String>,
      popularity: null == popularity
          ? _value.popularity
          : popularity // ignore: cast_nullable_to_non_nullable
              as double,
      tagline: freezed == tagline
          ? _value.tagline
          : tagline // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      originalLanguage: freezed == originalLanguage
          ? _value.originalLanguage
          : originalLanguage // ignore: cast_nullable_to_non_nullable
              as String?,
      numberOfSeasons: freezed == numberOfSeasons
          ? _value.numberOfSeasons
          : numberOfSeasons // ignore: cast_nullable_to_non_nullable
              as int?,
      numberOfEpisodes: freezed == numberOfEpisodes
          ? _value.numberOfEpisodes
          : numberOfEpisodes // ignore: cast_nullable_to_non_nullable
              as int?,
      episodeRunTime: null == episodeRunTime
          ? _value.episodeRunTime
          : episodeRunTime // ignore: cast_nullable_to_non_nullable
              as List<int>,
      inProduction: null == inProduction
          ? _value.inProduction
          : inProduction // ignore: cast_nullable_to_non_nullable
              as bool,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TMDBTVShowDetailImplCopyWith<$Res>
    implements $TMDBTVShowDetailCopyWith<$Res> {
  factory _$$TMDBTVShowDetailImplCopyWith(_$TMDBTVShowDetailImpl value,
          $Res Function(_$TMDBTVShowDetailImpl) then) =
      __$$TMDBTVShowDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      @JsonKey(name: 'original_name') String? originalName,
      String? overview,
      @JsonKey(name: 'poster_path') String? posterPath,
      @JsonKey(name: 'backdrop_path') String? backdropPath,
      @JsonKey(name: 'first_air_date') String? firstAirDate,
      @JsonKey(name: 'last_air_date') String? lastAirDate,
      @JsonKey(name: 'vote_average') double voteAverage,
      @JsonKey(name: 'vote_count') int voteCount,
      List<TMDBGenre> genres,
      @JsonKey(name: 'origin_country') List<String> originCountry,
      double popularity,
      String? tagline,
      String? status,
      @JsonKey(name: 'original_language') String? originalLanguage,
      @JsonKey(name: 'number_of_seasons') int? numberOfSeasons,
      @JsonKey(name: 'number_of_episodes') int? numberOfEpisodes,
      @JsonKey(name: 'episode_run_time') List<int> episodeRunTime,
      @JsonKey(name: 'in_production') bool inProduction,
      String? type});
}

/// @nodoc
class __$$TMDBTVShowDetailImplCopyWithImpl<$Res>
    extends _$TMDBTVShowDetailCopyWithImpl<$Res, _$TMDBTVShowDetailImpl>
    implements _$$TMDBTVShowDetailImplCopyWith<$Res> {
  __$$TMDBTVShowDetailImplCopyWithImpl(_$TMDBTVShowDetailImpl _value,
      $Res Function(_$TMDBTVShowDetailImpl) _then)
      : super(_value, _then);

  /// Create a copy of TMDBTVShowDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? originalName = freezed,
    Object? overview = freezed,
    Object? posterPath = freezed,
    Object? backdropPath = freezed,
    Object? firstAirDate = freezed,
    Object? lastAirDate = freezed,
    Object? voteAverage = null,
    Object? voteCount = null,
    Object? genres = null,
    Object? originCountry = null,
    Object? popularity = null,
    Object? tagline = freezed,
    Object? status = freezed,
    Object? originalLanguage = freezed,
    Object? numberOfSeasons = freezed,
    Object? numberOfEpisodes = freezed,
    Object? episodeRunTime = null,
    Object? inProduction = null,
    Object? type = freezed,
  }) {
    return _then(_$TMDBTVShowDetailImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      originalName: freezed == originalName
          ? _value.originalName
          : originalName // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      posterPath: freezed == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      backdropPath: freezed == backdropPath
          ? _value.backdropPath
          : backdropPath // ignore: cast_nullable_to_non_nullable
              as String?,
      firstAirDate: freezed == firstAirDate
          ? _value.firstAirDate
          : firstAirDate // ignore: cast_nullable_to_non_nullable
              as String?,
      lastAirDate: freezed == lastAirDate
          ? _value.lastAirDate
          : lastAirDate // ignore: cast_nullable_to_non_nullable
              as String?,
      voteAverage: null == voteAverage
          ? _value.voteAverage
          : voteAverage // ignore: cast_nullable_to_non_nullable
              as double,
      voteCount: null == voteCount
          ? _value.voteCount
          : voteCount // ignore: cast_nullable_to_non_nullable
              as int,
      genres: null == genres
          ? _value._genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<TMDBGenre>,
      originCountry: null == originCountry
          ? _value._originCountry
          : originCountry // ignore: cast_nullable_to_non_nullable
              as List<String>,
      popularity: null == popularity
          ? _value.popularity
          : popularity // ignore: cast_nullable_to_non_nullable
              as double,
      tagline: freezed == tagline
          ? _value.tagline
          : tagline // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      originalLanguage: freezed == originalLanguage
          ? _value.originalLanguage
          : originalLanguage // ignore: cast_nullable_to_non_nullable
              as String?,
      numberOfSeasons: freezed == numberOfSeasons
          ? _value.numberOfSeasons
          : numberOfSeasons // ignore: cast_nullable_to_non_nullable
              as int?,
      numberOfEpisodes: freezed == numberOfEpisodes
          ? _value.numberOfEpisodes
          : numberOfEpisodes // ignore: cast_nullable_to_non_nullable
              as int?,
      episodeRunTime: null == episodeRunTime
          ? _value._episodeRunTime
          : episodeRunTime // ignore: cast_nullable_to_non_nullable
              as List<int>,
      inProduction: null == inProduction
          ? _value.inProduction
          : inProduction // ignore: cast_nullable_to_non_nullable
              as bool,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TMDBTVShowDetailImpl implements _TMDBTVShowDetail {
  const _$TMDBTVShowDetailImpl(
      {required this.id,
      required this.name,
      @JsonKey(name: 'original_name') this.originalName,
      this.overview,
      @JsonKey(name: 'poster_path') this.posterPath,
      @JsonKey(name: 'backdrop_path') this.backdropPath,
      @JsonKey(name: 'first_air_date') this.firstAirDate,
      @JsonKey(name: 'last_air_date') this.lastAirDate,
      @JsonKey(name: 'vote_average') this.voteAverage = 0.0,
      @JsonKey(name: 'vote_count') this.voteCount = 0,
      final List<TMDBGenre> genres = const [],
      @JsonKey(name: 'origin_country')
      final List<String> originCountry = const [],
      this.popularity = 0.0,
      this.tagline,
      this.status,
      @JsonKey(name: 'original_language') this.originalLanguage,
      @JsonKey(name: 'number_of_seasons') this.numberOfSeasons,
      @JsonKey(name: 'number_of_episodes') this.numberOfEpisodes,
      @JsonKey(name: 'episode_run_time')
      final List<int> episodeRunTime = const [],
      @JsonKey(name: 'in_production') this.inProduction = false,
      this.type})
      : _genres = genres,
        _originCountry = originCountry,
        _episodeRunTime = episodeRunTime;

  factory _$TMDBTVShowDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$TMDBTVShowDetailImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  @JsonKey(name: 'original_name')
  final String? originalName;
  @override
  final String? overview;
  @override
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @override
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @override
  @JsonKey(name: 'first_air_date')
  final String? firstAirDate;
  @override
  @JsonKey(name: 'last_air_date')
  final String? lastAirDate;
  @override
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @override
  @JsonKey(name: 'vote_count')
  final int voteCount;
  final List<TMDBGenre> _genres;
  @override
  @JsonKey()
  List<TMDBGenre> get genres {
    if (_genres is EqualUnmodifiableListView) return _genres;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_genres);
  }

  final List<String> _originCountry;
  @override
  @JsonKey(name: 'origin_country')
  List<String> get originCountry {
    if (_originCountry is EqualUnmodifiableListView) return _originCountry;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_originCountry);
  }

  @override
  @JsonKey()
  final double popularity;
  @override
  final String? tagline;
  @override
  final String? status;
  @override
  @JsonKey(name: 'original_language')
  final String? originalLanguage;
  @override
  @JsonKey(name: 'number_of_seasons')
  final int? numberOfSeasons;
  @override
  @JsonKey(name: 'number_of_episodes')
  final int? numberOfEpisodes;
  final List<int> _episodeRunTime;
  @override
  @JsonKey(name: 'episode_run_time')
  List<int> get episodeRunTime {
    if (_episodeRunTime is EqualUnmodifiableListView) return _episodeRunTime;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_episodeRunTime);
  }

  @override
  @JsonKey(name: 'in_production')
  final bool inProduction;
  @override
  final String? type;

  @override
  String toString() {
    return 'TMDBTVShowDetail(id: $id, name: $name, originalName: $originalName, overview: $overview, posterPath: $posterPath, backdropPath: $backdropPath, firstAirDate: $firstAirDate, lastAirDate: $lastAirDate, voteAverage: $voteAverage, voteCount: $voteCount, genres: $genres, originCountry: $originCountry, popularity: $popularity, tagline: $tagline, status: $status, originalLanguage: $originalLanguage, numberOfSeasons: $numberOfSeasons, numberOfEpisodes: $numberOfEpisodes, episodeRunTime: $episodeRunTime, inProduction: $inProduction, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TMDBTVShowDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.originalName, originalName) ||
                other.originalName == originalName) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            (identical(other.posterPath, posterPath) ||
                other.posterPath == posterPath) &&
            (identical(other.backdropPath, backdropPath) ||
                other.backdropPath == backdropPath) &&
            (identical(other.firstAirDate, firstAirDate) ||
                other.firstAirDate == firstAirDate) &&
            (identical(other.lastAirDate, lastAirDate) ||
                other.lastAirDate == lastAirDate) &&
            (identical(other.voteAverage, voteAverage) ||
                other.voteAverage == voteAverage) &&
            (identical(other.voteCount, voteCount) ||
                other.voteCount == voteCount) &&
            const DeepCollectionEquality().equals(other._genres, _genres) &&
            const DeepCollectionEquality()
                .equals(other._originCountry, _originCountry) &&
            (identical(other.popularity, popularity) ||
                other.popularity == popularity) &&
            (identical(other.tagline, tagline) || other.tagline == tagline) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.originalLanguage, originalLanguage) ||
                other.originalLanguage == originalLanguage) &&
            (identical(other.numberOfSeasons, numberOfSeasons) ||
                other.numberOfSeasons == numberOfSeasons) &&
            (identical(other.numberOfEpisodes, numberOfEpisodes) ||
                other.numberOfEpisodes == numberOfEpisodes) &&
            const DeepCollectionEquality()
                .equals(other._episodeRunTime, _episodeRunTime) &&
            (identical(other.inProduction, inProduction) ||
                other.inProduction == inProduction) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        originalName,
        overview,
        posterPath,
        backdropPath,
        firstAirDate,
        lastAirDate,
        voteAverage,
        voteCount,
        const DeepCollectionEquality().hash(_genres),
        const DeepCollectionEquality().hash(_originCountry),
        popularity,
        tagline,
        status,
        originalLanguage,
        numberOfSeasons,
        numberOfEpisodes,
        const DeepCollectionEquality().hash(_episodeRunTime),
        inProduction,
        type
      ]);

  /// Create a copy of TMDBTVShowDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TMDBTVShowDetailImplCopyWith<_$TMDBTVShowDetailImpl> get copyWith =>
      __$$TMDBTVShowDetailImplCopyWithImpl<_$TMDBTVShowDetailImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TMDBTVShowDetailImplToJson(
      this,
    );
  }
}

abstract class _TMDBTVShowDetail implements TMDBTVShowDetail {
  const factory _TMDBTVShowDetail(
      {required final int id,
      required final String name,
      @JsonKey(name: 'original_name') final String? originalName,
      final String? overview,
      @JsonKey(name: 'poster_path') final String? posterPath,
      @JsonKey(name: 'backdrop_path') final String? backdropPath,
      @JsonKey(name: 'first_air_date') final String? firstAirDate,
      @JsonKey(name: 'last_air_date') final String? lastAirDate,
      @JsonKey(name: 'vote_average') final double voteAverage,
      @JsonKey(name: 'vote_count') final int voteCount,
      final List<TMDBGenre> genres,
      @JsonKey(name: 'origin_country') final List<String> originCountry,
      final double popularity,
      final String? tagline,
      final String? status,
      @JsonKey(name: 'original_language') final String? originalLanguage,
      @JsonKey(name: 'number_of_seasons') final int? numberOfSeasons,
      @JsonKey(name: 'number_of_episodes') final int? numberOfEpisodes,
      @JsonKey(name: 'episode_run_time') final List<int> episodeRunTime,
      @JsonKey(name: 'in_production') final bool inProduction,
      final String? type}) = _$TMDBTVShowDetailImpl;

  factory _TMDBTVShowDetail.fromJson(Map<String, dynamic> json) =
      _$TMDBTVShowDetailImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'original_name')
  String? get originalName;
  @override
  String? get overview;
  @override
  @JsonKey(name: 'poster_path')
  String? get posterPath;
  @override
  @JsonKey(name: 'backdrop_path')
  String? get backdropPath;
  @override
  @JsonKey(name: 'first_air_date')
  String? get firstAirDate;
  @override
  @JsonKey(name: 'last_air_date')
  String? get lastAirDate;
  @override
  @JsonKey(name: 'vote_average')
  double get voteAverage;
  @override
  @JsonKey(name: 'vote_count')
  int get voteCount;
  @override
  List<TMDBGenre> get genres;
  @override
  @JsonKey(name: 'origin_country')
  List<String> get originCountry;
  @override
  double get popularity;
  @override
  String? get tagline;
  @override
  String? get status;
  @override
  @JsonKey(name: 'original_language')
  String? get originalLanguage;
  @override
  @JsonKey(name: 'number_of_seasons')
  int? get numberOfSeasons;
  @override
  @JsonKey(name: 'number_of_episodes')
  int? get numberOfEpisodes;
  @override
  @JsonKey(name: 'episode_run_time')
  List<int> get episodeRunTime;
  @override
  @JsonKey(name: 'in_production')
  bool get inProduction;
  @override
  String? get type;

  /// Create a copy of TMDBTVShowDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TMDBTVShowDetailImplCopyWith<_$TMDBTVShowDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TMDBSeason _$TMDBSeasonFromJson(Map<String, dynamic> json) {
  return _TMDBSeason.fromJson(json);
}

/// @nodoc
mixin _$TMDBSeason {
  int get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get overview => throw _privateConstructorUsedError;
  @JsonKey(name: 'poster_path')
  String? get posterPath => throw _privateConstructorUsedError;
  @JsonKey(name: 'season_number')
  int get seasonNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'episode_count')
  int get episodeCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'air_date')
  String? get airDate => throw _privateConstructorUsedError;

  /// Serializes this TMDBSeason to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TMDBSeason
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TMDBSeasonCopyWith<TMDBSeason> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TMDBSeasonCopyWith<$Res> {
  factory $TMDBSeasonCopyWith(
          TMDBSeason value, $Res Function(TMDBSeason) then) =
      _$TMDBSeasonCopyWithImpl<$Res, TMDBSeason>;
  @useResult
  $Res call(
      {int id,
      String? name,
      String? overview,
      @JsonKey(name: 'poster_path') String? posterPath,
      @JsonKey(name: 'season_number') int seasonNumber,
      @JsonKey(name: 'episode_count') int episodeCount,
      @JsonKey(name: 'air_date') String? airDate});
}

/// @nodoc
class _$TMDBSeasonCopyWithImpl<$Res, $Val extends TMDBSeason>
    implements $TMDBSeasonCopyWith<$Res> {
  _$TMDBSeasonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TMDBSeason
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? overview = freezed,
    Object? posterPath = freezed,
    Object? seasonNumber = null,
    Object? episodeCount = null,
    Object? airDate = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      posterPath: freezed == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      seasonNumber: null == seasonNumber
          ? _value.seasonNumber
          : seasonNumber // ignore: cast_nullable_to_non_nullable
              as int,
      episodeCount: null == episodeCount
          ? _value.episodeCount
          : episodeCount // ignore: cast_nullable_to_non_nullable
              as int,
      airDate: freezed == airDate
          ? _value.airDate
          : airDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TMDBSeasonImplCopyWith<$Res>
    implements $TMDBSeasonCopyWith<$Res> {
  factory _$$TMDBSeasonImplCopyWith(
          _$TMDBSeasonImpl value, $Res Function(_$TMDBSeasonImpl) then) =
      __$$TMDBSeasonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String? name,
      String? overview,
      @JsonKey(name: 'poster_path') String? posterPath,
      @JsonKey(name: 'season_number') int seasonNumber,
      @JsonKey(name: 'episode_count') int episodeCount,
      @JsonKey(name: 'air_date') String? airDate});
}

/// @nodoc
class __$$TMDBSeasonImplCopyWithImpl<$Res>
    extends _$TMDBSeasonCopyWithImpl<$Res, _$TMDBSeasonImpl>
    implements _$$TMDBSeasonImplCopyWith<$Res> {
  __$$TMDBSeasonImplCopyWithImpl(
      _$TMDBSeasonImpl _value, $Res Function(_$TMDBSeasonImpl) _then)
      : super(_value, _then);

  /// Create a copy of TMDBSeason
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? overview = freezed,
    Object? posterPath = freezed,
    Object? seasonNumber = null,
    Object? episodeCount = null,
    Object? airDate = freezed,
  }) {
    return _then(_$TMDBSeasonImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      posterPath: freezed == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      seasonNumber: null == seasonNumber
          ? _value.seasonNumber
          : seasonNumber // ignore: cast_nullable_to_non_nullable
              as int,
      episodeCount: null == episodeCount
          ? _value.episodeCount
          : episodeCount // ignore: cast_nullable_to_non_nullable
              as int,
      airDate: freezed == airDate
          ? _value.airDate
          : airDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TMDBSeasonImpl implements _TMDBSeason {
  const _$TMDBSeasonImpl(
      {required this.id,
      this.name,
      this.overview,
      @JsonKey(name: 'poster_path') this.posterPath,
      @JsonKey(name: 'season_number') required this.seasonNumber,
      @JsonKey(name: 'episode_count') this.episodeCount = 0,
      @JsonKey(name: 'air_date') this.airDate});

  factory _$TMDBSeasonImpl.fromJson(Map<String, dynamic> json) =>
      _$$TMDBSeasonImplFromJson(json);

  @override
  final int id;
  @override
  final String? name;
  @override
  final String? overview;
  @override
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @override
  @JsonKey(name: 'season_number')
  final int seasonNumber;
  @override
  @JsonKey(name: 'episode_count')
  final int episodeCount;
  @override
  @JsonKey(name: 'air_date')
  final String? airDate;

  @override
  String toString() {
    return 'TMDBSeason(id: $id, name: $name, overview: $overview, posterPath: $posterPath, seasonNumber: $seasonNumber, episodeCount: $episodeCount, airDate: $airDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TMDBSeasonImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            (identical(other.posterPath, posterPath) ||
                other.posterPath == posterPath) &&
            (identical(other.seasonNumber, seasonNumber) ||
                other.seasonNumber == seasonNumber) &&
            (identical(other.episodeCount, episodeCount) ||
                other.episodeCount == episodeCount) &&
            (identical(other.airDate, airDate) || other.airDate == airDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, overview, posterPath,
      seasonNumber, episodeCount, airDate);

  /// Create a copy of TMDBSeason
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TMDBSeasonImplCopyWith<_$TMDBSeasonImpl> get copyWith =>
      __$$TMDBSeasonImplCopyWithImpl<_$TMDBSeasonImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TMDBSeasonImplToJson(
      this,
    );
  }
}

abstract class _TMDBSeason implements TMDBSeason {
  const factory _TMDBSeason(
      {required final int id,
      final String? name,
      final String? overview,
      @JsonKey(name: 'poster_path') final String? posterPath,
      @JsonKey(name: 'season_number') required final int seasonNumber,
      @JsonKey(name: 'episode_count') final int episodeCount,
      @JsonKey(name: 'air_date') final String? airDate}) = _$TMDBSeasonImpl;

  factory _TMDBSeason.fromJson(Map<String, dynamic> json) =
      _$TMDBSeasonImpl.fromJson;

  @override
  int get id;
  @override
  String? get name;
  @override
  String? get overview;
  @override
  @JsonKey(name: 'poster_path')
  String? get posterPath;
  @override
  @JsonKey(name: 'season_number')
  int get seasonNumber;
  @override
  @JsonKey(name: 'episode_count')
  int get episodeCount;
  @override
  @JsonKey(name: 'air_date')
  String? get airDate;

  /// Create a copy of TMDBSeason
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TMDBSeasonImplCopyWith<_$TMDBSeasonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TMDBEpisode _$TMDBEpisodeFromJson(Map<String, dynamic> json) {
  return _TMDBEpisode.fromJson(json);
}

/// @nodoc
mixin _$TMDBEpisode {
  int get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get overview => throw _privateConstructorUsedError;
  @JsonKey(name: 'still_path')
  String? get stillPath => throw _privateConstructorUsedError;
  @JsonKey(name: 'episode_number')
  int get episodeNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'season_number')
  int get seasonNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'air_date')
  String? get airDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'vote_average')
  double get voteAverage => throw _privateConstructorUsedError;
  @JsonKey(name: 'vote_count')
  int get voteCount => throw _privateConstructorUsedError;
  int? get runtime => throw _privateConstructorUsedError;

  /// Serializes this TMDBEpisode to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TMDBEpisode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TMDBEpisodeCopyWith<TMDBEpisode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TMDBEpisodeCopyWith<$Res> {
  factory $TMDBEpisodeCopyWith(
          TMDBEpisode value, $Res Function(TMDBEpisode) then) =
      _$TMDBEpisodeCopyWithImpl<$Res, TMDBEpisode>;
  @useResult
  $Res call(
      {int id,
      String? name,
      String? overview,
      @JsonKey(name: 'still_path') String? stillPath,
      @JsonKey(name: 'episode_number') int episodeNumber,
      @JsonKey(name: 'season_number') int seasonNumber,
      @JsonKey(name: 'air_date') String? airDate,
      @JsonKey(name: 'vote_average') double voteAverage,
      @JsonKey(name: 'vote_count') int voteCount,
      int? runtime});
}

/// @nodoc
class _$TMDBEpisodeCopyWithImpl<$Res, $Val extends TMDBEpisode>
    implements $TMDBEpisodeCopyWith<$Res> {
  _$TMDBEpisodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TMDBEpisode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? overview = freezed,
    Object? stillPath = freezed,
    Object? episodeNumber = null,
    Object? seasonNumber = null,
    Object? airDate = freezed,
    Object? voteAverage = null,
    Object? voteCount = null,
    Object? runtime = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      stillPath: freezed == stillPath
          ? _value.stillPath
          : stillPath // ignore: cast_nullable_to_non_nullable
              as String?,
      episodeNumber: null == episodeNumber
          ? _value.episodeNumber
          : episodeNumber // ignore: cast_nullable_to_non_nullable
              as int,
      seasonNumber: null == seasonNumber
          ? _value.seasonNumber
          : seasonNumber // ignore: cast_nullable_to_non_nullable
              as int,
      airDate: freezed == airDate
          ? _value.airDate
          : airDate // ignore: cast_nullable_to_non_nullable
              as String?,
      voteAverage: null == voteAverage
          ? _value.voteAverage
          : voteAverage // ignore: cast_nullable_to_non_nullable
              as double,
      voteCount: null == voteCount
          ? _value.voteCount
          : voteCount // ignore: cast_nullable_to_non_nullable
              as int,
      runtime: freezed == runtime
          ? _value.runtime
          : runtime // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TMDBEpisodeImplCopyWith<$Res>
    implements $TMDBEpisodeCopyWith<$Res> {
  factory _$$TMDBEpisodeImplCopyWith(
          _$TMDBEpisodeImpl value, $Res Function(_$TMDBEpisodeImpl) then) =
      __$$TMDBEpisodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String? name,
      String? overview,
      @JsonKey(name: 'still_path') String? stillPath,
      @JsonKey(name: 'episode_number') int episodeNumber,
      @JsonKey(name: 'season_number') int seasonNumber,
      @JsonKey(name: 'air_date') String? airDate,
      @JsonKey(name: 'vote_average') double voteAverage,
      @JsonKey(name: 'vote_count') int voteCount,
      int? runtime});
}

/// @nodoc
class __$$TMDBEpisodeImplCopyWithImpl<$Res>
    extends _$TMDBEpisodeCopyWithImpl<$Res, _$TMDBEpisodeImpl>
    implements _$$TMDBEpisodeImplCopyWith<$Res> {
  __$$TMDBEpisodeImplCopyWithImpl(
      _$TMDBEpisodeImpl _value, $Res Function(_$TMDBEpisodeImpl) _then)
      : super(_value, _then);

  /// Create a copy of TMDBEpisode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? overview = freezed,
    Object? stillPath = freezed,
    Object? episodeNumber = null,
    Object? seasonNumber = null,
    Object? airDate = freezed,
    Object? voteAverage = null,
    Object? voteCount = null,
    Object? runtime = freezed,
  }) {
    return _then(_$TMDBEpisodeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      stillPath: freezed == stillPath
          ? _value.stillPath
          : stillPath // ignore: cast_nullable_to_non_nullable
              as String?,
      episodeNumber: null == episodeNumber
          ? _value.episodeNumber
          : episodeNumber // ignore: cast_nullable_to_non_nullable
              as int,
      seasonNumber: null == seasonNumber
          ? _value.seasonNumber
          : seasonNumber // ignore: cast_nullable_to_non_nullable
              as int,
      airDate: freezed == airDate
          ? _value.airDate
          : airDate // ignore: cast_nullable_to_non_nullable
              as String?,
      voteAverage: null == voteAverage
          ? _value.voteAverage
          : voteAverage // ignore: cast_nullable_to_non_nullable
              as double,
      voteCount: null == voteCount
          ? _value.voteCount
          : voteCount // ignore: cast_nullable_to_non_nullable
              as int,
      runtime: freezed == runtime
          ? _value.runtime
          : runtime // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TMDBEpisodeImpl implements _TMDBEpisode {
  const _$TMDBEpisodeImpl(
      {required this.id,
      this.name,
      this.overview,
      @JsonKey(name: 'still_path') this.stillPath,
      @JsonKey(name: 'episode_number') required this.episodeNumber,
      @JsonKey(name: 'season_number') required this.seasonNumber,
      @JsonKey(name: 'air_date') this.airDate,
      @JsonKey(name: 'vote_average') this.voteAverage = 0.0,
      @JsonKey(name: 'vote_count') this.voteCount = 0,
      this.runtime});

  factory _$TMDBEpisodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$TMDBEpisodeImplFromJson(json);

  @override
  final int id;
  @override
  final String? name;
  @override
  final String? overview;
  @override
  @JsonKey(name: 'still_path')
  final String? stillPath;
  @override
  @JsonKey(name: 'episode_number')
  final int episodeNumber;
  @override
  @JsonKey(name: 'season_number')
  final int seasonNumber;
  @override
  @JsonKey(name: 'air_date')
  final String? airDate;
  @override
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @override
  @JsonKey(name: 'vote_count')
  final int voteCount;
  @override
  final int? runtime;

  @override
  String toString() {
    return 'TMDBEpisode(id: $id, name: $name, overview: $overview, stillPath: $stillPath, episodeNumber: $episodeNumber, seasonNumber: $seasonNumber, airDate: $airDate, voteAverage: $voteAverage, voteCount: $voteCount, runtime: $runtime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TMDBEpisodeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            (identical(other.stillPath, stillPath) ||
                other.stillPath == stillPath) &&
            (identical(other.episodeNumber, episodeNumber) ||
                other.episodeNumber == episodeNumber) &&
            (identical(other.seasonNumber, seasonNumber) ||
                other.seasonNumber == seasonNumber) &&
            (identical(other.airDate, airDate) || other.airDate == airDate) &&
            (identical(other.voteAverage, voteAverage) ||
                other.voteAverage == voteAverage) &&
            (identical(other.voteCount, voteCount) ||
                other.voteCount == voteCount) &&
            (identical(other.runtime, runtime) || other.runtime == runtime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, overview, stillPath,
      episodeNumber, seasonNumber, airDate, voteAverage, voteCount, runtime);

  /// Create a copy of TMDBEpisode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TMDBEpisodeImplCopyWith<_$TMDBEpisodeImpl> get copyWith =>
      __$$TMDBEpisodeImplCopyWithImpl<_$TMDBEpisodeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TMDBEpisodeImplToJson(
      this,
    );
  }
}

abstract class _TMDBEpisode implements TMDBEpisode {
  const factory _TMDBEpisode(
      {required final int id,
      final String? name,
      final String? overview,
      @JsonKey(name: 'still_path') final String? stillPath,
      @JsonKey(name: 'episode_number') required final int episodeNumber,
      @JsonKey(name: 'season_number') required final int seasonNumber,
      @JsonKey(name: 'air_date') final String? airDate,
      @JsonKey(name: 'vote_average') final double voteAverage,
      @JsonKey(name: 'vote_count') final int voteCount,
      final int? runtime}) = _$TMDBEpisodeImpl;

  factory _TMDBEpisode.fromJson(Map<String, dynamic> json) =
      _$TMDBEpisodeImpl.fromJson;

  @override
  int get id;
  @override
  String? get name;
  @override
  String? get overview;
  @override
  @JsonKey(name: 'still_path')
  String? get stillPath;
  @override
  @JsonKey(name: 'episode_number')
  int get episodeNumber;
  @override
  @JsonKey(name: 'season_number')
  int get seasonNumber;
  @override
  @JsonKey(name: 'air_date')
  String? get airDate;
  @override
  @JsonKey(name: 'vote_average')
  double get voteAverage;
  @override
  @JsonKey(name: 'vote_count')
  int get voteCount;
  @override
  int? get runtime;

  /// Create a copy of TMDBEpisode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TMDBEpisodeImplCopyWith<_$TMDBEpisodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TMDBSeasonDetail _$TMDBSeasonDetailFromJson(Map<String, dynamic> json) {
  return _TMDBSeasonDetail.fromJson(json);
}

/// @nodoc
mixin _$TMDBSeasonDetail {
  int get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get overview => throw _privateConstructorUsedError;
  @JsonKey(name: 'poster_path')
  String? get posterPath => throw _privateConstructorUsedError;
  @JsonKey(name: 'season_number')
  int get seasonNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'air_date')
  String? get airDate => throw _privateConstructorUsedError;
  List<TMDBEpisode> get episodes => throw _privateConstructorUsedError;

  /// Serializes this TMDBSeasonDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TMDBSeasonDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TMDBSeasonDetailCopyWith<TMDBSeasonDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TMDBSeasonDetailCopyWith<$Res> {
  factory $TMDBSeasonDetailCopyWith(
          TMDBSeasonDetail value, $Res Function(TMDBSeasonDetail) then) =
      _$TMDBSeasonDetailCopyWithImpl<$Res, TMDBSeasonDetail>;
  @useResult
  $Res call(
      {int id,
      String? name,
      String? overview,
      @JsonKey(name: 'poster_path') String? posterPath,
      @JsonKey(name: 'season_number') int seasonNumber,
      @JsonKey(name: 'air_date') String? airDate,
      List<TMDBEpisode> episodes});
}

/// @nodoc
class _$TMDBSeasonDetailCopyWithImpl<$Res, $Val extends TMDBSeasonDetail>
    implements $TMDBSeasonDetailCopyWith<$Res> {
  _$TMDBSeasonDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TMDBSeasonDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? overview = freezed,
    Object? posterPath = freezed,
    Object? seasonNumber = null,
    Object? airDate = freezed,
    Object? episodes = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      posterPath: freezed == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      seasonNumber: null == seasonNumber
          ? _value.seasonNumber
          : seasonNumber // ignore: cast_nullable_to_non_nullable
              as int,
      airDate: freezed == airDate
          ? _value.airDate
          : airDate // ignore: cast_nullable_to_non_nullable
              as String?,
      episodes: null == episodes
          ? _value.episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as List<TMDBEpisode>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TMDBSeasonDetailImplCopyWith<$Res>
    implements $TMDBSeasonDetailCopyWith<$Res> {
  factory _$$TMDBSeasonDetailImplCopyWith(_$TMDBSeasonDetailImpl value,
          $Res Function(_$TMDBSeasonDetailImpl) then) =
      __$$TMDBSeasonDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String? name,
      String? overview,
      @JsonKey(name: 'poster_path') String? posterPath,
      @JsonKey(name: 'season_number') int seasonNumber,
      @JsonKey(name: 'air_date') String? airDate,
      List<TMDBEpisode> episodes});
}

/// @nodoc
class __$$TMDBSeasonDetailImplCopyWithImpl<$Res>
    extends _$TMDBSeasonDetailCopyWithImpl<$Res, _$TMDBSeasonDetailImpl>
    implements _$$TMDBSeasonDetailImplCopyWith<$Res> {
  __$$TMDBSeasonDetailImplCopyWithImpl(_$TMDBSeasonDetailImpl _value,
      $Res Function(_$TMDBSeasonDetailImpl) _then)
      : super(_value, _then);

  /// Create a copy of TMDBSeasonDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? overview = freezed,
    Object? posterPath = freezed,
    Object? seasonNumber = null,
    Object? airDate = freezed,
    Object? episodes = null,
  }) {
    return _then(_$TMDBSeasonDetailImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      posterPath: freezed == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      seasonNumber: null == seasonNumber
          ? _value.seasonNumber
          : seasonNumber // ignore: cast_nullable_to_non_nullable
              as int,
      airDate: freezed == airDate
          ? _value.airDate
          : airDate // ignore: cast_nullable_to_non_nullable
              as String?,
      episodes: null == episodes
          ? _value._episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as List<TMDBEpisode>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TMDBSeasonDetailImpl implements _TMDBSeasonDetail {
  const _$TMDBSeasonDetailImpl(
      {required this.id,
      this.name,
      this.overview,
      @JsonKey(name: 'poster_path') this.posterPath,
      @JsonKey(name: 'season_number') required this.seasonNumber,
      @JsonKey(name: 'air_date') this.airDate,
      final List<TMDBEpisode> episodes = const []})
      : _episodes = episodes;

  factory _$TMDBSeasonDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$TMDBSeasonDetailImplFromJson(json);

  @override
  final int id;
  @override
  final String? name;
  @override
  final String? overview;
  @override
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @override
  @JsonKey(name: 'season_number')
  final int seasonNumber;
  @override
  @JsonKey(name: 'air_date')
  final String? airDate;
  final List<TMDBEpisode> _episodes;
  @override
  @JsonKey()
  List<TMDBEpisode> get episodes {
    if (_episodes is EqualUnmodifiableListView) return _episodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_episodes);
  }

  @override
  String toString() {
    return 'TMDBSeasonDetail(id: $id, name: $name, overview: $overview, posterPath: $posterPath, seasonNumber: $seasonNumber, airDate: $airDate, episodes: $episodes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TMDBSeasonDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            (identical(other.posterPath, posterPath) ||
                other.posterPath == posterPath) &&
            (identical(other.seasonNumber, seasonNumber) ||
                other.seasonNumber == seasonNumber) &&
            (identical(other.airDate, airDate) || other.airDate == airDate) &&
            const DeepCollectionEquality().equals(other._episodes, _episodes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, overview, posterPath,
      seasonNumber, airDate, const DeepCollectionEquality().hash(_episodes));

  /// Create a copy of TMDBSeasonDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TMDBSeasonDetailImplCopyWith<_$TMDBSeasonDetailImpl> get copyWith =>
      __$$TMDBSeasonDetailImplCopyWithImpl<_$TMDBSeasonDetailImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TMDBSeasonDetailImplToJson(
      this,
    );
  }
}

abstract class _TMDBSeasonDetail implements TMDBSeasonDetail {
  const factory _TMDBSeasonDetail(
      {required final int id,
      final String? name,
      final String? overview,
      @JsonKey(name: 'poster_path') final String? posterPath,
      @JsonKey(name: 'season_number') required final int seasonNumber,
      @JsonKey(name: 'air_date') final String? airDate,
      final List<TMDBEpisode> episodes}) = _$TMDBSeasonDetailImpl;

  factory _TMDBSeasonDetail.fromJson(Map<String, dynamic> json) =
      _$TMDBSeasonDetailImpl.fromJson;

  @override
  int get id;
  @override
  String? get name;
  @override
  String? get overview;
  @override
  @JsonKey(name: 'poster_path')
  String? get posterPath;
  @override
  @JsonKey(name: 'season_number')
  int get seasonNumber;
  @override
  @JsonKey(name: 'air_date')
  String? get airDate;
  @override
  List<TMDBEpisode> get episodes;

  /// Create a copy of TMDBSeasonDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TMDBSeasonDetailImplCopyWith<_$TMDBSeasonDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TMDBConfiguration _$TMDBConfigurationFromJson(Map<String, dynamic> json) {
  return _TMDBConfiguration.fromJson(json);
}

/// @nodoc
mixin _$TMDBConfiguration {
  TMDBImages? get images => throw _privateConstructorUsedError;

  /// Serializes this TMDBConfiguration to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TMDBConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TMDBConfigurationCopyWith<TMDBConfiguration> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TMDBConfigurationCopyWith<$Res> {
  factory $TMDBConfigurationCopyWith(
          TMDBConfiguration value, $Res Function(TMDBConfiguration) then) =
      _$TMDBConfigurationCopyWithImpl<$Res, TMDBConfiguration>;
  @useResult
  $Res call({TMDBImages? images});

  $TMDBImagesCopyWith<$Res>? get images;
}

/// @nodoc
class _$TMDBConfigurationCopyWithImpl<$Res, $Val extends TMDBConfiguration>
    implements $TMDBConfigurationCopyWith<$Res> {
  _$TMDBConfigurationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TMDBConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? images = freezed,
  }) {
    return _then(_value.copyWith(
      images: freezed == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as TMDBImages?,
    ) as $Val);
  }

  /// Create a copy of TMDBConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TMDBImagesCopyWith<$Res>? get images {
    if (_value.images == null) {
      return null;
    }

    return $TMDBImagesCopyWith<$Res>(_value.images!, (value) {
      return _then(_value.copyWith(images: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TMDBConfigurationImplCopyWith<$Res>
    implements $TMDBConfigurationCopyWith<$Res> {
  factory _$$TMDBConfigurationImplCopyWith(_$TMDBConfigurationImpl value,
          $Res Function(_$TMDBConfigurationImpl) then) =
      __$$TMDBConfigurationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TMDBImages? images});

  @override
  $TMDBImagesCopyWith<$Res>? get images;
}

/// @nodoc
class __$$TMDBConfigurationImplCopyWithImpl<$Res>
    extends _$TMDBConfigurationCopyWithImpl<$Res, _$TMDBConfigurationImpl>
    implements _$$TMDBConfigurationImplCopyWith<$Res> {
  __$$TMDBConfigurationImplCopyWithImpl(_$TMDBConfigurationImpl _value,
      $Res Function(_$TMDBConfigurationImpl) _then)
      : super(_value, _then);

  /// Create a copy of TMDBConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? images = freezed,
  }) {
    return _then(_$TMDBConfigurationImpl(
      images: freezed == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as TMDBImages?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TMDBConfigurationImpl implements _TMDBConfiguration {
  const _$TMDBConfigurationImpl({this.images});

  factory _$TMDBConfigurationImpl.fromJson(Map<String, dynamic> json) =>
      _$$TMDBConfigurationImplFromJson(json);

  @override
  final TMDBImages? images;

  @override
  String toString() {
    return 'TMDBConfiguration(images: $images)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TMDBConfigurationImpl &&
            (identical(other.images, images) || other.images == images));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, images);

  /// Create a copy of TMDBConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TMDBConfigurationImplCopyWith<_$TMDBConfigurationImpl> get copyWith =>
      __$$TMDBConfigurationImplCopyWithImpl<_$TMDBConfigurationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TMDBConfigurationImplToJson(
      this,
    );
  }
}

abstract class _TMDBConfiguration implements TMDBConfiguration {
  const factory _TMDBConfiguration({final TMDBImages? images}) =
      _$TMDBConfigurationImpl;

  factory _TMDBConfiguration.fromJson(Map<String, dynamic> json) =
      _$TMDBConfigurationImpl.fromJson;

  @override
  TMDBImages? get images;

  /// Create a copy of TMDBConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TMDBConfigurationImplCopyWith<_$TMDBConfigurationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TMDBImages _$TMDBImagesFromJson(Map<String, dynamic> json) {
  return _TMDBImages.fromJson(json);
}

/// @nodoc
mixin _$TMDBImages {
  String? get baseUrl => throw _privateConstructorUsedError;
  String? get secureBaseUrl => throw _privateConstructorUsedError;
  List<String> get backdropSizes => throw _privateConstructorUsedError;
  List<String> get logoSizes => throw _privateConstructorUsedError;
  List<String> get posterSizes => throw _privateConstructorUsedError;
  List<String> get profileSizes => throw _privateConstructorUsedError;
  List<String> get stillSizes => throw _privateConstructorUsedError;

  /// Serializes this TMDBImages to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TMDBImages
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TMDBImagesCopyWith<TMDBImages> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TMDBImagesCopyWith<$Res> {
  factory $TMDBImagesCopyWith(
          TMDBImages value, $Res Function(TMDBImages) then) =
      _$TMDBImagesCopyWithImpl<$Res, TMDBImages>;
  @useResult
  $Res call(
      {String? baseUrl,
      String? secureBaseUrl,
      List<String> backdropSizes,
      List<String> logoSizes,
      List<String> posterSizes,
      List<String> profileSizes,
      List<String> stillSizes});
}

/// @nodoc
class _$TMDBImagesCopyWithImpl<$Res, $Val extends TMDBImages>
    implements $TMDBImagesCopyWith<$Res> {
  _$TMDBImagesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TMDBImages
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? baseUrl = freezed,
    Object? secureBaseUrl = freezed,
    Object? backdropSizes = null,
    Object? logoSizes = null,
    Object? posterSizes = null,
    Object? profileSizes = null,
    Object? stillSizes = null,
  }) {
    return _then(_value.copyWith(
      baseUrl: freezed == baseUrl
          ? _value.baseUrl
          : baseUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      secureBaseUrl: freezed == secureBaseUrl
          ? _value.secureBaseUrl
          : secureBaseUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      backdropSizes: null == backdropSizes
          ? _value.backdropSizes
          : backdropSizes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      logoSizes: null == logoSizes
          ? _value.logoSizes
          : logoSizes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      posterSizes: null == posterSizes
          ? _value.posterSizes
          : posterSizes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      profileSizes: null == profileSizes
          ? _value.profileSizes
          : profileSizes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      stillSizes: null == stillSizes
          ? _value.stillSizes
          : stillSizes // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TMDBImagesImplCopyWith<$Res>
    implements $TMDBImagesCopyWith<$Res> {
  factory _$$TMDBImagesImplCopyWith(
          _$TMDBImagesImpl value, $Res Function(_$TMDBImagesImpl) then) =
      __$$TMDBImagesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? baseUrl,
      String? secureBaseUrl,
      List<String> backdropSizes,
      List<String> logoSizes,
      List<String> posterSizes,
      List<String> profileSizes,
      List<String> stillSizes});
}

/// @nodoc
class __$$TMDBImagesImplCopyWithImpl<$Res>
    extends _$TMDBImagesCopyWithImpl<$Res, _$TMDBImagesImpl>
    implements _$$TMDBImagesImplCopyWith<$Res> {
  __$$TMDBImagesImplCopyWithImpl(
      _$TMDBImagesImpl _value, $Res Function(_$TMDBImagesImpl) _then)
      : super(_value, _then);

  /// Create a copy of TMDBImages
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? baseUrl = freezed,
    Object? secureBaseUrl = freezed,
    Object? backdropSizes = null,
    Object? logoSizes = null,
    Object? posterSizes = null,
    Object? profileSizes = null,
    Object? stillSizes = null,
  }) {
    return _then(_$TMDBImagesImpl(
      baseUrl: freezed == baseUrl
          ? _value.baseUrl
          : baseUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      secureBaseUrl: freezed == secureBaseUrl
          ? _value.secureBaseUrl
          : secureBaseUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      backdropSizes: null == backdropSizes
          ? _value._backdropSizes
          : backdropSizes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      logoSizes: null == logoSizes
          ? _value._logoSizes
          : logoSizes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      posterSizes: null == posterSizes
          ? _value._posterSizes
          : posterSizes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      profileSizes: null == profileSizes
          ? _value._profileSizes
          : profileSizes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      stillSizes: null == stillSizes
          ? _value._stillSizes
          : stillSizes // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TMDBImagesImpl implements _TMDBImages {
  const _$TMDBImagesImpl(
      {this.baseUrl,
      this.secureBaseUrl,
      final List<String> backdropSizes = const [],
      final List<String> logoSizes = const [],
      final List<String> posterSizes = const [],
      final List<String> profileSizes = const [],
      final List<String> stillSizes = const []})
      : _backdropSizes = backdropSizes,
        _logoSizes = logoSizes,
        _posterSizes = posterSizes,
        _profileSizes = profileSizes,
        _stillSizes = stillSizes;

  factory _$TMDBImagesImpl.fromJson(Map<String, dynamic> json) =>
      _$$TMDBImagesImplFromJson(json);

  @override
  final String? baseUrl;
  @override
  final String? secureBaseUrl;
  final List<String> _backdropSizes;
  @override
  @JsonKey()
  List<String> get backdropSizes {
    if (_backdropSizes is EqualUnmodifiableListView) return _backdropSizes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_backdropSizes);
  }

  final List<String> _logoSizes;
  @override
  @JsonKey()
  List<String> get logoSizes {
    if (_logoSizes is EqualUnmodifiableListView) return _logoSizes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_logoSizes);
  }

  final List<String> _posterSizes;
  @override
  @JsonKey()
  List<String> get posterSizes {
    if (_posterSizes is EqualUnmodifiableListView) return _posterSizes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_posterSizes);
  }

  final List<String> _profileSizes;
  @override
  @JsonKey()
  List<String> get profileSizes {
    if (_profileSizes is EqualUnmodifiableListView) return _profileSizes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_profileSizes);
  }

  final List<String> _stillSizes;
  @override
  @JsonKey()
  List<String> get stillSizes {
    if (_stillSizes is EqualUnmodifiableListView) return _stillSizes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stillSizes);
  }

  @override
  String toString() {
    return 'TMDBImages(baseUrl: $baseUrl, secureBaseUrl: $secureBaseUrl, backdropSizes: $backdropSizes, logoSizes: $logoSizes, posterSizes: $posterSizes, profileSizes: $profileSizes, stillSizes: $stillSizes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TMDBImagesImpl &&
            (identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl) &&
            (identical(other.secureBaseUrl, secureBaseUrl) ||
                other.secureBaseUrl == secureBaseUrl) &&
            const DeepCollectionEquality()
                .equals(other._backdropSizes, _backdropSizes) &&
            const DeepCollectionEquality()
                .equals(other._logoSizes, _logoSizes) &&
            const DeepCollectionEquality()
                .equals(other._posterSizes, _posterSizes) &&
            const DeepCollectionEquality()
                .equals(other._profileSizes, _profileSizes) &&
            const DeepCollectionEquality()
                .equals(other._stillSizes, _stillSizes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      baseUrl,
      secureBaseUrl,
      const DeepCollectionEquality().hash(_backdropSizes),
      const DeepCollectionEquality().hash(_logoSizes),
      const DeepCollectionEquality().hash(_posterSizes),
      const DeepCollectionEquality().hash(_profileSizes),
      const DeepCollectionEquality().hash(_stillSizes));

  /// Create a copy of TMDBImages
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TMDBImagesImplCopyWith<_$TMDBImagesImpl> get copyWith =>
      __$$TMDBImagesImplCopyWithImpl<_$TMDBImagesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TMDBImagesImplToJson(
      this,
    );
  }
}

abstract class _TMDBImages implements TMDBImages {
  const factory _TMDBImages(
      {final String? baseUrl,
      final String? secureBaseUrl,
      final List<String> backdropSizes,
      final List<String> logoSizes,
      final List<String> posterSizes,
      final List<String> profileSizes,
      final List<String> stillSizes}) = _$TMDBImagesImpl;

  factory _TMDBImages.fromJson(Map<String, dynamic> json) =
      _$TMDBImagesImpl.fromJson;

  @override
  String? get baseUrl;
  @override
  String? get secureBaseUrl;
  @override
  List<String> get backdropSizes;
  @override
  List<String> get logoSizes;
  @override
  List<String> get posterSizes;
  @override
  List<String> get profileSizes;
  @override
  List<String> get stillSizes;

  /// Create a copy of TMDBImages
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TMDBImagesImplCopyWith<_$TMDBImagesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
