import 'package:movies/movies/data/models/movie_model.dart';

abstract class MoviesDataSource {
  Future<List<Movie>> fetchMoviesByQueryTerm(String genre, {int page=1});
}