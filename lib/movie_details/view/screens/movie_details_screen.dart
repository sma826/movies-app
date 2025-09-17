import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movie_details/data/data_source/repositories/movies_Suggestions_Repository.dart';
import 'package:movies/movie_details/view/screens/content/movie_header.dart';
import 'package:movies/movie_details/view/screens/content/movie_screenshots.dart';
import 'package:movies/movie_details/view/screens/content/movie_suggestions.dart';
import 'package:movies/movie_details/view/screens/content/movie_summary.dart';
import 'package:movies/movie_details/view/screens/content/movie_cast.dart';
import 'package:movies/movie_details/view/screens/content/movie_genres.dart';
import 'package:movies/movie_details/viewModel/movie_suggestions_view_model.dart';
import 'package:movies/movie_details/viewModel/movie_details_states.dart';
import 'package:movies/movie_details/viewModel/movie_details_view_model.dart';
import 'package:movies/shared/widgets/loading_indicator.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const String routeName = 'movie-details';

  const MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int movieId = ModalRoute.of(context)!.settings.arguments as int;
    log('movieID: $movieId');

    return Scaffold(
      body: BlocProvider(
        create: (context) => MovieDetailsCubit()..getMovieDetails(movieId),
        child: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
          builder: (context, state) {
            if (state is MovieDetailsLoading) {
              return const LoadingIndicator();
            } else if (state is MovieDetailsError) {
              return Center(child: Text('${state.messsage}'));
            } else if (state is MovieDetailsSuccess) {
              final movie = state.movieItem;
              log('movieItem: $movie');

              List<Widget> content = [
                MovieHeader(movie: movie),
                MovieScreenshots(movie: movie),
                BlocProvider(
                  create: (_) => MovieSuggestionsCubit(
                    repository: MovieSuggestionsRepository(Dio()),
                  )..fetchSuggestions(movieId),
                  child: MovieSuggestions(movieId: movieId),
                ),
                MovieSummary(movie: movie),
                MovieCast(movie: movie),
                MovieGenres(movie: movie),
              ];

              return ListView.separated(
                itemBuilder: (_, index) => content[index],
                separatorBuilder: (_, index) => const SizedBox(height: 16),
                itemCount: content.length,
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
