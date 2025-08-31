import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/onboarding/onboarding_screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  runApp(const MoviesApp());
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        OnboardingScreens.nameroute: (context) => const OnboardingScreens(),
      },
       initialRoute: OnboardingScreens.nameroute,
      // theme: ,
      // darkTheme: ,
      // themeMode: ,
    );
  }
}
