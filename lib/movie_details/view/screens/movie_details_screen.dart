import 'package:flutter/material.dart';
import 'package:movies/movie_details/view/screens/content/movie_cast.dart';
import 'package:movies/movie_details/view/screens/content/movie_genres.dart';
import 'package:movies/movie_details/view/screens/content/movie_header.dart';
import 'package:movies/movie_details/view/screens/content/movie_screenshots.dart';
import 'package:movies/movie_details/view/screens/content/movie_suggestions.dart';
import 'package:movies/movie_details/view/screens/content/movie_summary.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    List<Widget> content = [
      MovieHeader(),
      MovieScreenshots(movieId: movieId,),
      MovieSuggestions(),
      MovieSummary(movieId: movieId),
      MovieCast(),
      MovieGenres(),
    ];

    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
        itemBuilder: (_, index) => content[index],
        separatorBuilder: (_, index) => const SizedBox(height: 16),
        itemCount: content.length,
      ),
    );
  }
}