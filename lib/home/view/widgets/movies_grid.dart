import 'package:flutter/material.dart';
import '../../../features/movies/data/models/movie_model.dart';
import '../../../shared/constants/apptheme.dart';

Widget buildMoviesGrid({
  required List<Movie> filteredMovies,
  required BuildContext context,
}) {
  if (filteredMovies.isEmpty) {
    return Center(
      child: Text(
        'No movies in this category.',
        style: TextStyle(color: Colors.white.withOpacity(0.7)),
      ),
    );
  }

  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  const spacing = 10;
  final crossAxisCount = 2;
  final rows = 3;
  final totalHorizontalSpacing = (crossAxisCount + 1) * spacing;
  final totalVerticalSpacing = (rows + 1) * spacing;
  final cardWidth = (screenWidth - totalHorizontalSpacing) / crossAxisCount;
  final cardHeight = ((screenHeight - totalVerticalSpacing) / rows);
  final childAspectRatio = cardWidth / cardHeight;

  return GridView.builder(
    padding: EdgeInsets.all(spacing.toDouble()),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: spacing.toDouble(),
      crossAxisSpacing: spacing.toDouble(),
      childAspectRatio: childAspectRatio,
    ),
    itemCount: filteredMovies.length,
    itemBuilder: (context, index) {
      final movie = filteredMovies[index];
      return _buildMovieCard(context, movie);
    },
  );
}

Widget _buildMovieCard(BuildContext context, Movie movie) {
  final screenWidth = MediaQuery.of(context).size.width;
  return Card(
    color: Colors.transparent,
    elevation: 0,
    clipBehavior: Clip.antiAlias,
    child: Stack(
      alignment: Alignment.topLeft,
      children: <Widget>[
        Positioned.fill(
          child: Image.network(
            movie.mediumCoverImage,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(color: Colors.grey),
          ),
        ),
        Positioned(
          top: 8,
          left: 8,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star,
                  color: AppTheme.yellow,
                  size: screenWidth * 0.035,
                ),
                SizedBox(width: screenWidth * 0.01),
                Flexible(
                  child: Text(
                    movie.rating.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.darkTheme.textTheme.titleMedium!.copyWith(
                      color: AppTheme.white,
                      fontSize: screenWidth * 0.035,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
