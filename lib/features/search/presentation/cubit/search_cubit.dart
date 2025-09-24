import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/search/data/repositories/movies_search_repositoriey.dart';
import 'package:movies/features/search/presentation/cubit/search_state.dart';
import 'package:movies/movies/data/models/movie_model.dart';

class MoviesSearchCubit extends Cubit<SearchState> {
  final MoviesSearchRepositoriey moviesSearchRepositoriey;
  MoviesSearchCubit(this.moviesSearchRepositoriey) : super(SearchInitial());

  Future<void> searchMovies(String queryTerm, {int page = 1}) async {
    emit(SearchLoading());
    try {
      final List <Movie> movies = await moviesSearchRepositoriey.fetchMoviesByQueryTerm(queryTerm, page: page);
      emit(SearchSuccess( movies));
    } catch (e) {
      emit(SearchError( e.toString()));
    }
  }
}