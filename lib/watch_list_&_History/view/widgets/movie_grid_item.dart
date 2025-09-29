import 'package:flutter/material.dart';
import 'package:movies/watch_list_&_History/data/models/favorite_movie.dart';
import 'package:movies/shared/constants/font_manager.dart';

class MovieGridItem extends StatelessWidget {
  final FavoriteMovie movie;
  final VoidCallback onTap;
  final bool showStar;

  const MovieGridItem({
    super.key,
    required this.movie,
    required this.onTap,
    this.showStar = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                movie.imageURL ?? '',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey[800],
                  child: Center(child: Icon(Icons.broken_image, color: Colors.white)),
                ),
              ),
            ),
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Text(
                      movie.rating?.toStringAsFixed(1) ?? '-',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeightManager.fw700,
                        fontSize: 12,
                      ),
                    ),
                    if (showStar) ...[
                      SizedBox(width: 4),
                      Icon(Icons.star, color: Colors.amber, size: 14),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
