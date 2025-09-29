import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:movies/movies/data/models/movie_model.dart';
import 'package:movies/shared/constants/api_constants.dart';

class MoviesRepository {
  final Dio dio;
  MoviesRepository(this.dio);

  Future<Movies> fetchMoviesByGenre(String genre) async {
    try {
      final url = APIConstants.baseUrl + APIConstants.listMovies;

      final params = {
        'limit': genre.isEmpty ? 50 : 20,
        'sort_by': 'date_added',
        'order_by': 'desc',
        'genre': genre,
        'quality': 'All',
        'page': 1,
        'query_term': 0,
        'minimum_rating': 0,
        'with_rt_ratings': 'false',
      };

      log("Fetching movies by genre", name: 'MoviesRepository');
      log("URL: $url", name: 'MoviesRepository');
      log("Params: $params", name: 'MoviesRepository');

      final response = await dio.get(url, queryParameters: params);

      if (response.data == null || response.data['data'] == null) {
        throw Exception("No data from API");
      }

      final moviesData = Movies.fromJson(response.data);
      return moviesData;
    } catch (e) {
      log("Repository Error: $e", name: 'MoviesRepository', level: 1000);
      throw Exception("Repository Error: $e");
    }
  }

  Future<Movies> fetchLatestMovies() async {
    try {
      final url = APIConstants.baseUrl + APIConstants.listMovies;
      final params = {'limit': 10, 'sort_by': 'date_added', 'order_by': 'desc'};

      log("Fetching latest movies", name: 'MoviesRepository');
      log("URL: $url", name: 'MoviesRepository');
      log("Params: $params", name: 'MoviesRepository');

      final response = await dio.get(url, queryParameters: params);
      if (response.data == null || response.data['data'] == null) {
        throw Exception("No data from API");
      }

      final moviesData = Movies.fromJson(response.data);
      return moviesData;
    } catch (e) {
      log("Repository Error: $e", name: 'MoviesRepository', level: 1000);
      throw Exception("Repository Error: $e");
    }
  }
}
