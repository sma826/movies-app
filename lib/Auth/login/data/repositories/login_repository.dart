import 'package:movies/Auth/login/data/data_sources/local/login_local_data_source.dart';
import 'package:movies/Auth/login/data/data_sources/local/login_shared_pref_data_source.dart';
import 'package:movies/Auth/login/data/data_sources/remote/login_api_data_source.dart';
import 'package:movies/Auth/login/data/data_sources/remote/login_remote_data_source.dart';
import 'package:movies/Auth/login/data/models/login_request.dart';
import 'package:movies/Auth/login/data/models/login_response.dart';

class LoginRepository {
  final LoginRemoteDataSource _remoteDataSource = LoginApiDataSource();
  final LoginLocalDataSource _localDataSource = LoginSharedPrefDataSource();

  Future<LoginResponse> login(LoginRequest request) async {
    final LoginResponse response = await _remoteDataSource.login(request);
    await _localDataSource.saveToken(response.token!);
    return response;
  }
}
