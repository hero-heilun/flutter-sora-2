import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_result.freezed.dart';
part 'search_result.g.dart';

@freezed
class SearchItem with _$SearchItem {
  const factory SearchItem({
    required String title,
    required String imageUrl,
    required String href,
    String? id,
  }) = _SearchItem;

  factory SearchItem.fromJson(Map<String, dynamic> json) =>
      _$SearchItemFromJson(json);
}

@freezed
class MediaItem with _$MediaItem {
  const factory MediaItem({
    required String description,
    required String aliases,
    required String airdate,
  }) = _MediaItem;

  factory MediaItem.fromJson(Map<String, dynamic> json) =>
      _$MediaItemFromJson(json);
}

@freezed
class EpisodeLink with _$EpisodeLink {
  const factory EpisodeLink({
    required int number,
    required String title,
    required String href,
    int? duration,
  }) = _EpisodeLink;

  factory EpisodeLink.fromJson(Map<String, dynamic> json) =>
      _$EpisodeLinkFromJson(json);
}

@freezed
class StreamData with _$StreamData {
  const factory StreamData({
    required List<StreamSource> streams,
    @Default([]) List<String> subtitles,
  }) = _StreamData;

  factory StreamData.fromJson(Map<String, dynamic> json) =>
      _$StreamDataFromJson(json);
}

@freezed
class StreamSource with _$StreamSource {
  const factory StreamSource({
    required String url,
    Map<String, String>? headers,
  }) = _StreamSource;

  factory StreamSource.fromJson(Map<String, dynamic> json) =>
      _$StreamSourceFromJson(json);
}