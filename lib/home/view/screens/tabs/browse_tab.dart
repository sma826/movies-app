import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../features/movies/data/repositories/movies_repository_impl.dart';
import '../../../../shared/constants/apptheme.dart';
import '../../viewModel/Browse_tab_view_model.dart';
import '../../viewModel/browse_tab_states.dart';
import '../../widgets/genres_row.dart';
import '../../widgets/movies_grid.dart';
import 'package:dio/dio.dart';

class BrowseTab extends StatelessWidget {
  const BrowseTab({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesRepo = MoviesRepository(Dio());

    return BlocProvider<BrowseTabCubit>(
      create: (_) => BrowseTabCubit(moviesRepo)..fetchMoviesAndGenres(),
      child: BlocBuilder<BrowseTabCubit, BrowseTabState>(
        builder: (context, state) {
          final cubit = context.read<BrowseTabCubit>();
          return Scaffold(
            backgroundColor: AppTheme.black,
            body: SafeArea(
              child: Column(
                children: [
                  buildGenresRow(
                    allUniqueGenres: cubit.allGenres.toSet(),
                    selectedGenre: state is MoviesLoaded
                        ? state.selectedGenre
                        : '',
                    onGenreSelected: (genre) {
                      cubit.fetchMoviesByGenre(genre);
                    },
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Builder(
                      builder: (_) {
                        if (state is MoviesLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is MoviesError) {
                          return Center(child: Text(state.message));
                        } else if (state is MoviesLoaded) {
                          if (state.movies.isEmpty) {
                            return const Center(
                              child: Text('No movies found.'),
                            );
                          }
                          return buildMoviesGrid(
                            filteredMovies: state.movies,
                            context: context,
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
