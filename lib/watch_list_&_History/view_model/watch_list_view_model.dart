import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/watch_list_&_History/view_model/watch_list_states.dart';
import 'package:movies/watch_list_&_History/data/repositories/watch_list_repository.dart';
import 'package:movies/watch_list_&_History/data/models/favorite_movie.dart';

class WatchListCubit extends Cubit<WatchListState> {
  final MovieListRepository repository;

  WatchListCubit({required this.repository}) : super(WatchListInitial());

  Future<void> checkIsFavorite(String movieId) async {
    emit(WatchListLoading());
    try {
      final fav = await repository.movieIsFavorite(movieId);
      emit(WatchListIsFavoriteState(fav));
    } catch (e) {
      emit(WatchListError(e.toString()));
    }
  }

  Future<void> addMovie(FavoriteMovie movie) async {
    emit(WatchListLoading());
    try {
  await repository.addMovieToFavourite(movie);
  emit(WatchListActionSuccess('Added to favourites'));
      // Optionally refresh isFavorite state
      emit(WatchListIsFavoriteState(true));
    } catch (e) {
      emit(WatchListError(e.toString()));
    }
  }

  Future<void> removeMovie(String movieId) async {
    emit(WatchListLoading());
    try {
      await repository.removeMovie(movieId);
      emit(WatchListActionSuccess('Removed from favourites'));
      emit(WatchListIsFavoriteState(false));
    } catch (e) {
      emit(WatchListError(e.toString()));
    }
  }

  Future<void> getAllFavorites() async {
    emit(WatchListLoading());
    try {
      final list = await repository.getAllFavorites();
      emit(WatchListLoaded(list));
    } catch (e) {
      emit(WatchListError(e.toString()));
    }
  }
}