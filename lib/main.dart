import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/Auth/forgotpassword/view/screens/forgot_password_screen.dart';
import 'package:movies/Auth/login/data/repositories/login_repository.dart';
import 'package:movies/Auth/login/view/screens/login_screen.dart';
import 'package:movies/Auth/login/viewModel/login_view_model.dart';
import 'package:movies/Auth/register/data/repositories/register_repository.dart';
import 'package:movies/Auth/register/view%20model/register_view_model.dart';
import 'package:movies/Auth/register/view/screens/register_screen.dart';
import 'package:movies/home/view/screens/home_screen.dart';
import 'package:movies/movie_details/view/screens/movie_details_screen.dart';
import 'package:movies/onboarding/data/data_source/local/onboarding_local_data_source.dart';
import 'package:movies/onboarding/data/data_source/local/onboarding_shared_pref_data_source.dart';
import 'package:movies/onboarding/view/screens/onboarding_screens.dart';
import 'package:movies/shared/bloc_observer.dart';
import 'package:movies/shared/constants/apptheme.dart';
import 'package:movies/update%20profile/view/screens/update_profile_screen.dart';
import 'Auth/register/data/data source/register_api_data_source.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  final apiDataSource = RegisterApiDataSource();
  final registerRepository = RegisterRepository(apiDataSource);
  final loginRepository = LoginRepository();
  final OnBoardingLocalDataSource onBoardingLocal =
      OnBoardingSharedPrefDataSource();
  final bool onBoardingKey = await onBoardingLocal.getOnBoarding();

  runApp(
    MoviesApp(
      registerRepository: registerRepository,
      loginRepository: loginRepository,
      onBoardingKey: onBoardingKey,
    ),
  );
}

class MoviesApp extends StatelessWidget {
  final RegisterRepository registerRepository;
  final LoginRepository loginRepository;
  final bool onBoardingKey;

  const MoviesApp({
    super.key,
    required this.registerRepository,
    required this.loginRepository,
    required this.onBoardingKey,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterViewModel>(
          create: (_) => RegisterViewModel(registerRepository),
        ),
        BlocProvider<LoginCubit>(create: (_) => LoginCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          UpdateProfileScreen.routeName: (_) => const UpdateProfileScreen(),
          OnboardingScreens.routeName: (_) => const OnboardingScreens(),
          LoginScreen.routeName: (_) => LoginScreen(),
          RegisterScreen.routeName: (_) => RegisterScreen(),
          ForgotPasswordScreen.routeName: (_) => ForgotPasswordScreen(),
          HomeScreen.routeName: (_) => HomeScreen(),
          MovieDetailsScreen.routeName: (_) => MovieDetailsScreen(),
        },
        initialRoute: onBoardingKey
            ? LoginScreen.routeName
            : OnboardingScreens.routeName,
        // theme: ,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
      ),
    );
  }
}
