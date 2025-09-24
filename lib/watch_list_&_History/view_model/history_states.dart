import 'package:movies/watch_list_&_History/data/models/favorite_movie.dart';

abstract class HistoryState {}

class HistoryInitial extends HistoryState {}
class HistoryLoading extends HistoryState {}
class HistoryLoaded extends HistoryState {
  final List<FavoriteMovie> movies;
  HistoryLoaded(this.movies);
}
class HistoryError extends HistoryState {
  final String message;
  HistoryError(this.message);
}
