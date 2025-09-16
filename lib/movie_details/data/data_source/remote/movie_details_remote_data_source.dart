import 'package:movies/movie_details/data/models/movie_details/movie_details_item.dart';

abstract class MovieDetailsRemoteDataSource {
  Future<MovieDetailsItem> getMovieDetails(int movieId);
}
