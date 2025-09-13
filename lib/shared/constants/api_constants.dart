class APIConstants {
  static const String authBaseURL = 'https://route-movie-apis.vercel.app/';
  static const String registerEndpoint = 'auth/register';
  static const String loginEndpoint = 'auth/login';

  static const String baseUrl = 'https://yts.mx/api';
  static const String listMovies = '/v2/list_movies.json';

  static const String movieDetailsEndPoint = '/v2/movie_details.json';
  static const String movieSimilarEndPoint = '/v2/movie_suggestions.json';
}

class CachedConstants {
  static const String tokenKey = 'token';
  static const String onBoardingKey = 'onBoardingKey';
}
