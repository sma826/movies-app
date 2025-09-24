import '../../../features/movies/data/models/movie_model.dart';

abstract class BrowseTabState {}

class MoviesInitial extends BrowseTabState {}

class MoviesLoading extends BrowseTabState {}

class MoviesLoaded extends BrowseTabState {
  final List<Movie> movies;
  final List<String> genres;
  final String selectedGenre;

  MoviesLoaded({
    required this.movies,
    required this.genres,
    required this.selectedGenre,
  });
}

class MoviesError extends BrowseTabState {
  final String message;
  MoviesError(this.message);
}
