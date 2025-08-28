import 'package:freezed_annotation/freezed_annotation.dart';
import 'tmdb_models.dart';

part 'library_models.freezed.dart';
part 'library_models.g.dart';

@freezed
class FavoriteItem with _$FavoriteItem {
  const factory FavoriteItem({
    required String id,
    required String title,
    required String type, // 'movie' or 'tv'
    String? posterPath,
    String? overview,
    @Default(0.0) double rating,
    required DateTime addedAt,
    Map<String, dynamic>? tmdbData,
  }) = _FavoriteItem;

  factory FavoriteItem.fromJson(Map<String, dynamic> json) =>
      _$FavoriteItemFromJson(json);

  factory FavoriteItem.fromTMDBMovie(TMDBMovie movie) {
    return FavoriteItem(
      id: movie.id.toString(),
      title: movie.title,
      type: 'movie',
      posterPath: movie.posterPath,
      overview: movie.overview,
      rating: movie.voteAverage,
      addedAt: DateTime.now(),
      tmdbData: {
        'id': movie.id,
        'title': movie.title,
        'original_title': movie.originalTitle,
        'overview': movie.overview,
        'poster_path': movie.posterPath,
        'backdrop_path': movie.backdropPath,
        'release_date': movie.releaseDate,
        'vote_average': movie.voteAverage,
        'vote_count': movie.voteCount,
        'genre_ids': movie.genreIds,
        'adult': movie.adult,
        'popularity': movie.popularity,
      },
    );
  }

  factory FavoriteItem.fromTMDBTVShow(TMDBTVShow tvShow) {
    return FavoriteItem(
      id: tvShow.id.toString(),
      title: tvShow.name,
      type: 'tv',
      posterPath: tvShow.posterPath,
      overview: tvShow.overview,
      rating: tvShow.voteAverage,
      addedAt: DateTime.now(),
      tmdbData: {
        'id': tvShow.id,
        'name': tvShow.name,
        'original_name': tvShow.originalName,
        'overview': tvShow.overview,
        'poster_path': tvShow.posterPath,
        'backdrop_path': tvShow.backdropPath,
        'first_air_date': tvShow.firstAirDate,
        'vote_average': tvShow.voteAverage,
        'vote_count': tvShow.voteCount,
        'genre_ids': tvShow.genreIds,
        'origin_country': tvShow.originCountry,
      },
    );
  }

  factory FavoriteItem.fromTMDBMovieDetail(TMDBMovieDetail movieDetail) {
    return FavoriteItem(
      id: movieDetail.id.toString(),
      title: movieDetail.title,
      type: 'movie',
      posterPath: movieDetail.posterPath,
      overview: movieDetail.overview,
      rating: movieDetail.voteAverage,
      addedAt: DateTime.now(),
      tmdbData: {
        'id': movieDetail.id,
        'title': movieDetail.title,
        'original_title': movieDetail.originalTitle,
        'overview': movieDetail.overview,
        'poster_path': movieDetail.posterPath,
        'backdrop_path': movieDetail.backdropPath,
        'release_date': movieDetail.releaseDate,
        'vote_average': movieDetail.voteAverage,
        'vote_count': movieDetail.voteCount,
        'genre_ids': movieDetail.genres?.map((g) => g.id).toList() ?? [],
        'adult': movieDetail.adult,
        'popularity': movieDetail.popularity,
        'runtime': movieDetail.runtime,
      },
    );
  }

  factory FavoriteItem.fromTMDBTVShowDetail(TMDBTVShowDetail tvShowDetail) {
    return FavoriteItem(
      id: tvShowDetail.id.toString(),
      title: tvShowDetail.name,
      type: 'tv',
      posterPath: tvShowDetail.posterPath,
      overview: tvShowDetail.overview,
      rating: tvShowDetail.voteAverage,
      addedAt: DateTime.now(),
      tmdbData: {
        'id': tvShowDetail.id,
        'name': tvShowDetail.name,
        'original_name': tvShowDetail.originalName,
        'overview': tvShowDetail.overview,
        'poster_path': tvShowDetail.posterPath,
        'backdrop_path': tvShowDetail.backdropPath,
        'first_air_date': tvShowDetail.firstAirDate,
        'last_air_date': tvShowDetail.lastAirDate,
        'vote_average': tvShowDetail.voteAverage,
        'vote_count': tvShowDetail.voteCount,
        'genre_ids': tvShowDetail.genres?.map((g) => g.id).toList() ?? [],
        'origin_country': tvShowDetail.originCountry,
        'number_of_episodes': tvShowDetail.numberOfEpisodes,
        'number_of_seasons': tvShowDetail.numberOfSeasons,
      },
    );
  }
}

@freezed
class WatchHistoryItem with _$WatchHistoryItem {
  const factory WatchHistoryItem({
    required String id,
    required String title,
    required String type,
    String? posterPath,
    required DateTime lastWatched,
    @Default(0) int progress, // Progress in seconds
    @Default(0) int duration, // Total duration in seconds
    String? episodeTitle,
    int? episodeNumber,
    int? seasonNumber,
    Map<String, dynamic>? metadata,
  }) = _WatchHistoryItem;

  factory WatchHistoryItem.fromJson(Map<String, dynamic> json) =>
      _$WatchHistoryItemFromJson(json);
}

@freezed
class Bookmark with _$Bookmark {
  const factory Bookmark({
    required String id,
    required String title,
    required String url,
    String? description,
    String? imageUrl,
    required DateTime createdAt,
    @Default([]) List<String> tags,
  }) = _Bookmark;

  factory Bookmark.fromJson(Map<String, dynamic> json) =>
      _$BookmarkFromJson(json);
}