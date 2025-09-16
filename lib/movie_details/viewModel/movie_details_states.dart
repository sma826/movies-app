import 'package:movies/movie_details/data/models/movie_details/movie_details_item.dart';

abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsSuccess extends MovieDetailsState {
  final MovieDetailsItem movieItem;

  MovieDetailsSuccess({required this.movieItem});
}

class MovieDetailsError extends MovieDetailsState {
  String? messsage;
  MovieDetailsError({this.messsage});
}
