import 'dart:convert';
import 'dart:developer';

import 'package:movies/movie_details/data/data_source/remote/movie_details_remote_data_source.dart';
import 'package:movies/movie_details/data/models/movie_details/movie_details_item.dart';
import 'package:movies/movie_details/data/models/movie_suggestion/movie_suggestion_item.dart';
import 'package:movies/shared/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class MovieDetailsAPIDataSource implements MovieDetailsRemoteDataSource {
  @override
  Future<MovieDetailsItem> getMovieDetails(int movieId) async {
    try {
      Uri uri = Uri.parse(
        "${APIConstants.baseUrl}${APIConstants.movieDetailsEndPoint}?movie_id=$movieId&with_images=true&with_cast=true",
      );
      final response = await http.get(uri);

      final json = jsonDecode(response.body);
      final movieJson = json['data']['movie'];
      log(jsonEncode(json['data']['movie']));
      return MovieDetailsItem.fromJson(movieJson);
    } catch (e) {
      throw Exception("Failed to load movie details");
    }
  }
}
