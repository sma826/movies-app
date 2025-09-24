import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movie_details/data/models/movie_details/movie_details_item.dart';
import 'package:movies/movie_details/viewModel/movie_details_view_model.dart';
import 'package:movies/watch_list_&_History/view_model/watch_list_view_model.dart';
import 'package:movies/watch_list_&_History/data/data_source/remote/watch_list_api_data_source.dart';
import 'package:movies/watch_list_&_History/data/repositories/watch_list_repository.dart';
import 'package:movies/watch_list_&_History/data/models/favorite_movie.dart';
import 'package:movies/watch_list_&_History/view_model/watch_list_states.dart';
import 'package:movies/shared/constants/apptheme.dart';
import 'package:movies/shared/constants/font_manager.dart';
import 'package:movies/shared/widgets/custom_elevated_button.dart';

class MovieHeader extends StatefulWidget {
  final MovieDetailsItem movie;
  const MovieHeader({super.key, required this.movie});

  @override
  State<MovieHeader> createState() => _MovieHeaderState();
}

class _MovieHeaderState extends State<MovieHeader> {
  bool isMarked = false;
  late final WatchListCubit _watchCubit;

  @override
  void initState() {
    super.initState();
    final repo = MovieListRepository(WatchListAPIDataSource());
    _watchCubit = WatchListCubit(repository: repo);
    // check if the movie is favorite
    final movieId = widget.movie.id?.toString() ?? '';
    if (movieId.isNotEmpty) {
      _watchCubit.checkIsFavorite(movieId);
    }
  }

  @override
  void dispose() {
    _watchCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (context) => MovieDetailsCubit(),
      child: Stack(
        children: [
          Container(
            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.primary, Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Image.network(widget.movie.largeCoverImage ?? ''),
          ),
          Positioned(
            left: 16,
            top: 16,
            child: IconButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.of(context).pop();
                }
              },
              icon: Icon(
                CupertinoIcons.chevron_back,
                size: 30,
                color: AppTheme.white,
              ),
            ),
          ),
          Positioned(
            right: 16,
            top: 16,
            child: BlocProvider.value(
              value: _watchCubit,
              child: BlocListener<WatchListCubit, WatchListState>(
                listener: (context, state) {
                  if (state is WatchListIsFavoriteState) {
                    isMarked = state.isFavorite;
                    setState(() {});
                  } else if (state is WatchListActionSuccess) {
                    // toggle based on action
                    // state message can be used for snackbars
                    setState(() {});
                  }
                },
                child: BlocBuilder<WatchListCubit, WatchListState>(
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () async {
                        final movieId = widget.movie.id?.toString() ?? '';
                        if (movieId.isEmpty) return;

                        if (isMarked) {
                          await _watchCubit.removeMovie(movieId);
                        } else {
                          final fav = FavoriteMovie(
                            movieId: movieId,
                            name: widget.movie.title ?? '',
                            rating: widget.movie.rating,
                            imageURL: widget.movie.largeCoverImage,
                            year: widget.movie.year?.toString(),
                          );
                          await _watchCubit.addMovie(fav);
                        }
                        // toggle local state; cubit will emit isFavorite too
                        isMarked = !isMarked;
                        setState(() {});
                      },
                      icon: Icon(
                        isMarked
                            ? CupertinoIcons.bookmark_fill
                            : CupertinoIcons.bookmark,
                        size: 30,
                        color: AppTheme.white,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            bottom: 20,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Text(
                    widget.movie.title ?? '',
                    style: textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeightManager.fw700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${widget.movie.year}",
                    style: textTheme.titleLarge!.copyWith(
                      color: AppTheme.headerGrey,
                      fontWeight: FontWeightManager.fw700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomElevatedButton(
                    label: 'Watch',
                    onPressed: () {},
                    buttonColor: AppTheme.red,
                    borderRadius: 15,
                    textColor: AppTheme.white,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.darkCharcoal,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.heart_fill,
                                color: AppTheme.transparentYellow,
                              ),
                              const SizedBox(width: 15),
                              Text(
                                '${widget.movie.likeCount}',
                                style: textTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeightManager.fw700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.darkCharcoal,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.clock_fill,
                                color: AppTheme.transparentYellow,
                              ),
                              const SizedBox(width: 15),
                              Text(
                                '${widget.movie.runtime}',
                                style: textTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeightManager.fw700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.darkCharcoal,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.star_fill,
                                color: AppTheme.transparentYellow,
                              ),
                              const SizedBox(width: 15),
                              Text(
                                '${widget.movie.rating}',
                                style: textTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeightManager.fw700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
