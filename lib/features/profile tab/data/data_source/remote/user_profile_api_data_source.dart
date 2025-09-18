import 'package:dio/dio.dart';
import 'package:movies/features/profile%20tab/data/data_source/remote/user_profile_remote_data_source.dart';
import 'package:movies/shared/constants/api_constants.dart';
import 'package:movies/update%20profile/data/models/user_profile.dart';

import '../../../../../Auth/login/data/data_sources/local/login_shared_pref_data_source.dart';

class UserProfileApiDataSource implements UserProfileRemoteDataSource {
  final LoginSharedPrefDataSource loginLocalDataSource;
  final Dio dio;

  UserProfileApiDataSource(this.dio, this.loginLocalDataSource);

  @override
  Future<UserProfile> getUserProfile() async {
    try {
      final token = await loginLocalDataSource.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('User is not logged in');
      }

      final uri = '${APIConstants.authBaseURL}/profile';
      final response = await dio.get(
        uri,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200) {
        return UserProfile.fromJson(response.data);
      } else {
        throw Exception('Failed to load user profile');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('User is not logged in');
      } else {
        throw Exception('Dio error: ${e.message}');
      }
    } catch (e) {
      throw Exception('error message: $e');
    }
  }

  Future<void> deleteProfile(String token) async {
    await dio.delete(
      'https://route-movie-apis.vercel.app/profile',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}
