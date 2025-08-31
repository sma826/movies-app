import 'package:flutter/material.dart';
import 'package:movies/onboarding/onboarding_item.dart';
import 'package:movies/onboarding/onboariding_data.dart';
import 'package:movies/shared/constants/assets_manager.dart';


class OnboardingScreens extends StatefulWidget {
  static const String nameroute = '/onboarding';
  const OnboardingScreens({super.key});

  @override
  State<OnboardingScreens> createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  List<OnboaridingData> data = [
    OnboaridingData(
      image: AssetsManager.onboarding1,
      title: 'Find Your Next Favorite Movie Here',
      description:
          'Get access to a huge library of movies to suit all tastes. You will surely like it.',
    ),
    OnboaridingData(
      image: AssetsManager.onboarding2,
      title: 'Discover Movies',
      description:
          'Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.',
    ),
    OnboaridingData(
      image: AssetsManager.onboarding3,
      title: 'Explore All Genres',
      description:
          'Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.',
    ),
    OnboaridingData(
      image: AssetsManager.onboarding4,
      title: 'Create Watchlists',
      description:
          'Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.',
    ),
    OnboaridingData(
      image: AssetsManager.onboarding5,
      title: 'Rate, Review, and Learn',
      description:
          "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.",
    ),
    OnboaridingData(
      image: AssetsManager.onboarding6,
      title: 'Start Watching Now',
      description: '',
    ),
  ];
    int currentIndex =0;
 PageController pageController = PageController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(body:PageView.builder(
      controller: pageController,
      onPageChanged: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      itemBuilder: (context, index) => OnboardingItem(
        ontap: nextPage,
        data: data[index],
        currentIndex: index,
        totalPages: data.length,
        controller: pageController,
      ),
      itemCount: data.length,
    ));
  }


   void nextPage() {
    if (currentIndex < data.length - 1) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } 
  }

}
