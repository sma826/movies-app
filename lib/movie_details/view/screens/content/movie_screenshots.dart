import 'package:flutter/material.dart';
import 'package:movies/movie_details/data/data_source/remote/movie_details_remote_data_source.dart';
import 'package:movies/movie_details/data/models/movie_details/movie.dart';
import 'package:movies/shared/constants/apptheme.dart';
import 'package:movies/shared/widgets/loading_indicator.dart';

import '../../../../shared/constants/font_manager.dart';
import '../../../data/data_source/local/movie_details_shared_pref_data_source.dart';

class MovieScreenshots extends StatefulWidget {
  final int movieId;

  const MovieScreenshots({super.key, required this.movieId});

  @override
  State<MovieScreenshots> createState() => _MovieScreenshotsState();
}

class _MovieScreenshotsState extends State<MovieScreenshots> {
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
      print("loaded from local : ${localMovie.mediumScreenshotImage1}");
      setState(() {
        movie = localMovie;
        isLoading = false;
      });
    } catch (_) {
      try {
        final remoteMovie = await remoteDataSource.getMovieDetails(
          widget.movieId,
        );
        print("loaded from remote : ${remoteMovie.mediumScreenshotImage1}");
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
    return isLoading
        ? LoadingIndicator()
        : Padding(
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
                if (movie?.mediumScreenshotImage1 != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      movie?.mediumScreenshotImage1 ?? "",
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height * 0.17,
                    ),
                  ),
                const SizedBox(height: 13),
                if (movie?.mediumScreenshotImage2 != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      movie?.mediumScreenshotImage2 ?? "",
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height * 0.17,
                    ),
                  ),
                const SizedBox(height: 13),
                if (movie?.mediumScreenshotImage3 != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      movie?.mediumScreenshotImage3 ?? "",
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
