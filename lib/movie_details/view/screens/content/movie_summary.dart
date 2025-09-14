import 'package:flutter/material.dart';
import 'package:movies/movie_details/data/models/movie_details/movie.dart';

import '../../../../shared/constants/apptheme.dart';
import '../../../../shared/constants/font_manager.dart';
import '../../../data/data_source/local/movie_details_shared_pref_data_source.dart';
import '../../../data/data_source/remote/movie_details_remote_data_source.dart';

class MovieSummary extends StatefulWidget {
  final int movieId;

  const MovieSummary({super.key, required this.movieId});

  @override
  State<MovieSummary> createState() => _MovieSummaryState();
}

class _MovieSummaryState extends State<MovieSummary> {
  MovieDetails? movie;
  String? errorMessage;
  bool isLoading = true;

  final remoteDataSource = MovieDetailsRemoteDataSource();
  final localDataSource = MovieDetailsSharedPrefDataSource();

  @override
  void initState() {
    super.initState();
    loadMovieDetails();
  }

  Future<void> loadMovieDetails() async {
    try {
      final localMovie = await localDataSource.getMovieDetails(widget.movieId);
      setState(() {
        movie = localMovie;
        isLoading = false;
      });
    } catch (_) {
      try {
        final remoteMovie = await remoteDataSource.getMovieDetails(
          widget.movieId,
        );
        await localDataSource.cacheMovie(remoteMovie);
        setState(() {
          movie = remoteMovie;
          isLoading = false;
        });
      } catch (e) {
        setState(() {
          errorMessage = e.toString();
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final displaySummary =
        (movie!.descriptionFull == null ||
            movie!.descriptionFull!.trim().isEmpty)
        ? "No summary available"
        : movie!.descriptionFull;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Summary",
            style: TextStyle(
              fontFamily: FontStyleManager.fontFamily,
              fontSize: FontSizes.s24,
              fontWeight: FontWeightManager.fw700,
              color: AppTheme.white,
            ),
          ),
          const SizedBox(height: 9),
          Text(
            displaySummary!,
            style: TextStyle(
              fontSize: FontSizes.s16,
              fontWeight: FontWeightManager.fw400,
              color: AppTheme.white,
              fontFamily: FontStyleManager.fontFamily,
            ),
          ),
        ],
      ),
    );
  }
}
