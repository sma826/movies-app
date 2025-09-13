import 'package:flutter/material.dart';
import 'package:movies/movie_details/view/screens/content/movie_cast.dart';
import 'package:movies/movie_details/view/screens/content/movie_genres.dart';
import 'package:movies/movie_details/view/screens/content/movie_header.dart';
import 'package:movies/movie_details/view/screens/content/movie_screenshots.dart';
import 'package:movies/movie_details/view/screens/content/movie_suggestions.dart';
import 'package:movies/movie_details/view/screens/content/movie_summary.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> content = [
      MovieHeader(),
      MovieScreenshots(),
      MovieSuggestions(),
      MovieSummary(),
      MovieCast(),
      MovieGenres(),
    ];

    return Scaffold(
      body: ListView.separated(
        itemBuilder: (_, index) => content[index],
        separatorBuilder: (_, index) => const SizedBox(height: 16),
        itemCount: content.length,
      ),
    );
  }
}