import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_sneaker_store/constants/ns_constants.dart';
import 'package:nike_sneaker_store/features/auth/sign_up/bloc/sign_up_event.dart';
import 'package:nike_sneaker_store/features/auth/sign_up/bloc/sign_up_state.dart';
import 'package:nike_sneaker_store/repository/auth_repository.dart';
import 'package:nike_sneaker_store/services/handle_error/error_extension.dart';
import 'package:nike_sneaker_store/utils/enum.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(this.authRepository) : super(const SignUpState()) {
    on<SignUpNameChanged>(onNameChanged);
    on<SignUpEmailChanged>(onEmailChanged);
    on<SignUpPasswordChanged>(onPasswordChanged);
    on<SignUpConfirmPasswordChanged>(onConfirmPasswordChanged);
    on<SubmitSignUpPressed>(onSignUpSubmitted);
  }

  final AuthRepository authRepository;

  Future<void> onNameChanged(
    SignUpNameChanged event,
    Emitter<SignUpState> emit,
  ) async {
    bool isValid = isValidSignUp(
      event.name,
      state.email,
      state.password,
      state.confirmPassword,
    );

    emit(state.copyWith(
      name: event.name,
      isValid: isValid,
      status: FormSubmissionStatus.initial,
    ));
  }

  Future<void> onEmailChanged(
    SignUpEmailChanged event,
    Emitter<SignUpState> emit,
  ) async {
    bool isValid = isValidSignUp(
      state.name,
      event.email,
      state.password,
      state.confirmPassword,
    );

    emit(state.copyWith(
      email: event.email,
      isValid: isValid,
      status: FormSubmissionStatus.initial,
    ));
  }

  Future<void> onPasswordChanged(
    SignUpPasswordChanged event,
    Emitter<SignUpState> emit,
  ) async {
    bool isValid = isValidSignUp(
      state.name,
      state.email,
      event.password,
      state.confirmPassword,
    );

    emit(state.copyWith(
      password: event.password,
      isValid: isValid,
    ));
  }

  Future<void> onConfirmPasswordChanged(
    SignUpConfirmPasswordChanged event,
    Emitter<SignUpState> emit,
  ) async {
    bool isValid = isValidSignUp(
      state.name,
      state.email,
      state.password,
      event.confirmPassword,
    );

    emit(state.copyWith(
      confirmPassword: event.confirmPassword,
      isValid: isValid,
    ));
  }

  Future<void> onSignUpSubmitted(
      SubmitSignUpPressed event, Emitter<SignUpState> emit) async {
    try {
      emit(state.copyWith(status: FormSubmissionStatus.loading));
      await authRepository.signUp(
        name: event.name,
        email: event.email,
        password: event.password,
      );
      emit(state.copyWith(status: FormSubmissionStatus.success));
    } on AuthException catch (e) {
      emit(state.copyWith(
        status: FormSubmissionStatus.failure,
        message: e.getFailure().message,
      ));
    } on SocketException catch (e) {
      emit(state.copyWith(
        status: FormSubmissionStatus.failure,
        message: e.getFailure().message,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FormSubmissionStatus.failure,
        message: e.toString(),
      ));
    }
  }

  bool isValidSignUp(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) {
    return name.isNotEmpty &&
        RegExp(NSConstants.emailPattern).hasMatch(email) &&
        password.length > 5 &&
        confirmPassword == password;
  }
}
