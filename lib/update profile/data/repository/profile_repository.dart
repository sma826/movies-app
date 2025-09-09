import 'package:movies/update%20profile/data/data_source/profile_api_data_source.dart';
import 'package:movies/update%20profile/data/models/user_profile.dart';

class ProfileRepository {
  final ProfileApiDataSource dataSource;

  ProfileRepository(this.dataSource);

  Future<UserProfile> fetchProfile(String token) {
    return dataSource.getProfile(token);
  }

  Future<void> updateProfile(String token, UserProfile profile) {
    return dataSource.patchProfile(token, profile.toJson());
  }
  Future<void> deleteProfile(String token) {
  return dataSource.deleteProfile(token);
}
}