import 'dart:developer';

import 'package:movies/features/movies/data/models/movie_model.dart';
import 'package:movies/features/search/data/data_source/movies_api_data_source.dart';

class MoviesSearchRepositoriey {
  final MoviesApiDataSource moviesApiDataSource;

  MoviesSearchRepositoriey(this.moviesApiDataSource);
  Future<List<Movie>> fetchMoviesByQueryTerm(String queryTerm, {int page = 1}) {
    try {
      return moviesApiDataSource.fetchMoviesByQueryTerm(queryTerm, page: page);
    } catch (e) {
       log("Repository Error: $e", name: 'MoviesSearchRepository', level: 1000);
      throw Exception("Repository Error: $e");
    }
  }
}
