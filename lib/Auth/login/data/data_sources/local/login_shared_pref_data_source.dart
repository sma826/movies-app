import 'package:movies/Auth/login/data/data_sources/local/login_local_data_source.dart';
import 'package:movies/shared/constants/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginSharedPrefDataSource implements LoginLocalDataSource {
  @override
  Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(CachedConstants.tokenKey, token);
  }

  @override
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(CachedConstants.tokenKey);
  }
}
