import 'dart:convert';

import 'package:movies/movie_details/data/data_source/local/movie_details_local_data_source.dart';
import 'package:movies/movie_details/data/models/movie_details/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovieDetailsSharedPrefDataSource implements MovieDetailsLocalDataSource {
  static const String movieKey = 'movie-';

  @override
  Future<MovieDetails> getMovieDetails(int movieId) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('$movieKey$movieId');

    Map<String, dynamic> json = jsonDecode(jsonString!);
    return MovieDetails.fromJson(json);
  }

  Future<void> cacheMovie(MovieDetails movie) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('$movieKey${movie.id}', jsonEncode(movie.toJson()));
  }
}
