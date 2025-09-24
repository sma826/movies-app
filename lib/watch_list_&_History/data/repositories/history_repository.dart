import 'package:movies/watch_list_&_History/data/models/favorite_movie.dart';
import 'package:movies/watch_list_&_History/data/data_source/local/history_local_data_source.dart';

class HistoryRepository {
  final HistoryLocalDataSource localDataSource;

  HistoryRepository(this.localDataSource);

  Future<List<FavoriteMovie>> getHistoryMovies() async {
    return await localDataSource.getHistoryMovies();
  }

  Future<void> addMovieToHistory(FavoriteMovie movie) async {
    await localDataSource.addMovieToHistory(movie);
  }
}
