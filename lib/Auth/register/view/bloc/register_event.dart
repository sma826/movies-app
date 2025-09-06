import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String phone;
  final int avatarId;

  RegisterEvent(
    this.name,
    this.email,
    this.password,
    this.confirmPassword,
    this.phone,
    this.avatarId,
  );

  @override
  List<Object?> get props => [
    name,
    email,
    password,
    confirmPassword,
    phone,
    avatarId,
  ];
}
