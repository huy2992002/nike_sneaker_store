import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {}

class SubmitSignUpPressed extends SignUpEvent {
  SubmitSignUpPressed(
      {required this.name, required this.email, required this.password});
  final String name;
  final String email;
  final String password;

  @override
  List<Object?> get props => [name, email, password];
}

class SignUpNameChanged extends SignUpEvent {
  SignUpNameChanged({required this.name});

  final String name;

  @override
  List<Object?> get props => [name];
}

class SignUpEmailChanged extends SignUpEvent {
  SignUpEmailChanged({required this.email});

  final String email;

  @override
  List<Object?> get props => [email];
}

class SignUpPasswordChanged extends SignUpEvent {
  SignUpPasswordChanged({required this.password});

  final String password;

  @override
  List<Object?> get props => [password];
}

class SignUpConfirmPasswordChanged extends SignUpEvent {
  SignUpConfirmPasswordChanged({required this.confirmPassword});

  final String confirmPassword;

  @override
  List<Object?> get props => [confirmPassword];
}
