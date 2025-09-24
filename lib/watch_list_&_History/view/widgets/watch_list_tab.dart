import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/watch_list_&_History/view_model/watch_list_view_model.dart';
import 'package:movies/watch_list_&_History/view_model/watch_list_states.dart';
import 'package:movies/watch_list_&_History/view/widgets/movie_grid_item.dart';
import 'package:movies/watch_list_&_History/data/models/favorite_movie.dart';

class WatchListTab extends StatelessWidget {
  final WatchListCubit cubit;
  final void Function(FavoriteMovie) onMovieTap;

  const WatchListTab({super.key, required this.cubit, required this.onMovieTap});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit..getAllFavorites(),
      child: BlocBuilder<WatchListCubit, WatchListState>(
        builder: (context, state) {
          if (state is WatchListLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is WatchListError) {
            return Center(child: Text(state.message, style: TextStyle(color: Colors.red)));
          } else if (state is WatchListLoaded) {
            final movies = state.favorites.cast<FavoriteMovie>();
            if (movies.isEmpty) {
              return Center(child: Text('No movies in your watch list.', style: TextStyle(color: Colors.white)));
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
