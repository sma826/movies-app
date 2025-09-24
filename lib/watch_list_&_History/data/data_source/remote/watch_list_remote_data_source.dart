import '../../models/favorite_movie.dart';

abstract class WatchListRemoteDataSource {
  Future<FavoriteMovie> addMovieToFav(FavoriteMovie movie);

  Future<List<FavoriteMovie>> getAllFavMovies();

  Future<bool> movieIsFav(String movieId);
  
  Future<void> removeMovie(String movieId);
}

