import 'dart:developer' show log;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movie_details/data/data_source/repositories/movies_Suggestions_Repository.dart';
import 'package:movies/movie_details/data/models/movie_suggestion/movie_suggestion_item.dart';
import 'movies_suggestions_State.dart';

class MovieSuggestionsCubit extends Cubit<MovieSuggestionsState> {
  final MovieSuggestionsRepository repository;

  MovieSuggestionsCubit({required this.repository})
    : super(MovieSuggestionsInitial());

  Future<void> fetchSuggestions(int movieId) async {
    try {
      emit(MovieSuggestionsLoading());
      log(
        'Fetching movie suggestions for movieId: $movieId',
        name: 'MovieSuggestionsCubit',
      );

      final suggestionsData = await repository.fetchMovieSuggestions(movieId);

      final List<MovieSuggestionItem> movies = suggestionsData.data.movies
          .map<MovieSuggestionItem>(
            (m) => MovieSuggestionItem(
              id: m.id,
              title: m.title,
              rating: m.rating.toDouble(),
              mediumCoverImage: m.mediumCoverImage,
            ),
          )
          .toList();

      log(
        'Number of suggestions received: ${movies.length}',
        name: 'MovieSuggestionsCubit',
      );

      emit(MovieSuggestionsSuccess(suggestions: movies));
    } catch (e, st) {
      log(
        'Error fetching suggestions: $e',
        name: 'MovieSuggestionsCubit',
        level: 1000,
        stackTrace: st,
      );
      emit(MovieSuggestionsError(message: 'Failed to load movie suggestions'));
    }
  }
}
