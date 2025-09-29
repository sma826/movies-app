import 'package:dio/dio.dart';
import 'package:movies/Auth/login/data/data_sources/remote/login_remote_data_source.dart';
import 'package:movies/Auth/login/data/models/login_request.dart';
import 'package:movies/Auth/login/data/models/login_response.dart';
import 'package:movies/shared/constants/api_constants.dart';

class LoginApiDataSource implements LoginRemoteDataSource {
  final Dio _dio = Dio(BaseOptions(baseUrl: APIConstants.authBaseURL));

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    final response = await _dio.post(
      APIConstants.loginEndpoint,
      data: request.toJson(),
    );
    return LoginResponse.fromJson(response.data);
  }
}
