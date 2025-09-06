import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final Map<String, dynamic> data;

  RegisterSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class RegisterError extends RegisterState {
  final String errorMessage;

  RegisterError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
