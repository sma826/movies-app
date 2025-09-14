import 'movie.dart';

class Data {
  movieDetailsResponse? movie;

  Data({this.movie});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    movie: json['movie'] == null
        ? null
        : movieDetailsResponse.fromJson(json['movie'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {'movie': movie?.toJson()};
}
