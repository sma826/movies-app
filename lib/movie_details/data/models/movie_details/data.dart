import 'movie_details_item.dart';

class Data {
  MovieDetailsItem? movie;

  Data({this.movie});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    movie: json['movie'] == null
        ? null
        : MovieDetailsItem.fromJson(json['movie'] as Map<String, dynamic>),
  );
}
