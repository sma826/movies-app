import 'package:flutter/material.dart';
import 'package:movies/movie_details/data/models/movie_details/cast.dart';
import 'package:movies/movie_details/data/models/movie_details/movie_details_item.dart';
import 'package:movies/shared/constants/apptheme.dart';
import 'package:movies/shared/constants/font_manager.dart';

class MovieCast extends StatelessWidget {
  final MovieDetailsItem movie;
  const MovieCast({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    List<Cast> casting;
    casting = movie.cast ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            'Cast',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 5),
        ...casting.map(
          (cast) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: CastItem(cast: cast),
          ),
        ),
      ],
    );
  }
}

class CastItem extends StatelessWidget {
  final Cast cast;
  const CastItem({required this.cast});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(11),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppTheme.grey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: cast.urlSmallImage != null
                ? Image.network(
                    cast.urlSmallImage!,
                    width: 70,
                    height: 70,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/placeholder.png',
                        width: 70,
                        height: 70,
                        fit: BoxFit.fill,
                      );
                    },
                  )
                : Image.asset(
                    'assets/images/placeholder.png',
                    width: 70,
                    height: 70,
                    fit: BoxFit.fill,
                  ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name : ${cast.name}',
                  style: Theme.of(context).textTheme.titleLarge,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 11),
                Text(
                  'Character : ${cast.characterName}',
                  style: Theme.of(context).textTheme.titleLarge,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
