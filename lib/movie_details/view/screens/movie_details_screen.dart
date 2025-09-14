import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:movies/movie_details/data/data_source/repositories/movies_details_repository_impl.dart';
import 'package:movies/movie_details/data/models/movie_details/movie.dart';
import 'package:movies/movie_details/view/screens/content/movie_cast.dart';
import 'package:movies/movie_details/view/screens/content/movie_genres.dart';
import 'package:movies/movie_details/view/screens/content/movie_header.dart';
import 'package:movies/movie_details/view/screens/content/movie_screenshots.dart';
import 'package:movies/movie_details/view/screens/content/movie_suggestions.dart';
import 'package:movies/movie_details/view/screens/content/movie_summary.dart';
import 'package:movies/shared/constants/apptheme.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const String routeName = '/details-screen';
  final int movieId;

  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<movieDetailsResponse>(
      future: MoviesDetailsRepository(Dio()).fetchMovieById(movieId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(fontSize: 18, color: AppTheme.red),
              ),
            ),
          );
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return const Scaffold(
            body: Center(
              child: Text(
                'No movie data available.',
                style: TextStyle(fontSize: 18, color: AppTheme.white),
              ),
            ),
          );
        }
        final movie = snapshot.data!;
        List<Widget> content = [
          MovieHeader(),
          MovieScreenshots(movie: movie, fullScreen: false),
          MovieSuggestions(),
          MovieSummary(),
          MovieCast(),
          MovieGenres(),
        ];
        return Scaffold(
          body: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemBuilder: (_, index) => content[index],
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemCount: content.length,
          ),
        );
      },
    );
  }
}
