import 'package:flutter/material.dart';
import 'package:movies/movie_details/data/data_source/remote/movie_details_api_data_source.dart';
import 'package:movies/movie_details/data/models/movie_details/movie_details_item.dart';

import '../../../../shared/constants/apptheme.dart';
import '../../../../shared/constants/font_manager.dart';

class MovieSummary extends StatelessWidget {
  final MovieDetailsItem movie;

  MovieSummary({super.key, required this.movie});

  final remoteDataSource = MovieDetailsAPIDataSource();

  @override
  Widget build(BuildContext context) {
    final displaySummary =
        (movie.descriptionFull == null ||
            movie.descriptionFull!.trim().isEmpty)
        ? "No summary available"
        : movie.descriptionFull;

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
