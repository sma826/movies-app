import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/Auth/login/data/models/login_request.dart';
import 'package:movies/Auth/login/data/repositories/login_repository.dart';
import 'package:movies/Auth/login/viewModel/login_states.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final LoginRepository _loginRepository = LoginRepository();

  Future<void> login(LoginRequest request) async {
    emit(LoginLoading());
    try {
      await _loginRepository.login(request);
      emit(LoginSuccess());
    } catch (error) {
      emit(LoginError(error.toString()));
    }
  }
}
