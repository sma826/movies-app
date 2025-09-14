import 'package:flutter/material.dart';
import 'package:movies/shared/constants/apptheme.dart';
import 'package:movies/shared/constants/font_manager.dart';
import '../../../data/models/movie_details/movie.dart';

class MovieScreenshots extends StatelessWidget {
  final movieDetailsResponse movie;
  final bool fullScreen;
  const MovieScreenshots({
    super.key,
    required this.movie,
    this.fullScreen = false,
  });
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenshots = fullScreen
        ? [
            movie.largeScreenshotImage1,
            movie.largeScreenshotImage2,
            movie.largeScreenshotImage3,
          ]
        : [
            movie.mediumScreenshotImage1,
            movie.mediumScreenshotImage2,
            movie.mediumScreenshotImage3,
          ].whereType<String>().toList();
    if (screenshots.isEmpty) {
      return Padding(
        padding: EdgeInsets.all(12.0),
        child: Text(
          "No Screen Shots For This Film",
          style: textTheme.titleLarge!.copyWith(
            fontWeight: FontWeightManager.fw700,
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: Text(
            "Screen Shots",
            style: textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeightManager.fw700,
            ),
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          itemCount: screenshots.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final screenshot = screenshots[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                screenshot!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: fullScreen ? screenHeight * 0.35 : screenHeight * 0.2,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.broken_image,
                  color: AppTheme.red,
                  size: 50,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
