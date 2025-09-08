import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/movies/data/repositories/movies_repository_impl.dart';
import 'movies_event.dart';
import 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MoviesRepository repository;

  MoviesBloc(this.repository) : super(MoviesInitial()) {
    on<FetchLatestMovies>((event, emit) async {
      emit(MoviesLoading());
      try {
        final moviesData = await repository.fetchLatestMovies();
        emit(MoviesLoaded(moviesData));
      } catch (e) {
        emit(MoviesError(e.toString()));
      }
    });
  }
}
