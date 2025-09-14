import 'package:movies/movie_details/data/models/movie_details/movie.dart';

abstract class MovieDetailsLocalDataSource {
  Future<MovieDetails> getMovieDetails(int movieId);
}
