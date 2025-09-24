class FavoriteMovie {
  final String movieId;
  final String name;
  final double? rating;
  final String? imageURL;
  final String? year;

  FavoriteMovie({
    required this.movieId,
    required this.name,
    this.rating,
    this.imageURL,
    this.year,
  });

  factory FavoriteMovie.fromJson(Map<String, dynamic> json) => FavoriteMovie(
        movieId: json['movieId'] as String,
        name: json['name'] as String,
        rating: (json['rating'] as num?)?.toDouble(),
        imageURL: json['imageURL'] as String?,
        year: json['year']?.toString(),
      );

  Map<String, dynamic> toJson() => {
        'movieId': movieId,
        'name': name,
        'rating': rating,
        'imageURL': imageURL,
        'year': year,
      };
}
