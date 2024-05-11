import 'package:equatable/equatable.dart';
import 'package:nike_sneaker_store/utils/enum.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.status = FormSubmissionStatus.initial,
    this.name = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.isValid = false,
    this.message,
  });

  final FormSubmissionStatus status;
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String? message;
  final bool isValid;

  SignUpState copyWith({
    FormSubmissionStatus? status,
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    String? message,
    bool? isValid,
  }) {
    return SignUpState(
      status: status ?? this.status,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      message: message ?? this.message,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object?> get props => [
        status,
        name,
        email,
        password,
        confirmPassword,
        message,
        isValid,
      ];
}
