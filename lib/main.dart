import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/Auth/forgotpassword/view/screens/forgot_password_screen.dart';
import 'package:movies/Auth/login/view/screens/login_screen.dart';
import 'package:movies/Auth/register/data/repositories/register_repository.dart';
import 'package:movies/Auth/register/view%20model/register_view_model.dart';
import 'package:movies/Auth/register/view/screens/register_screen.dart';
import 'package:movies/home/view/screens/home_screen.dart';
import 'package:movies/onboarding/view/screens/onboarding_screens.dart';
import 'package:movies/shared/constants/apptheme.dart';
import 'package:movies/update%20profile/view/screens/update_profile_screen.dart';
import 'Auth/register/data/data source/register_api_data_source.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final apiDataSource = RegisterApiDataSource();
  final repository = RegisterRepository(apiDataSource);
  runApp(MoviesApp(repository: repository));
}

class MoviesApp extends StatelessWidget {
  final RegisterRepository repository;

  const MoviesApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterViewModel(repository),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          UpdateProfileScreen.routeName: (_) => const UpdateProfileScreen(),
          OnboardingScreens.routeName: (_) => const OnboardingScreens(),
          LoginScreen.routeName: (_) => LoginScreen(),
          RegisterScreen.routeName: (_) => RegisterScreen(),
          ForgotPasswordScreen.routeName: (_) => ForgotPasswordScreen(),
          HomeScreen.routeName: (_) => HomeScreen(),
        },
        initialRoute: OnboardingScreens.routeName,
        // theme: ,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
      ),
    );
  }
}
