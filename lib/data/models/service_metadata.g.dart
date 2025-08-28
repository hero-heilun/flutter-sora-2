// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServiceMetadataImpl _$$ServiceMetadataImplFromJson(
        Map<String, dynamic> json) =>
    _$ServiceMetadataImpl(
      sourceName: json['sourceName'] as String,
      author: ServiceAuthor.fromJson(json['author'] as Map<String, dynamic>),
      iconUrl: json['iconUrl'] as String,
      version: json['version'] as String,
      language: json['language'] as String,
      baseUrl: json['baseUrl'] as String,
      streamType: json['streamType'] as String,
      quality: json['quality'] as String,
      searchBaseUrl: json['searchBaseUrl'] as String,
      scriptUrl: json['scriptUrl'] as String,
      type: json['type'] as String?,
      softsub: json['softsub'] as bool?,
      multiStream: json['multiStream'] as bool?,
      multiSubs: json['multiSubs'] as bool?,
      novel: json['novel'] as bool?,
      settings: json['settings'] as bool?,
      asyncJS: json['asyncJS'] as bool?,
      streamAsyncJS: json['streamAsyncJS'] as bool?,
      note: json['note'] as String?,
      downloadSupport: json['downloadSupport'] as bool?,
    );

Map<String, dynamic> _$$ServiceMetadataImplToJson(
        _$ServiceMetadataImpl instance) =>
    <String, dynamic>{
      'sourceName': instance.sourceName,
      'author': instance.author,
      'iconUrl': instance.iconUrl,
      'version': instance.version,
      'language': instance.language,
      'baseUrl': instance.baseUrl,
      'streamType': instance.streamType,
      'quality': instance.quality,
      'searchBaseUrl': instance.searchBaseUrl,
      'scriptUrl': instance.scriptUrl,
      'type': instance.type,
      'softsub': instance.softsub,
      'multiStream': instance.multiStream,
      'multiSubs': instance.multiSubs,
      'novel': instance.novel,
      'settings': instance.settings,
      'asyncJS': instance.asyncJS,
      'streamAsyncJS': instance.streamAsyncJS,
      'note': instance.note,
      'downloadSupport': instance.downloadSupport,
    };

_$ServiceAuthorImpl _$$ServiceAuthorImplFromJson(Map<String, dynamic> json) =>
    _$ServiceAuthorImpl(
      name: json['name'] as String,
      icon: json['icon'] as String,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$$ServiceAuthorImplToJson(_$ServiceAuthorImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'icon': instance.icon,
      'url': instance.url,
    };
