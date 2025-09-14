import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies/movie_details/view/screens/movie_details_screen.dart';
import 'package:movies/shared/constants/apptheme.dart';
import 'package:movies/shared/constants/assets_manager.dart';

import '../bloc/movies_state.dart';

class FeaturedMoviesCarousel extends StatelessWidget {
  final double width;
  final double height;
  final MoviesLoaded state;

  const FeaturedMoviesCarousel({
    super.key,
    required this.width,
    required this.height,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final carouselItemHeight = height * 0.36;
    final carouselItemWidth = width * 0.5;

    return SizedBox(
      height: carouselItemHeight,
      child: CarouselSlider.builder(
        itemCount: state.moviesData.data.movies.length,
        options: CarouselOptions(
          height: carouselItemHeight,
          initialPage: 1,
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
          enlargeStrategy: CenterPageEnlargeStrategy.scale,
          enlargeFactor: 0.3,
          viewportFraction: 0.5,
        ),
        itemBuilder: (context, index, realIndex) {
          final movie = state.moviesData.data.movies[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      MovieDetailsScreen(movieId: movie.id ?? 0),
                ),
              );
            },
            child: Container(
              width: carouselItemWidth,
              height: carouselItemHeight,
              margin: EdgeInsets.symmetric(horizontal: width * 0.01),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    Image.network(
                      movie.largeCoverImage,
                      width: carouselItemWidth,
                      height: carouselItemHeight,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          AssetsManager.placeHolder,
                          width: carouselItemWidth,
                          height: carouselItemHeight,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        margin: EdgeInsets.all(width * 0.02),
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.015,
                          vertical: height * 0.005,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              color: AppTheme.yellow,
                              size: width * 0.035,
                            ),
                            SizedBox(width: width * 0.01),
                            Flexible(
                              child: Text(
                                movie.rating.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: AppTheme.darkTheme.textTheme.titleMedium!
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: width * 0.035,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
