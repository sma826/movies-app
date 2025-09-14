import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:movies/shared/constants/api_constants.dart';
import '../../models/movie_details/movie.dart';

class MoviesDetailsRepository {
  final Dio dio;
  MoviesDetailsRepository(this.dio);

  /// Fetch movies by genre or optional filters
  Future<List<movieDetailsResponse>> fetchMoviesById({
    int? movieId,
    String? imdbId,
    bool withImages = false,
    bool withCast = false,
  }) async {
    try {
      final url = APIConstants.baseUrl + APIConstants.movieDetailsEndPoint;

      final params = <String, dynamic>{
        if (movieId != null) 'movie_id': movieId,
        if (imdbId != null) 'imdb_id': imdbId,
        'with_images': withImages,
        'with_cast': withCast,
      };
      final finalUri = Uri.parse(url).replace(
        queryParameters: params.map((k, v) => MapEntry(k, v.toString())),
      );

      log("Fetching movies", name: 'MoviesDetailsRepository');
      log("Final URL: $finalUri", name: 'MoviesDetailsRepository');

      final response = await dio.get(url, queryParameters: params);

      if (response.data == null || response.data['data'] == null) {
        throw Exception("No data from API");
      }
      final movieJson =
          response.data['data']['movie'] ?? response.data['data']['movies'];
      if (movieJson == null) return [];

      if (movieJson is List) {
        return movieJson
            .map(
              (json) =>
                  movieDetailsResponse.fromJson(json as Map<String, dynamic>),
            )
            .toList();
      }

      return [movieDetailsResponse.fromJson(movieJson as Map<String, dynamic>)];
    } catch (e) {
      log("Repository Error: $e", name: 'MoviesDetailsRepository', level: 1000);
      throw Exception("Repository Error: $e");
    }
  }

  /// Fetch a single movie by ID
  Future<movieDetailsResponse> fetchMovieById(int movieId) async {
    log("Fetching movie with ID: $movieId", name: 'MoviesDetailsRepository');

    final movies = await fetchMoviesById(movieId: movieId, withImages: true);

    log(
      "Number of movies fetched: ${movies.length}",
      name: 'MoviesDetailsRepository',
    );

    if (movies.isEmpty) {
      log(
        "No movie found for ID: $movieId",
        name: 'MoviesDetailsRepository',
        level: 1000,
      );
      throw Exception("Movie not found");
    }

    final movie = movies.first;
    log("Fetched movie title: ${movie.title}", name: 'MoviesDetailsRepository');

    return movie;
  }
}
