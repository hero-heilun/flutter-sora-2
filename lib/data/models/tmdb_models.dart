import 'package:freezed_annotation/freezed_annotation.dart';

part 'tmdb_models.freezed.dart';
part 'tmdb_models.g.dart';

@freezed
class TMDBMovie with _$TMDBMovie {
  const factory TMDBMovie({
    required int id,
    required String title,
    @JsonKey(name: 'original_title') String? originalTitle,
    String? overview,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    @JsonKey(name: 'release_date') String? releaseDate,
    @JsonKey(name: 'vote_average') @Default(0.0) double voteAverage,
    @JsonKey(name: 'vote_count') @Default(0) int voteCount,
    @JsonKey(name: 'genre_ids') @Default([]) List<int> genreIds,
    @Default(false) bool adult,
    @Default(0.0) double popularity,
  }) = _TMDBMovie;

  factory TMDBMovie.fromJson(Map<String, dynamic> json) =>
      _$TMDBMovieFromJson(json);
}

@freezed
class TMDBTVShow with _$TMDBTVShow {
  const factory TMDBTVShow({
    required int id,
    required String name,
    @JsonKey(name: 'original_name') String? originalName,
    String? overview,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    @JsonKey(name: 'first_air_date') String? firstAirDate,
    @JsonKey(name: 'vote_average') @Default(0.0) double voteAverage,
    @JsonKey(name: 'vote_count') @Default(0) int voteCount,
    @JsonKey(name: 'genre_ids') @Default([]) List<int> genreIds,
    @JsonKey(name: 'origin_country') @Default([]) List<String> originCountry,
  }) = _TMDBTVShow;

  factory TMDBTVShow.fromJson(Map<String, dynamic> json) =>
      _$TMDBTVShowFromJson(json);
}

@freezed
class TMDBPerson with _$TMDBPerson {
  const factory TMDBPerson({
    required int id,
    required String name,
    String? profilePath,
    @Default(false) bool adult,
    String? knownForDepartment,
    @Default([]) List<Map<String, dynamic>> knownFor,
  }) = _TMDBPerson;

  factory TMDBPerson.fromJson(Map<String, dynamic> json) =>
      _$TMDBPersonFromJson(json);
}

@freezed
class TMDBSearchResult with _$TMDBSearchResult {
  const factory TMDBSearchResult({
    @Default(1) int page,
    @Default(0) int totalResults,
    @Default(0) int totalPages,
    @Default([]) List<TMDBMovie> movies,
    @Default([]) List<TMDBTVShow> tvShows,
    @Default([]) List<TMDBPerson> people,
  }) = _TMDBSearchResult;

  factory TMDBSearchResult.fromJson(Map<String, dynamic> json) =>
      _$TMDBSearchResultFromJson(json);
}

@freezed
class TMDBGenre with _$TMDBGenre {
  const factory TMDBGenre({
    required int id,
    required String name,
  }) = _TMDBGenre;

  factory TMDBGenre.fromJson(Map<String, dynamic> json) =>
      _$TMDBGenreFromJson(json);
}

@freezed
class TMDBMovieDetail with _$TMDBMovieDetail {
  const factory TMDBMovieDetail({
    required int id,
    required String title,
    @JsonKey(name: 'original_title') String? originalTitle,
    String? overview,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    @JsonKey(name: 'release_date') String? releaseDate,
    @JsonKey(name: 'vote_average') @Default(0.0) double voteAverage,
    @JsonKey(name: 'vote_count') @Default(0) int voteCount,
    @Default([]) List<TMDBGenre> genres,
    @Default(false) bool adult,
    @Default(0.0) double popularity,
    int? runtime,
    String? tagline,
    String? status,
    int? budget,
    int? revenue,
    @JsonKey(name: 'imdb_id') String? imdbId,
    @JsonKey(name: 'original_language') String? originalLanguage,
  }) = _TMDBMovieDetail;

  factory TMDBMovieDetail.fromJson(Map<String, dynamic> json) =>
      _$TMDBMovieDetailFromJson(json);
}

@freezed
class TMDBTVShowDetail with _$TMDBTVShowDetail {
  const factory TMDBTVShowDetail({
    required int id,
    required String name,
    @JsonKey(name: 'original_name') String? originalName,
    String? overview,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    @JsonKey(name: 'first_air_date') String? firstAirDate,
    @JsonKey(name: 'last_air_date') String? lastAirDate,
    @JsonKey(name: 'vote_average') @Default(0.0) double voteAverage,
    @JsonKey(name: 'vote_count') @Default(0) int voteCount,
    @Default([]) List<TMDBGenre> genres,
    @JsonKey(name: 'origin_country') @Default([]) List<String> originCountry,
    @Default(0.0) double popularity,
    String? tagline,
    String? status,
    @JsonKey(name: 'original_language') String? originalLanguage,
    @JsonKey(name: 'number_of_seasons') int? numberOfSeasons,
    @JsonKey(name: 'number_of_episodes') int? numberOfEpisodes,
    @JsonKey(name: 'episode_run_time') @Default([]) List<int> episodeRunTime,
    @JsonKey(name: 'in_production') @Default(false) bool inProduction,
    String? type,
  }) = _TMDBTVShowDetail;

  factory TMDBTVShowDetail.fromJson(Map<String, dynamic> json) =>
      _$TMDBTVShowDetailFromJson(json);
}

@freezed
class TMDBSeason with _$TMDBSeason {
  const factory TMDBSeason({
    required int id,
    String? name,
    String? overview,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'season_number') required int seasonNumber,
    @JsonKey(name: 'episode_count') @Default(0) int episodeCount,
    @JsonKey(name: 'air_date') String? airDate,
  }) = _TMDBSeason;

  factory TMDBSeason.fromJson(Map<String, dynamic> json) =>
      _$TMDBSeasonFromJson(json);
}

@freezed
class TMDBEpisode with _$TMDBEpisode {
  const factory TMDBEpisode({
    required int id,
    String? name,
    String? overview,
    @JsonKey(name: 'still_path') String? stillPath,
    @JsonKey(name: 'episode_number') required int episodeNumber,
    @JsonKey(name: 'season_number') required int seasonNumber,
    @JsonKey(name: 'air_date') String? airDate,
    @JsonKey(name: 'vote_average') @Default(0.0) double voteAverage,
    @JsonKey(name: 'vote_count') @Default(0) int voteCount,
    int? runtime,
  }) = _TMDBEpisode;

  factory TMDBEpisode.fromJson(Map<String, dynamic> json) =>
      _$TMDBEpisodeFromJson(json);
}

@freezed
class TMDBSeasonDetail with _$TMDBSeasonDetail {
  const factory TMDBSeasonDetail({
    required int id,
    String? name,
    String? overview,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'season_number') required int seasonNumber,
    @JsonKey(name: 'air_date') String? airDate,
    @Default([]) List<TMDBEpisode> episodes,
  }) = _TMDBSeasonDetail;

  factory TMDBSeasonDetail.fromJson(Map<String, dynamic> json) =>
      _$TMDBSeasonDetailFromJson(json);
}

@freezed
class TMDBConfiguration with _$TMDBConfiguration {
  const factory TMDBConfiguration({
    TMDBImages? images,
  }) = _TMDBConfiguration;

  factory TMDBConfiguration.fromJson(Map<String, dynamic> json) =>
      _$TMDBConfigurationFromJson(json);
}

@freezed
class TMDBImages with _$TMDBImages {
  const factory TMDBImages({
    String? baseUrl,
    String? secureBaseUrl,
    @Default([]) List<String> backdropSizes,
    @Default([]) List<String> logoSizes,
    @Default([]) List<String> posterSizes,
    @Default([]) List<String> profileSizes,
    @Default([]) List<String> stillSizes,
  }) = _TMDBImages;

  factory TMDBImages.fromJson(Map<String, dynamic> json) =>
      _$TMDBImagesFromJson(json);
}