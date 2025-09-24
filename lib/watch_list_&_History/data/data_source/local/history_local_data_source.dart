import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movies/watch_list_&_History/data/models/favorite_movie.dart';


class HistoryLocalDataSource {
  String _token = '';

  void setToken(String token) {
    _token = token;
  }

  String get historyKey => 'movie_history_$_token';

  Future<List<FavoriteMovie>> getHistoryMovies() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getStringList(historyKey) ?? [];
    return historyJson.map((jsonStr) => FavoriteMovie.fromJson(json.decode(jsonStr))).toList();
  }

  Future<void> addMovieToHistory(FavoriteMovie movie) async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getStringList(historyKey) ?? [];
    // Avoid duplicates
    if (!historyJson.any((jsonStr) => FavoriteMovie.fromJson(json.decode(jsonStr)).movieId == movie.movieId)) {
      historyJson.add(json.encode(movie.toJson()));
      await prefs.setStringList(historyKey, historyJson);
    }
  }
}
