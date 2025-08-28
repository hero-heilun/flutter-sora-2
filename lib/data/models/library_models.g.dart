// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FavoriteItemImpl _$$FavoriteItemImplFromJson(Map<String, dynamic> json) =>
    _$FavoriteItemImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      type: json['type'] as String,
      posterPath: json['posterPath'] as String?,
      overview: json['overview'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      addedAt: DateTime.parse(json['addedAt'] as String),
      tmdbData: json['tmdbData'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$FavoriteItemImplToJson(_$FavoriteItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': instance.type,
      'posterPath': instance.posterPath,
      'overview': instance.overview,
      'rating': instance.rating,
      'addedAt': instance.addedAt.toIso8601String(),
      'tmdbData': instance.tmdbData,
    };

_$WatchHistoryItemImpl _$$WatchHistoryItemImplFromJson(
        Map<String, dynamic> json) =>
    _$WatchHistoryItemImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      type: json['type'] as String,
      posterPath: json['posterPath'] as String?,
      lastWatched: DateTime.parse(json['lastWatched'] as String),
      progress: (json['progress'] as num?)?.toInt() ?? 0,
      duration: (json['duration'] as num?)?.toInt() ?? 0,
      episodeTitle: json['episodeTitle'] as String?,
      episodeNumber: (json['episodeNumber'] as num?)?.toInt(),
      seasonNumber: (json['seasonNumber'] as num?)?.toInt(),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$WatchHistoryItemImplToJson(
        _$WatchHistoryItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': instance.type,
      'posterPath': instance.posterPath,
      'lastWatched': instance.lastWatched.toIso8601String(),
      'progress': instance.progress,
      'duration': instance.duration,
      'episodeTitle': instance.episodeTitle,
      'episodeNumber': instance.episodeNumber,
      'seasonNumber': instance.seasonNumber,
      'metadata': instance.metadata,
    };

_$BookmarkImpl _$$BookmarkImplFromJson(Map<String, dynamic> json) =>
    _$BookmarkImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      url: json['url'] as String,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
    );

Map<String, dynamic> _$$BookmarkImplToJson(_$BookmarkImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'url': instance.url,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'createdAt': instance.createdAt.toIso8601String(),
      'tags': instance.tags,
    };
