abstract class WatchListRemoteDataSource {
  Future addMovieToFav();

  Future getAllFavMovies();

  Future movieIsFav();
  
  void removeMovie();
}
