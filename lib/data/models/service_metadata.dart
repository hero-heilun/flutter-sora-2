import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_metadata.freezed.dart';
part 'service_metadata.g.dart';

@freezed
class ServiceMetadata with _$ServiceMetadata {
  const factory ServiceMetadata({
    required String sourceName,
    required ServiceAuthor author,
    required String iconUrl,
    required String version,
    required String language,
    required String baseUrl,
    required String streamType,
    required String quality,
    required String searchBaseUrl,
    required String scriptUrl,
    String? type,
    bool? softsub,
    bool? multiStream,
    bool? multiSubs,
    bool? novel,
    bool? settings,
    bool? asyncJS,
    bool? streamAsyncJS,
    String? note,
    bool? downloadSupport,
  }) = _ServiceMetadata;

  factory ServiceMetadata.fromJson(Map<String, dynamic> json) =>
      _$ServiceMetadataFromJson(json);
}

@freezed
class ServiceAuthor with _$ServiceAuthor {
  const factory ServiceAuthor({
    required String name,
    required String icon,
    String? url,
  }) = _ServiceAuthor;

  factory ServiceAuthor.fromJson(Map<String, dynamic> json) =>
      _$ServiceAuthorFromJson(json);
}