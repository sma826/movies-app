import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/watch_list_&_History/view/widgets/movie_grid_item.dart';
import 'package:movies/watch_list_&_History/data/models/favorite_movie.dart';
import 'package:movies/watch_list_&_History/view_model/history_cubit.dart';
import 'package:movies/watch_list_&_History/view_model/history_states.dart';

class HistoryTab extends StatelessWidget {
  final HistoryCubit cubit;
  final void Function(FavoriteMovie) onMovieTap;

  const HistoryTab({super.key, required this.cubit, required this.onMovieTap});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit..getHistoryMovies(),
      child: BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is HistoryError) {
            return Center(child: Text(state.message, style: TextStyle(color: Colors.red)));
          } else if (state is HistoryLoaded) {
            final movies = state.movies;
            if (movies.isEmpty) {
              return Center(child: Text('No movies in your history.', style: TextStyle(color: Colors.white)));
            }
            return GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.7,
              ),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return MovieGridItem(
                  movie: movie,
                  showStar: true,
                  onTap: () => onMovieTap(movie),
                );
              },
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
