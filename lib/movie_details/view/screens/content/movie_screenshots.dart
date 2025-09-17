import 'package:flutter/material.dart';
import 'package:movies/movie_details/data/data_source/remote/movie_details_api_data_source.dart';
import 'package:movies/movie_details/data/models/movie_details/movie_details_item.dart';
import 'package:movies/shared/constants/apptheme.dart';

import '../../../../shared/constants/font_manager.dart';

class MovieScreenshots extends StatelessWidget {
  final MovieDetailsItem movie;

  MovieScreenshots({super.key, required this.movie});


  final remoteDataSource = MovieDetailsAPIDataSource();

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Screen Shots",
                  style: TextStyle(
                    fontFamily: FontStyleManager.fontFamily,
                    fontSize: FontSizes.s24,
                    fontWeight: FontWeightManager.fw700,
                    color: AppTheme.white,
                  ),
                ),
                const SizedBox(height: 9),
                if (movie.mediumScreenshotImage1 != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      movie.mediumScreenshotImage1 ?? "",
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height * 0.17,
                    ),
                  ),
                const SizedBox(height: 13),
                if (movie.mediumScreenshotImage2 != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      movie.mediumScreenshotImage2 ?? "",
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height * 0.17,
                    ),
                  ),
                const SizedBox(height: 13),
                if (movie.mediumScreenshotImage3 != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      movie.mediumScreenshotImage3 ?? "",
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height * 0.17,
                    ),
                  ),
              ],
            ),
          );
  }
}
