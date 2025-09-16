import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movie_details/data/models/movie_details/movie_details_item.dart';
import 'package:movies/movie_details/viewModel/movie_details_view_model.dart';
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
            child: IconButton(
              onPressed: () {
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
