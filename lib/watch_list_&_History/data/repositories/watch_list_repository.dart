import 'package:movies/watch_list_&_History/data/models/favorite_movie.dart';
import 'package:movies/watch_list_&_History/data/data_source/remote/watch_list_remote_data_source.dart';

class MovieListRepository {
	final WatchListRemoteDataSource remoteDataSource;

	MovieListRepository(this.remoteDataSource);

	Future<FavoriteMovie> addMovieToFavourite(FavoriteMovie movie) => remoteDataSource.addMovieToFav(movie);

	Future<void> removeMovie(String movieId) => remoteDataSource.removeMovie(movieId);

	Future<List<FavoriteMovie>> getAllFavorites() => remoteDataSource.getAllFavMovies();

	Future<bool> movieIsFavorite(String movieId) => remoteDataSource.movieIsFav(movieId);
}
