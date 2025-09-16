import 'data.dart';
import 'meta.dart';

class MovieDetailsResponse {
  String? status;
  String? statusMessage;
  Data? data;
  Meta? meta;

  MovieDetailsResponse({this.status, this.statusMessage, this.data, this.meta});

  factory MovieDetailsResponse.fromJson(Map<String, dynamic> json) => MovieDetailsResponse(
    status: json['status'] as String?,
    statusMessage: json['status_message'] as String?,
    data: json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
    meta: json['@meta'] == null
        ? null
        : Meta.fromJson(json['@meta'] as Map<String, dynamic>),
  );
}
