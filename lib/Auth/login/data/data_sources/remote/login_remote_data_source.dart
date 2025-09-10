import 'package:movies/Auth/login/data/models/login_request.dart';
import 'package:movies/Auth/login/data/models/login_response.dart';

abstract class LoginRemoteDataSource {
  Future<LoginResponse> login(LoginRequest request);
}
