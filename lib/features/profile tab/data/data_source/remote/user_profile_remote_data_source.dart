import 'package:movies/update%20profile/data/models/user_profile.dart';

abstract class UserProfileRemoteDataSource {
  Future<UserProfile> getUserProfile();
}
