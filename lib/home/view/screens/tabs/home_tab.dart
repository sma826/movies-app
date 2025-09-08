import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:movies/features/movies/presentation/bloc/movies_bloc.dart';
import 'package:movies/features/movies/presentation/bloc/movies_event.dart';
import 'package:movies/features/movies/presentation/bloc/movies_state.dart';
import 'package:movies/shared/constants/apptheme.dart';
import 'package:movies/shared/constants/assets_manager.dart';
import 'package:movies/features/movies/presentation/widgets/featured_movies_carousel.dart';
import 'package:movies/features/movies/data/repositories/movies_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  HomeTabState createState() => HomeTabState();
}

class HomeTabState extends State<HomeTab> {
  List<String> genresList = [];
  int currentGenreIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadSavedGenreIndex();
  }

  Future<void> _loadSavedGenreIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentGenreIndex = prefs.getInt('currentGenreIndex') ?? 0;
    });
  }

  Future<void> _saveGenreIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentGenreIndex', currentGenreIndex);
  }

  void _incrementGenre() {
    if (genresList.isNotEmpty) {
      setState(() {
        currentGenreIndex = (currentGenreIndex + 1) % genresList.length;
      });
      _saveGenreIndex();
    }
  }

  void refreshCategory() {
    _incrementGenre();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) =>
          MoviesBloc(MoviesRepository(Dio()))..add(FetchLatestMovies()),
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: screenWidth,
                  height: screenHeight * 0.7,
                  child: Stack(
                    children: [
                      Container(
                        width: screenWidth,
                        height: screenHeight * 0.7,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AssetsManager.onboarding6),
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppTheme.gradientTop,
                                AppTheme.gradientMiddle,
                                AppTheme.gradientBottom,
                              ],
                              stops: const [0.0, 0.4, 1.0],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: screenHeight * 0.0,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Image.asset(
                            AssetsManager.availablenow,
                            width: screenWidth * 0.6,
                            height: screenHeight * 0.12,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.14),
                        child: BlocBuilder<MoviesBloc, MoviesState>(
                          builder: (context, state) {
                            if (state is MoviesLoading) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: AppTheme.yellow,
                                ),
                              );
                            } else if (state is MoviesLoaded) {
                              return FeaturedMoviesCarousel(
                                width: screenWidth,
                                height: screenHeight,
                                state: state,
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.088,
                        bottom: screenHeight * 0.01,
                        child: Image.asset(
                          AssetsManager.watchnow,
                          width: screenWidth * 0.83,
                          height: screenHeight * 0.15,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<MoviesBloc, MoviesState>(
                  builder: (context, state) {
                    if (state is MoviesLoaded) {
                      final allGenres = <String>{};
                      for (var movie in state.moviesData.data.movies) {
                        allGenres.addAll(movie.genres);
                      }
                      genresList = allGenres.toList();
                      final currentCategory = genresList.isNotEmpty
                          ? genresList[currentGenreIndex]
                          : "No Category";
                      return FutureBuilder(
                        future: MoviesRepository(
                          Dio(),
                        ).fetchMoviesByGenre(currentCategory),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: AppTheme.yellow,
                              ),
                            );
                          }
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                'Error: ${snapshot.error}',
                                style: const TextStyle(color: Colors.red),
                              ),
                            );
                          }
                          final movies = snapshot.data!.data.movies;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.05,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      currentCategory,
                                      style: AppTheme
                                          .darkTheme
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            color: AppTheme.white,
                                            fontSize: screenWidth * 0.05,
                                          ),
                                    ),
                                    InkWell(
                                      onTap: _incrementGenre,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "See More",
                                            style: AppTheme
                                                .darkTheme
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                  color: AppTheme.yellow,
                                                  fontSize: screenWidth * 0.04,
                                                ),
                                          ),
                                          SizedBox(width: screenWidth * 0.01),
                                          Icon(
                                            Icons.arrow_forward,
                                            size: screenWidth * 0.04,
                                            color: AppTheme.yellow,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              SizedBox(
                                height: screenHeight * 0.28,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.03,
                                  ),
                                  itemCount: movies.length,
                                  itemBuilder: (context, index) {
                                    final movie = movies[index];
                                    return Container(
                                      width: screenWidth * 0.35,
                                      height: screenHeight * 0.28,
                                      margin: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.02,
                                      ),
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            child: Image.network(
                                              movie.largeCoverImage,
                                              width: double.infinity,
                                              height: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            top: 8,
                                            left: 8,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: screenWidth * 0.02,
                                                vertical: screenHeight * 0.005,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.black.withOpacity(
                                                  0.6,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color: AppTheme.yellow,
                                                    size: screenWidth * 0.035,
                                                  ),
                                                  SizedBox(
                                                    width: screenWidth * 0.01,
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      movie.rating.toString(),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: AppTheme
                                                          .darkTheme
                                                          .textTheme
                                                          .titleMedium!
                                                          .copyWith(
                                                            color: Colors.white,
                                                            fontSize:
                                                                screenWidth *
                                                                0.035,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.03),
                            ],
                          );
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
