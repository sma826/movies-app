import 'package:flutter/material.dart';
import 'package:movies/movie_details/data/models/movie_details/movie_details_item.dart';
import 'package:movies/shared/constants/apptheme.dart';

class MovieGenres extends StatelessWidget {
  final MovieDetailsItem movie;
  const MovieGenres({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    List<String> genres = movie.genres ?? [];
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Genres',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 11,
              childAspectRatio: 122/36,
            ),
            shrinkWrap: true,
            itemCount: genres.length,
            itemBuilder: (context, index) => GenresItem(data: genres[index]),
          ),
        ],
      ),
    );
  }
}

class GenresItem extends StatelessWidget {
  final String data;
  const GenresItem({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 150,
      decoration: BoxDecoration(
        color: AppTheme.grey,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(vertical: 8),
      alignment: Alignment.center,
      child: Text(
        data,
        style: Theme.of(
          context,
        ).textTheme.titleMedium!.copyWith(color: AppTheme.white),
      ),
    );
  }
}
