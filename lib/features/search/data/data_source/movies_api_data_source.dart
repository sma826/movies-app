import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:movies/features/search/data/data_source/movies_data_source.dart';
import 'package:movies/movies/data/models/movie_model.dart';
import 'package:movies/shared/constants/api_constants.dart';

class MoviesApiDataSource implements MoviesDataSource {
  final Dio dio;
  MoviesApiDataSource({required this.dio});
  @override
  Future<List<Movie>> fetchMoviesByQueryTerm(
    String queryTerm, {
    int page = 1,
  }) async {
    final url = APIConstants.baseUrl + APIConstants.listMovies;

    final params = {'page': page, 'query_term': queryTerm};

    log("Fetching movies by query term", name: 'MoviesApiDataSource');
    log("URL: $url", name: 'MoviesApiDataSource');
    log("Params: $params", name: 'MoviesApiDataSource');

    final response = await dio.get(url, queryParameters: params);

    if (response.data == null || response.data['data'] == null) {
      throw Exception("No data from API");
    }

    final moviesData = Movies.fromJson(response.data);
    return moviesData.data.movies;
  }
}
