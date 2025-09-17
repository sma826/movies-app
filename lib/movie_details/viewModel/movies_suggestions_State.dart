import 'package:movies/movie_details/data/models/movie_suggestion/movie_suggestion_item.dart';

abstract class MovieSuggestionsState {}

class MovieSuggestionsInitial extends MovieSuggestionsState {}

class MovieSuggestionsLoading extends MovieSuggestionsState {}

class MovieSuggestionsSuccess extends MovieSuggestionsState {
  final List<MovieSuggestionItem> suggestions;
  MovieSuggestionsSuccess({required this.suggestions});
}

class MovieSuggestionsError extends MovieSuggestionsState {
  final String message;
  MovieSuggestionsError({required this.message});
}
