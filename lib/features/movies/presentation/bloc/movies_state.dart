import 'package:movies/features/movies/data/models/movie_model.dart';

abstract class MoviesState {}

class MoviesInitial extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final Movies moviesData;
  MoviesLoaded(this.moviesData);
}

class MoviesError extends MoviesState {
  final String message;
  MoviesError(this.message);
}
