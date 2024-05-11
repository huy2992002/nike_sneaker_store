import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nike_sneaker_store/features/auth/sign_up/bloc/sign_up_bloc.dart';
import 'package:nike_sneaker_store/features/auth/sign_up/bloc/sign_up_event.dart';
import 'package:nike_sneaker_store/features/auth/sign_up/bloc/sign_up_state.dart';
import 'package:nike_sneaker_store/repository/auth_repository.dart';
import 'package:nike_sneaker_store/utils/enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../repository/mock_auth_repository.dart';

class MockContext extends Fake implements BuildContext {}

class MockSignUpBloc extends Fake implements SignUpBloc {}

void main() {
  group('Sign Up Bloc Test', () {
    late AuthRepository authRepository;
    late SignUpBloc signUpBloc;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      authRepository = MockAuthRepository();
      signUpBloc = SignUpBloc(authRepository);
    });

    test('initial state is SignUpState', () {
      expect(signUpBloc.state, equals(const SignUpState()));
    });

    blocTest(
      'emits value [name] when name changed',
      build: () => signUpBloc,
      act: (bloc) {
        bloc.add(SignUpNameChanged(name: 'name'));
      },
      expect: () => [
        const SignUpState(name: 'name'),
      ],
    );

    blocTest(
      'emits value [email] when email changed',
      build: () => signUpBloc,
      act: (bloc) {
        bloc.add(
          SignUpEmailChanged(email: 'email@gmail.com'),
        );
      },
      expect: () => [
        const SignUpState(email: 'email@gmail.com'),
      ],
    );

    blocTest(
      'emits value [password] when password changed',
      build: () => signUpBloc,
      act: (bloc) {
        bloc.add(
          SignUpPasswordChanged(password: '123456'),
        );
      },
      expect: () => [
        const SignUpState(password: '123456'),
      ],
    );

    blocTest(
      'emits value [confirmPassword] when confirmPassword changed',
      build: () => signUpBloc,
      act: (bloc) {
        bloc.add(
          SignUpConfirmPasswordChanged(confirmPassword: '123456'),
        );
      },
      expect: () => [
        const SignUpState(confirmPassword: '123456'),
      ],
    );

    blocTest(
      'GIVEN user wants to sign up an account '
      'WHEN user implement event sign up '
      'THEN user sign up success',
      // GIVEN
      build: () => signUpBloc,
      act: (bloc) {
        String name = 'test';
        String email = 'testNewAccount@gmail.com';
        String password = 'password';

        bloc.add(
          SubmitSignUpPressed(name: name, email: email, password: password),
        );
      },
      expect: () => [
        // WHEN
        const SignUpState(status: FormSubmissionStatus.loading),
        // THEN
        const SignUpState(status: FormSubmissionStatus.success),
      ],
    );

    blocTest(
      'GIVEN user wants to sign up an account '
      'WHEN user implement event sign up '
      'THEN user sign up fail with email already exists',
      // GIVEN
      build: () => signUpBloc,
      act: (bloc) {
        String name = 'test';
        String email = 'testSignIn@gmail.com';
        String password = 'password';

        bloc.add(
          SubmitSignUpPressed(name: name, email: email, password: password),
        );
      },
      expect: () => [
        // WHEN
        const SignUpState(status: FormSubmissionStatus.loading),
        // THEN
        const SignUpState(
            status: FormSubmissionStatus.failure,
            message: 'Exception: User already exists'),
      ],
    );
  });
}
