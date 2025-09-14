import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/movie_details/data/data_source/local/movie_details_local_data_source.dart';
import 'package:movies/movie_details/data/models/movie_details/movie.dart';
import 'package:movies/shared/constants/api_constants.dart';

class MovieDetailsRemoteDataSource implements MovieDetailsLocalDataSource {
  @override
  Future<MovieDetails> getMovieDetails(int movieId) async {
    Uri uri = Uri.parse(
      "${APIConstants.baseUrl}${APIConstants.movieDetailsEndPoint}?movie_id=$movieId&with_images=true&with_cast=true",
    );
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final movieJson = json['data']['movie'];
      print(jsonEncode(json['data']['movie']));
      return MovieDetails.fromJson(movieJson);
    } else {
      throw Exception("Failed to load movie details");
    }
  }
}
