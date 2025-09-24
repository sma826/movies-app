import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../features/movies/data/repositories/movies_repository_impl.dart';
import 'browse_tab_states.dart';

class BrowseTabCubit extends Cubit<BrowseTabState> {
  final MoviesRepository repository;
  BrowseTabCubit(this.repository) : super(MoviesInitial());

  List<String> _allGenres = [];
  List<String> get allGenres => _allGenres;

  Future<void> fetchMoviesAndGenres() async {
    emit(MoviesLoading());
    try {
      final moviesData = await repository.fetchMoviesByGenre('');
      final movies = moviesData.data.movies ?? [];
      final genresSet = <String>{};
      for (var movie in movies) {
        genresSet.addAll(movie.genres);
      }

      final sortedGenres = genresSet.toList()..sort();
      _allGenres = sortedGenres;

      log("All genres fetched from API: $sortedGenres", name: 'BrowseTabCubit');

      final selectedGenre = sortedGenres.isNotEmpty ? sortedGenres.first : '';
      emit(
        MoviesLoaded(
          movies: movies,
          genres: sortedGenres,
          selectedGenre: selectedGenre,
        ),
      );

      if (selectedGenre.isNotEmpty) {
        fetchMoviesByGenre(selectedGenre);
      }
    } catch (e) {
      emit(MoviesError(e.toString()));
    }
  }

  Future<void> fetchMoviesByGenre(String genre) async {
    emit(MoviesLoading());
    try {
      final moviesData = await repository.fetchMoviesByGenre(genre);
      final movies = moviesData.data.movies ?? [];

      emit(
        MoviesLoaded(movies: movies, genres: _allGenres, selectedGenre: genre),
      );
    } catch (e) {
      emit(MoviesError(e.toString()));
    }
  }
}
