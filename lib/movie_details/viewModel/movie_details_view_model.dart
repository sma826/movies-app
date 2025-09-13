import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movie_details/viewModel/movie_details_states.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  MovieDetailsCubit() : super(MovieDetailsInitial());

}