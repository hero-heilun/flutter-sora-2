// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SearchItemImpl _$$SearchItemImplFromJson(Map<String, dynamic> json) =>
    _$SearchItemImpl(
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      href: json['href'] as String,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$$SearchItemImplToJson(_$SearchItemImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'href': instance.href,
      'id': instance.id,
    };

_$MediaItemImpl _$$MediaItemImplFromJson(Map<String, dynamic> json) =>
    _$MediaItemImpl(
      description: json['description'] as String,
      aliases: json['aliases'] as String,
      airdate: json['airdate'] as String,
    );

Map<String, dynamic> _$$MediaItemImplToJson(_$MediaItemImpl instance) =>
    <String, dynamic>{
      'description': instance.description,
      'aliases': instance.aliases,
      'airdate': instance.airdate,
    };

_$EpisodeLinkImpl _$$EpisodeLinkImplFromJson(Map<String, dynamic> json) =>
    _$EpisodeLinkImpl(
      number: (json['number'] as num).toInt(),
      title: json['title'] as String,
      href: json['href'] as String,
      duration: (json['duration'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$EpisodeLinkImplToJson(_$EpisodeLinkImpl instance) =>
    <String, dynamic>{
      'number': instance.number,
      'title': instance.title,
      'href': instance.href,
      'duration': instance.duration,
    };

_$StreamDataImpl _$$StreamDataImplFromJson(Map<String, dynamic> json) =>
    _$StreamDataImpl(
      streams: (json['streams'] as List<dynamic>)
          .map((e) => StreamSource.fromJson(e as Map<String, dynamic>))
          .toList(),
      subtitles: (json['subtitles'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$StreamDataImplToJson(_$StreamDataImpl instance) =>
    <String, dynamic>{
      'streams': instance.streams,
      'subtitles': instance.subtitles,
    };

_$StreamSourceImpl _$$StreamSourceImplFromJson(Map<String, dynamic> json) =>
    _$StreamSourceImpl(
      url: json['url'] as String,
      headers: (json['headers'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$$StreamSourceImplToJson(_$StreamSourceImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'headers': instance.headers,
    };
