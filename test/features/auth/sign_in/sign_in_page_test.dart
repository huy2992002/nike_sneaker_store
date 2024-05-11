import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nike_sneaker_store/components/button/ns_elevated_button.dart';
import 'package:nike_sneaker_store/features/auth/sign_in/bloc/sign_in_bloc.dart';
import 'package:nike_sneaker_store/features/auth/sign_in/bloc/sign_in_event.dart';
import 'package:nike_sneaker_store/features/auth/sign_in/bloc/sign_in_state.dart';
import 'package:nike_sneaker_store/features/auth/sign_in/view/sign_in_page.dart';
import 'package:nike_sneaker_store/utils/enum.dart';

import '../../../utils/ns_pump_widget.dart';

class MockSignInBloc extends MockBloc<SignInEvent, SignInState>
    implements SignInBloc {}

void main() {
  late SignInBloc signInBloc;
  late Widget signInPage;

  setUp(() {
    signInBloc = MockSignInBloc();
    signInPage = NsPumpWidget(
      home: BlocProvider.value(
        value: signInBloc,
        child: const SignInPage(),
      ),
    );
  });

  group('Sign In Page Test', () {
    testWidgets(
        'GIVEN user enters the SignInPage '
        'WHEN user has not filled in information yet '
        'THEN button is disabled', (tester) async {
      // GIVEN
      when(() => signInBloc.state)
          .thenReturn(const SignInState()); // isValid == false

      // WHEN
      await tester.pumpWidget(signInPage);

      // THEN
      final button =
          tester.widget<NSElevatedButton>(find.byType(NSElevatedButton));
      expect(button.onPressed, null);
    });

    testWidgets(
        'GIVEN user enters the SignInPage '
        'WHEN user pressed the login button '
        'THEN button is disabled & with status loading', (tester) async {
      // GIVEN
      when(() => signInBloc.state)
          .thenReturn(const SignInState(status: FormSubmissionStatus.loading));

      // WHEN
      await tester.pumpWidget(signInPage);

      // THEN
      final button =
          tester.widget<NSElevatedButton>(find.byType(NSElevatedButton));
      expect(button.isDisable, true);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
        'GIVEN user enters the SignInPage '
        'WHEN user has filled in the correct information '
        'THEN user presses the button and receives an event', (tester) async {
      // GIVEN
      when(() => signInBloc.state).thenReturn(const SignInState(isValid: true));

      // WHEN
      await tester.pumpWidget(signInPage);

      // THEN
      await tester.tap(find.byType(NSElevatedButton));
      verify(() => signInBloc.add(SubmitSignInPressed(email: '', password: '')))
          .called(1);
    });

    testWidgets(
        'GIVEN user enters the SignInPage '
        'WHEN user login failed '
        'THEN shows SnackBar when status is submission failure',
        (tester) async {
      // GIVEN
      whenListen(
        signInBloc,
        Stream.fromIterable([
          const SignInState(status: FormSubmissionStatus.loading),
          const SignInState(status: FormSubmissionStatus.failure),
        ]),
        initialState: const SignInState(),
      );

      // WHEN
      await tester.pumpWidget(signInPage);

      // THEN
      await tester.pump();
      expect(find.byType(SnackBar), findsOneWidget);
    });
  });
}
