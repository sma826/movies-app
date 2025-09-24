import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:movies/shared/constants/api_constants.dart';
import 'package:movies/watch_list_&_History/data/data_source/remote/watch_list_remote_data_source.dart';
import 'package:movies/watch_list_&_History/data/models/favorite_movie.dart';

const String _favoritesPath = 'favorites';

class WatchListAPIDataSource implements WatchListRemoteDataSource{
  final Dio _dio;

  WatchListAPIDataSource([Dio? dio]) : _dio = dio ?? Dio(BaseOptions(baseUrl: APIConstants.authBaseURL));

  Future<String?> _getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Options _authOptions(String token) => Options(headers: {'Authorization': 'Bearer $token'});

  @override
  Future<FavoriteMovie> addMovieToFav(FavoriteMovie movie) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('User token not found');
    }

    final response = await _dio.post('$_favoritesPath/add', data: movie.toJson(), options: _authOptions(token));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = response.data['data'] as Map<String, dynamic>?;
      if (data == null) throw Exception('Invalid response from server');
      return FavoriteMovie.fromJson(data);
    } else {
      throw Exception('Failed to add favorite: ${response.statusCode}');
    }
  }

  @override
  Future<List<FavoriteMovie>> getAllFavMovies() async {
    final token = await _getToken();
    if (token == null) throw Exception('User token not found');

    final response = await _dio.get('$_favoritesPath/all', options: _authOptions(token));

    if (response.statusCode == 200) {
      final list = response.data['data'] as List<dynamic>?;
      if (list == null) return [];
      return list.map((e) => FavoriteMovie.fromJson(e as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to fetch favorites: ${response.statusCode}');
    }
  }

  @override
  Future<bool> movieIsFav(String movieId) async {
    final token = await _getToken();
    if (token == null) throw Exception('User token not found');

    final response = await _dio.get('$_favoritesPath/is-favorite/$movieId', options: _authOptions(token));

    if (response.statusCode == 200) {
      return response.data['data'] as bool? ?? false;
    } else {
      throw Exception('Failed to check favourite: ${response.statusCode}');
    }
  }

  @override
  Future<void> removeMovie(String movieId) async {
    final token = await _getToken();
    if (token == null) throw Exception('User token not found');

    final response = await _dio.delete('$_favoritesPath/remove/$movieId', options: _authOptions(token));

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to remove favourite: ${response.statusCode}');
    }
  }
}
