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