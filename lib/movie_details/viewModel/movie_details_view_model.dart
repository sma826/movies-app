import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movie_details/data/data_source/remote/movie_details_api_data_source.dart';
import 'package:movies/movie_details/data/data_source/remote/movie_details_remote_data_source.dart';
import 'package:movies/movie_details/viewModel/movie_details_states.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final MovieDetailsRemoteDataSource _remoteDataSource =
      MovieDetailsAPIDataSource();
  MovieDetailsCubit() : super(MovieDetailsInitial());

  Future<void> getMovieDetails(int movieId) async {
    emit(MovieDetailsLoading());
    try {
      final movieItem =  await _remoteDataSource.getMovieDetails(movieId);
      emit(MovieDetailsSuccess(movieItem: movieItem));
    } catch (e) {
      emit(MovieDetailsError(messsage: e.toString()));
    }
  }
}