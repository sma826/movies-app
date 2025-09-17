import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:movies/shared/constants/api_constants.dart';
import '../../models/movie_suggestion/movie_suggestions.dart';

class MovieSuggestionsRepository {
  final Dio dio;

  MovieSuggestionsRepository(this.dio);

  Future<MovieSuggestions> fetchMovieSuggestions(int movieId) async {
    try {
      final url = APIConstants.baseUrl + APIConstants.movieSimilarEndPoint;
      final params = {'movie_id': movieId};

      log("Fetching movie suggestions", name: 'MovieSuggestionsRepository');
      log("URL: $url", name: 'MovieSuggestionsRepository');
      log("Params: $params", name: 'MovieSuggestionsRepository');

      final response = await dio.get(url, queryParameters: params);

      if (response.data == null || response.data['data'] == null) {
        throw Exception("No data from API");
      }

      final suggestionsData = MovieSuggestions.fromJson(response.data);
      return suggestionsData;
    } catch (e) {
      log(
        "Repository Error: $e",
        name: 'MovieSuggestionsRepository',
        level: 1000,
      );
      throw Exception("Repository Error: $e");
    }
  }
}
