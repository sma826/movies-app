import 'package:movies/update%20profile/data/models/user_profile.dart';

abstract class UserProfileState {}

class ProfileInitial extends UserProfileState {}

class ProfileLoading extends UserProfileState {}

class ProfileSuccess extends UserProfileState {
  final UserProfile userProfile;

  ProfileSuccess({required this.userProfile});
}

class ProfileError extends UserProfileState {}

class ProfileUnauthenticated extends UserProfileState {
  List<Object?> get props => [];
}
