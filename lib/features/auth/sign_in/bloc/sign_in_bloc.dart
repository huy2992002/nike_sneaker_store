import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_sneaker_store/constants/ns_constants.dart';
import 'package:nike_sneaker_store/features/auth/sign_in/bloc/sign_in_event.dart';
import 'package:nike_sneaker_store/features/auth/sign_in/bloc/sign_in_state.dart';
import 'package:nike_sneaker_store/repository/auth_repository.dart';
import 'package:nike_sneaker_store/services/handle_error/error_extension.dart';
import 'package:nike_sneaker_store/utils/enum.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc(this.authRepository) : super(const SignInState()) {
    on<SignInEmailChanged>(onEmailChanged);
    on<SignInPasswordChanged>(onPasswordChanged);
    on<SubmitSignInPressed>(onLoginSubmitted);
  }

  final AuthRepository authRepository;

  Future<void> onEmailChanged(
    SignInEmailChanged event,
    Emitter<SignInState> emit,
  ) async {
    String email = event.email;
    String password = state.password;
    bool isValid = isValidSignIn(
      email,
      password,
    );

    emit(state.copyWith(
      email: email,
      isValid: isValid,
      status: FormSubmissionStatus.initial,
    ));
  }

  Future<void> onPasswordChanged(
    SignInPasswordChanged event,
    Emitter<SignInState> emit,
  ) async {
    String email = state.email;
    String password = event.password;
    bool isValid = isValidSignIn(
      email,
      password,
    );

    emit(state.copyWith(
      password: password,
      isValid: isValid,
      status: FormSubmissionStatus.initial,
    ));
  }

  Future<void> onLoginSubmitted(
      SubmitSignInPressed event, Emitter<SignInState> emit) async {
    try {
      emit(state.copyWith(status: FormSubmissionStatus.loading));
      await authRepository.signIn(
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

  bool isValidSignIn(
    String email,
    String password,
  ) {
    return RegExp(NSConstants.emailPattern).hasMatch(email) &&
        password.length > 5;
  }
}
