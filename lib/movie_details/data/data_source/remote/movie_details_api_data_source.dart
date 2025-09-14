import 'package:movies/movie_details/data/data_source/remote/movie_details_remote_data_source.dart';
import 'package:movies/movie_details/data/models/movie_details/movie.dart';

class MovieDetailsAPIDataSource implements MovieDetailsRemoteDataSource {
  @override
  Future<MovieDetails> getMovieDetails(int movieId) {
    // TODO: implement getMovieDetails
    throw UnimplementedError();
  }
}