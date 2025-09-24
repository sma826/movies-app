import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/profile%20tab/data/data_source/repositories/user_profile_repository.dart';
import 'package:movies/profile%20tab/viewModel/user_profile_event.dart';
import 'package:movies/profile%20tab/viewModel/user_profile_states.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserProfileRepository userProfileRepository;

  // final String token;

  UserProfileBloc({required this.userProfileRepository})
    : super(ProfileInitial()) {
    on<LoadProfile>(onLoadProfile);
    add(LoadProfile());
  }

  void onLoadProfile(LoadProfile event, Emitter<UserProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final user = await userProfileRepository.getProfileData();
      log('loaded user : ${user.name}');
      emit(ProfileSuccess(userProfile: user));
    } catch (e, stack) {
      log('error while loading : $e');
      log(stack as String);
      if (e.toString().contains('User is not logged in')) {
        emit(ProfileUnauthenticated());
      } else {
        emit(ProfileError());
      }
    }
  }

  // void deleteProfile(LoadProfile event, Emitter<UserProfileState> emit, BuildContext context) async {
  //   emit(ProfileLoading());
  //   try {
  //     await userProfileRepository.deleteProfile(token);
  //     Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  //   } catch (_) {
  //     emit(ProfileError());
  //   }
  // }
}
