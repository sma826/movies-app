import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/profile%20tab/viewModel/user_profile_states.dart';
import 'package:movies/shared/constants/apptheme.dart';
import 'package:movies/shared/constants/assets_manager.dart';
import 'package:movies/update%20profile/view/screens/update_profile_screen.dart';
import 'package:movies/watch_list_&_History/view/widgets/watch_list_tab.dart';
import 'package:movies/watch_list_&_History/view/widgets/history_tab.dart';
import 'package:movies/watch_list_&_History/view_model/watch_list_view_model.dart';
import 'package:movies/watch_list_&_History/view_model/watch_list_states.dart';
import 'package:movies/watch_list_&_History/view_model/history_states.dart';
import 'package:movies/watch_list_&_History/view_model/history_cubit.dart';
import 'package:movies/watch_list_&_History/data/repositories/watch_list_repository.dart';
import 'package:movies/watch_list_&_History/data/repositories/history_repository.dart';
import 'package:movies/watch_list_&_History/data/data_source/remote/watch_list_api_data_source.dart';
import 'package:movies/watch_list_&_History/data/data_source/local/history_local_data_source.dart';

import '../../../Auth/login/view/screens/login_screen.dart';
import '../../../shared/constants/font_manager.dart';
import '../../viewModel/user_profile_view_model.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppTheme.grey,
        body: SafeArea(
          child: BlocBuilder<UserProfileBloc, UserProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return Center(
                  child: Text(
                    'Loading',
                    style: TextStyle(color: AppTheme.white),
                  ),
                );
              } else if (state is ProfileSuccess) {
                return buildLoadedView(context, state);
              } else if (state is ProfileUnauthenticated) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Please log in to view your profile.',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, LoginScreen.routeName);
                        },
                        child: const Text('Go to Login'),
                      ),
                    ],
                  ),
                );
              } else if (state is ProfileError) {
                return Center(
                  child: Text(
                    'Error loading profile.',
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget buildLoadedView(BuildContext context, ProfileSuccess state) {
    final userProfile = state.userProfile;
    final watchListCubit = WatchListCubit(
      repository: MovieListRepository(WatchListAPIDataSource()),
    );
    final historyCubit = HistoryCubit(
      repository: HistoryRepository(HistoryLocalDataSource()),
    );
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(
                          'assets/images/avatar${userProfile.avaterId}.png',
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        userProfile.name,
                        style: const TextStyle(
                          color: AppTheme.white,
                          fontSize: FontSizes.s20,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                  BlocBuilder<WatchListCubit, WatchListState>(
                    bloc: watchListCubit..getAllFavorites(),
                    builder: (context, state) {
                      int count = 0;
                      if (state is WatchListLoaded) {
                        count = state.favorites.length;
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$count',
                            style: const TextStyle(
                              color: AppTheme.white,
                              fontSize: FontSizes.s36,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Roboto',
                            ),
                          ),
                          Text(
                            'Wish List',
                            style: const TextStyle(
                              color: AppTheme.white,
                              fontSize: FontSizes.s24,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  BlocBuilder<HistoryCubit, HistoryState>(
                    bloc: historyCubit..getHistoryMovies(),
                    builder: (context, state) {
                      int count = 0;
                      if (state is HistoryLoaded) {
                        count = state.movies.length;
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$count',
                            style: const TextStyle(
                              color: AppTheme.white,
                              fontSize: FontSizes.s36,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Roboto',
                            ),
                          ),
                          Text(
                            'History',
                            style: const TextStyle(
                              color: AppTheme.white,
                              fontSize: FontSizes.s24,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 23),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => UpdateProfileScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.yellow,
                        foregroundColor: AppTheme.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: FontSizes.s20,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.red,
                        foregroundColor: AppTheme.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Exit',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: FontSizes.s20,
                            ),
                          ),
                          const SizedBox(width: 8),
                          SvgPicture.asset(AssetsManager.exitIcon),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              TabBar(
                indicatorColor: AppTheme.yellow,
                labelColor: AppTheme.white,
                unselectedLabelColor: AppTheme.white,
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: TextStyle(
                  color: AppTheme.white,
                  fontSize: FontSizes.s20,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Roboto',
                ),
                unselectedLabelStyle: TextStyle(
                  color: AppTheme.white,
                  fontSize: FontSizes.s20,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Roboto',
                ),
                tabs: [
                  Tab(
                    icon: SvgPicture.asset(AssetsManager.watchListIcon),
                    text: "Watch List",
                  ),
                  Tab(
                    icon: SvgPicture.asset(AssetsManager.historyIcon),
                    text: "History",
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            children: [
              WatchListTab(
                cubit: watchListCubit,
                onMovieTap: (movie) {
                  Navigator.pushNamed(
                    context,
                    'movie-details',
                    arguments: int.tryParse(movie.movieId),
                  );
                },
              ),
              HistoryTab(
                cubit: historyCubit,
                onMovieTap: (movie) {
                  Navigator.pushNamed(
                    context,
                    'movie-details',
                    arguments: int.tryParse(movie.movieId),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
