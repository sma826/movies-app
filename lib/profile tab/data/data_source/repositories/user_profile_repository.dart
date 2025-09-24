import 'package:movies/profile%20tab/data/data_source/remote/user_profile_api_data_source.dart';
import 'package:movies/update%20profile/data/models/user_profile.dart';

class UserProfileRepository {
  final UserProfileApiDataSource dataSource;

  UserProfileRepository(this.dataSource);

  Future<UserProfile> getProfileData() async {
    return dataSource.getUserProfile();
  }

  Future<void> deleteProfile(String token) {
    return dataSource.deleteProfile(token);
  }
}
