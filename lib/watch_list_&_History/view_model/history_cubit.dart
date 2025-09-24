import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/watch_list_&_History/view_model/history_states.dart';
import 'package:movies/watch_list_&_History/data/models/favorite_movie.dart';
import 'package:movies/watch_list_&_History/data/repositories/history_repository.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final HistoryRepository repository;

  HistoryCubit({required this.repository}) : super(HistoryInitial());

  Future<void> getHistoryMovies() async {
    emit(HistoryLoading());
    try {
      final movies = await repository.getHistoryMovies();
      emit(HistoryLoaded(movies));
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }

  Future<void> addMovieToHistory(FavoriteMovie movie) async {
    await repository.addMovieToHistory(movie);
    await getHistoryMovies();
  }
}
