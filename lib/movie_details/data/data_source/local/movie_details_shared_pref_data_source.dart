// import 'dart:convert';

// import 'package:movies/movie_details/data/data_source/local/movie_details_local_data_source.dart';
// import 'package:movies/movie_details/data/models/movie_details/movie_details_item.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class MovieDetailsSharedPrefDataSource implements MovieDetailsLocalDataSource {
//   static const String movieKey = 'movie-';

//   @override
//   Future<MovieDetailsItem> getMovieDetails(int movieId) async {
//     final prefs = await SharedPreferences.getInstance();
//     final jsonString = prefs.getString('$movieKey$movieId');

//     Map<String, dynamic> json = jsonDecode(jsonString!);
//     return MovieDetailsItem.fromJson(json);
//   }

//   Future<void> cacheMovie(MovieDetailsItem movie) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('$movieKey${movie.id}', jsonEncode(movie.toJson()));
//   }
// }
