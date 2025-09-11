import 'package:movies/onboarding/data/data_source/local/onboarding_local_data_source.dart';
import 'package:movies/shared/constants/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingSharedPrefDataSource implements OnBoardingLocalDataSource{
  @override
  Future<void> saveOnBoarding(bool key) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(CachedConstants.onBoardingKey, key);
  }

  @override
  Future<bool> getOnBoarding() async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(CachedConstants.onBoardingKey) ?? false;
  }
}