// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TMDBMovieImpl _$$TMDBMovieImplFromJson(Map<String, dynamic> json) =>
    _$TMDBMovieImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      originalTitle: json['original_title'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      releaseDate: json['release_date'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: (json['vote_count'] as num?)?.toInt() ?? 0,
      genreIds: (json['genre_ids'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      adult: json['adult'] as bool? ?? false,
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$TMDBMovieImplToJson(_$TMDBMovieImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'original_title': instance.originalTitle,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'backdrop_path': instance.backdropPath,
      'release_date': instance.releaseDate,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'genre_ids': instance.genreIds,
      'adult': instance.adult,
      'popularity': instance.popularity,
    };

_$TMDBTVShowImpl _$$TMDBTVShowImplFromJson(Map<String, dynamic> json) =>
    _$TMDBTVShowImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      originalName: json['original_name'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      firstAirDate: json['first_air_date'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: (json['vote_count'] as num?)?.toInt() ?? 0,
      genreIds: (json['genre_ids'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      originCountry: (json['origin_country'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$TMDBTVShowImplToJson(_$TMDBTVShowImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'original_name': instance.originalName,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'backdrop_path': instance.backdropPath,
      'first_air_date': instance.firstAirDate,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'genre_ids': instance.genreIds,
      'origin_country': instance.originCountry,
    };

_$TMDBPersonImpl _$$TMDBPersonImplFromJson(Map<String, dynamic> json) =>
    _$TMDBPersonImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      profilePath: json['profilePath'] as String?,
      adult: json['adult'] as bool? ?? false,
      knownForDepartment: json['knownForDepartment'] as String?,
      knownFor: (json['knownFor'] as List<dynamic>?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$TMDBPersonImplToJson(_$TMDBPersonImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profilePath': instance.profilePath,
      'adult': instance.adult,
      'knownForDepartment': instance.knownForDepartment,
      'knownFor': instance.knownFor,
    };

_$TMDBSearchResultImpl _$$TMDBSearchResultImplFromJson(
        Map<String, dynamic> json) =>
    _$TMDBSearchResultImpl(
      page: (json['page'] as num?)?.toInt() ?? 1,
      totalResults: (json['totalResults'] as num?)?.toInt() ?? 0,
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
      movies: (json['movies'] as List<dynamic>?)
              ?.map((e) => TMDBMovie.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      tvShows: (json['tvShows'] as List<dynamic>?)
              ?.map((e) => TMDBTVShow.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      people: (json['people'] as List<dynamic>?)
              ?.map((e) => TMDBPerson.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$TMDBSearchResultImplToJson(
        _$TMDBSearchResultImpl instance) =>
    <String, dynamic>{
      'page': instance.page,
      'totalResults': instance.totalResults,
      'totalPages': instance.totalPages,
      'movies': instance.movies,
      'tvShows': instance.tvShows,
      'people': instance.people,
    };

_$TMDBGenreImpl _$$TMDBGenreImplFromJson(Map<String, dynamic> json) =>
    _$TMDBGenreImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$$TMDBGenreImplToJson(_$TMDBGenreImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

_$TMDBMovieDetailImpl _$$TMDBMovieDetailImplFromJson(
        Map<String, dynamic> json) =>
    _$TMDBMovieDetailImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      originalTitle: json['original_title'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      releaseDate: json['release_date'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: (json['vote_count'] as num?)?.toInt() ?? 0,
      genres: (json['genres'] as List<dynamic>?)
              ?.map((e) => TMDBGenre.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      adult: json['adult'] as bool? ?? false,
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      runtime: (json['runtime'] as num?)?.toInt(),
      tagline: json['tagline'] as String?,
      status: json['status'] as String?,
      budget: (json['budget'] as num?)?.toInt(),
      revenue: (json['revenue'] as num?)?.toInt(),
      imdbId: json['imdb_id'] as String?,
      originalLanguage: json['original_language'] as String?,
    );

Map<String, dynamic> _$$TMDBMovieDetailImplToJson(
        _$TMDBMovieDetailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'original_title': instance.originalTitle,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'backdrop_path': instance.backdropPath,
      'release_date': instance.releaseDate,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'genres': instance.genres,
      'adult': instance.adult,
      'popularity': instance.popularity,
      'runtime': instance.runtime,
      'tagline': instance.tagline,
      'status': instance.status,
      'budget': instance.budget,
      'revenue': instance.revenue,
      'imdb_id': instance.imdbId,
      'original_language': instance.originalLanguage,
    };

_$TMDBTVShowDetailImpl _$$TMDBTVShowDetailImplFromJson(
        Map<String, dynamic> json) =>
    _$TMDBTVShowDetailImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      originalName: json['original_name'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      firstAirDate: json['first_air_date'] as String?,
      lastAirDate: json['last_air_date'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: (json['vote_count'] as num?)?.toInt() ?? 0,
      genres: (json['genres'] as List<dynamic>?)
              ?.map((e) => TMDBGenre.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      originCountry: (json['origin_country'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      tagline: json['tagline'] as String?,
      status: json['status'] as String?,
      originalLanguage: json['original_language'] as String?,
      numberOfSeasons: (json['number_of_seasons'] as num?)?.toInt(),
      numberOfEpisodes: (json['number_of_episodes'] as num?)?.toInt(),
      episodeRunTime: (json['episode_run_time'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      inProduction: json['in_production'] as bool? ?? false,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$$TMDBTVShowDetailImplToJson(
        _$TMDBTVShowDetailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'original_name': instance.originalName,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'backdrop_path': instance.backdropPath,
      'first_air_date': instance.firstAirDate,
      'last_air_date': instance.lastAirDate,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'genres': instance.genres,
      'origin_country': instance.originCountry,
      'popularity': instance.popularity,
      'tagline': instance.tagline,
      'status': instance.status,
      'original_language': instance.originalLanguage,
      'number_of_seasons': instance.numberOfSeasons,
      'number_of_episodes': instance.numberOfEpisodes,
      'episode_run_time': instance.episodeRunTime,
      'in_production': instance.inProduction,
      'type': instance.type,
    };

_$TMDBSeasonImpl _$$TMDBSeasonImplFromJson(Map<String, dynamic> json) =>
    _$TMDBSeasonImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      seasonNumber: (json['season_number'] as num).toInt(),
      episodeCount: (json['episode_count'] as num?)?.toInt() ?? 0,
      airDate: json['air_date'] as String?,
    );

Map<String, dynamic> _$$TMDBSeasonImplToJson(_$TMDBSeasonImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'season_number': instance.seasonNumber,
      'episode_count': instance.episodeCount,
      'air_date': instance.airDate,
    };

_$TMDBEpisodeImpl _$$TMDBEpisodeImplFromJson(Map<String, dynamic> json) =>
    _$TMDBEpisodeImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      overview: json['overview'] as String?,
      stillPath: json['still_path'] as String?,
      episodeNumber: (json['episode_number'] as num).toInt(),
      seasonNumber: (json['season_number'] as num).toInt(),
      airDate: json['air_date'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: (json['vote_count'] as num?)?.toInt() ?? 0,
      runtime: (json['runtime'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$TMDBEpisodeImplToJson(_$TMDBEpisodeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'overview': instance.overview,
      'still_path': instance.stillPath,
      'episode_number': instance.episodeNumber,
      'season_number': instance.seasonNumber,
      'air_date': instance.airDate,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'runtime': instance.runtime,
    };

_$TMDBSeasonDetailImpl _$$TMDBSeasonDetailImplFromJson(
        Map<String, dynamic> json) =>
    _$TMDBSeasonDetailImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      seasonNumber: (json['season_number'] as num).toInt(),
      airDate: json['air_date'] as String?,
      episodes: (json['episodes'] as List<dynamic>?)
              ?.map((e) => TMDBEpisode.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$TMDBSeasonDetailImplToJson(
        _$TMDBSeasonDetailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'season_number': instance.seasonNumber,
      'air_date': instance.airDate,
      'episodes': instance.episodes,
    };

_$TMDBConfigurationImpl _$$TMDBConfigurationImplFromJson(
        Map<String, dynamic> json) =>
    _$TMDBConfigurationImpl(
      images: json['images'] == null
          ? null
          : TMDBImages.fromJson(json['images'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TMDBConfigurationImplToJson(
        _$TMDBConfigurationImpl instance) =>
    <String, dynamic>{
      'images': instance.images,
    };

_$TMDBImagesImpl _$$TMDBImagesImplFromJson(Map<String, dynamic> json) =>
    _$TMDBImagesImpl(
      baseUrl: json['baseUrl'] as String?,
      secureBaseUrl: json['secureBaseUrl'] as String?,
      backdropSizes: (json['backdropSizes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      logoSizes: (json['logoSizes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      posterSizes: (json['posterSizes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      profileSizes: (json['profileSizes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      stillSizes: (json['stillSizes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$TMDBImagesImplToJson(_$TMDBImagesImpl instance) =>
    <String, dynamic>{
      'baseUrl': instance.baseUrl,
      'secureBaseUrl': instance.secureBaseUrl,
      'backdropSizes': instance.backdropSizes,
      'logoSizes': instance.logoSizes,
      'posterSizes': instance.posterSizes,
      'profileSizes': instance.profileSizes,
      'stillSizes': instance.stillSizes,
    };
