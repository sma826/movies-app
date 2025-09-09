import 'package:dio/dio.dart';
import 'package:movies/update%20profile/data/models/user_profile.dart';

class ProfileApiDataSource {
  final Dio dio;
  final String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4YmRjZGJhZDdmZGMxYWRlOTM3NDMzYSIsImVtYWlsIjoiaGFzc2FuMTJAZ21haWwuY29tIiwiaWF0IjoxNzU3NDI5Mzk4fQ.cAhpyuVwBWlerjUNk6fFufGKx_wX_YhLglgu-WqDemY";
  ProfileApiDataSource(this.dio);

  Future<UserProfile> getProfile(String token) async {
    final response = await dio.get(
      'https://route-movie-apis.vercel.app/profile',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return UserProfile.fromJson(response.data);
  }

  Future<void> patchProfile(String token, Map<String, dynamic> data) async {
    await dio.patch(
      'https://route-movie-apis.vercel.app/profile',
      data: data,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  Future<void> deleteProfile(String token) async {
  await dio.delete(
    'https://route-movie-apis.vercel.app/profile',
    options: Options(headers: {
      'Authorization': 'Bearer $token',
    }),
  );
}
}
