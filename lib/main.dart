import 'package:flutter/material.dart';
import 'package:movies/shared/constants/apptheme.dart';
import 'package:movies/update%20profile/view/screens/update_profile_screen.dart';
import 'package:movies/onboarding/view/screens/onboarding_screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MoviesApp());
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        UpdateProfileScreen.routeName: (_) => const UpdateProfileScreen(),
        OnboardingScreens.routeName: (_) => const OnboardingScreens(),
      },
      initialRoute: OnboardingScreens.routeName,
      // theme: ,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
    );
  }
}
