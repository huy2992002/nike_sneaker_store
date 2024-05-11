import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nike_sneaker_store/features/auth/sign_in/bloc/sign_in_bloc.dart';
import 'package:nike_sneaker_store/features/auth/sign_in/bloc/sign_in_event.dart';
import 'package:nike_sneaker_store/features/auth/sign_in/bloc/sign_in_state.dart';
import 'package:nike_sneaker_store/repository/auth_repository.dart';
import 'package:nike_sneaker_store/utils/enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../repository/mock_auth_repository.dart';

void main() {
  group('SignInBloc', () {
    late AuthRepository authRepository;
    late SignInBloc signInBloc;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      authRepository = MockAuthRepository();
      signInBloc = SignInBloc(authRepository);
    });

    test('initial state is SignInState', () {
      expect(signInBloc.state, equals(const SignInState()));
    });

    blocTest(
      'emits value [email] when email changed',
      build: () => signInBloc,
      seed: () => const SignInState(password: '123456'),
      act: (bloc) {
        bloc.add(SignInEmailChanged(email: 'email@gmail.com'));
      },
      expect: () => [
        const SignInState(
          email: 'email@gmail.com',
          password: '123456',
          isValid: true,
        ),
      ],
    );

    blocTest(
      'emits value [password] when password changed',
      build: () => signInBloc,
      seed: () => const SignInState(email: 'email@gmail.com'),
      act: (bloc) {
        bloc.add(
          SignInPasswordChanged(password: '123456'),
        );
      },
      expect: () => [
        const SignInState(
          email: 'email@gmail.com',
          password: '123456',
          isValid: true,
        ),
      ],
    );

    blocTest(
      'GIVEN user is not sign in '
      'WHEN user implement event sign in '
      'THEN user sign in success',
      // GIVEN
      build: () => signInBloc,
      act: (bloc) {
        String email = 'testSignIn@gmail.com';
        String password = 'password';

        bloc.add(
          SubmitSignInPressed(email: email, password: password),
        );
      },
      expect: () => [
        // WHEN
        const SignInState(status: FormSubmissionStatus.loading),
        // THEN
        const SignInState(status: FormSubmissionStatus.success),
      ],
    );

    blocTest(
      'GIVEN user is not sign in '
      'WHEN user implement event sign in '
      'THEN user sign in failure',
      // GIVEN
      build: () => signInBloc,
      act: (bloc) {
        String email = 'testSignInFaild@gmail.com';
        String password = 'password';

        bloc.add(
          SubmitSignInPressed(email: email, password: password),
        );
      },
      expect: () => [
        // WHEN
        const SignInState(status: FormSubmissionStatus.loading),
        // THEN
        const SignInState(
            status: FormSubmissionStatus.failure,
            message: 'Exception: Invalid login credentials'),
      ],
    );
  });
}
