import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/Auth/register/data/repositories/register_repository.dart';
import 'package:movies/Auth/register/view/bloc/register_event.dart';

import '../view/bloc/register_state.dart';

class RegisterViewModel extends Bloc<AuthEvent, RegisterState> {
  final RegisterRepository repository;

  RegisterViewModel(this.repository) : super(RegisterInitial()) {
    on<RegisterEvent>(onRegister);
  }

  Future<void> onRegister(
    RegisterEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());
    try {
      final data = await repository.register(
        name: event.name,
        email: event.email,
        password: event.password,
        confirmPassword: event.confirmPassword,
        phone: event.phone,
        avatarId: event.avatarId,
      );
      emit(RegisterSuccess(data));
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
