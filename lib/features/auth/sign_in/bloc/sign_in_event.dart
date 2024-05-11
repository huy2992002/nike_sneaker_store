import 'package:equatable/equatable.dart';

abstract class SignInEvent extends Equatable {}

class SubmitSignInPressed extends SignInEvent {
  SubmitSignInPressed({required this.email, required this.password});
  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

class SignInEmailChanged extends SignInEvent {
  SignInEmailChanged({required this.email});

  final String email;

  @override
  List<Object?> get props => [email];
}

class SignInPasswordChanged extends SignInEvent {
  SignInPasswordChanged({required this.password});

  final String password;

  @override
  List<Object?> get props => [password];
}
