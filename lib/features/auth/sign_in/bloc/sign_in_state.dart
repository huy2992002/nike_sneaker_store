import 'package:equatable/equatable.dart';
import 'package:nike_sneaker_store/utils/enum.dart';

class SignInState extends Equatable {
  const SignInState({
    this.status = FormSubmissionStatus.initial,
    this.email = '',
    this.password = '',
    this.isValid = false,
    this.message,
  });

  final FormSubmissionStatus status;
  final String email;
  final String password;
  final String? message;
  final bool isValid;

  SignInState copyWith({
    FormSubmissionStatus? status,
    String? email,
    String? password,
    String? message,
    bool? isValid,
  }) {
    return SignInState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      message: message ?? this.message,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object?> get props => [status, email, password, isValid, message];
}
