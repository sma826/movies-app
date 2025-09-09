import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/Auth/login/view/screens/login_screen.dart';
import 'package:movies/update%20profile/data/models/user_profile.dart';
import 'package:movies/update%20profile/data/repository/profile_repository.dart';
import 'package:movies/update%20profile/view%20model/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository repository;
  final String token;

  ProfileCubit(this.repository, this.token) : super(ProfileInitial());

  void fetchProfile() async {
    emit(ProfileLoading());
    try {
      final profile = await repository.fetchProfile(token);
      emit(ProfileSuccess(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  void updateProfile(String name, String phone, int avatarId) async {
    emit(ProfileLoading());
    try {
      final updated = UserProfile(
        id: '',
        name: name,
        phone: phone,
        avaterId: avatarId,
      );
      await repository.updateProfile(token, updated);
      emit(ProfileSuccess(updated));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  void deleteProfile(BuildContext context) async {
    emit(ProfileLoading());
    try {
      await repository.deleteProfile(token);
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
