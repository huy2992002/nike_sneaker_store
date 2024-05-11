import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nike_sneaker_store/components/button/ns_elevated_button.dart';
import 'package:nike_sneaker_store/features/auth/sign_up/bloc/sign_up_bloc.dart';
import 'package:nike_sneaker_store/features/auth/sign_up/bloc/sign_up_event.dart';
import 'package:nike_sneaker_store/features/auth/sign_up/bloc/sign_up_state.dart';
import 'package:nike_sneaker_store/features/auth/sign_up/view/sign_up_page.dart';
import 'package:nike_sneaker_store/utils/enum.dart';

import '../../../utils/ns_pump_widget.dart';

class MockSignUpBloc extends MockBloc<SignUpEvent, SignUpState>
    implements SignUpBloc {}

void main() {
  late SignUpBloc signUpBloc;
  late Widget signUpPage;

  setUp(() {
    signUpBloc = MockSignUpBloc();
    signUpPage = NsPumpWidget(
      home: BlocProvider.value(
        value: signUpBloc,
        child: const SignUpPage(),
      ),
    );
  });

  group('Sign Up Page Test', () {
    testWidgets(
        'GIVEN user wants to sign up '
        'WHEN user has not filled in information yet '
        'THEN button is disabled', (tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(1080, 1920);
      // GIVEN
      when(() => signUpBloc.state)
          .thenReturn(const SignUpState()); // isValid == false

      // WHEN
      await tester.pumpWidget(signUpPage);
      await tester.pumpAndSettle();

      // THEN
      final button =
          tester.widget<NSElevatedButton>(find.byType(NSElevatedButton));
      expect(button.onPressed, null);
    });

    testWidgets(
        'GIVEN user wants to sign up '
        'WHEN user pressed the sign up button '
        'THEN button is disabled & with status loading', (tester) async {
      // GIVEN
      when(() => signUpBloc.state)
          .thenReturn(const SignUpState(status: FormSubmissionStatus.loading));

      // WHEN
      await tester.pumpWidget(signUpPage);

      // THEN
      final button =
          tester.widget<NSElevatedButton>(find.byType(NSElevatedButton));
      expect(button.isDisable, true);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
        'GIVEN user wants to sign up '
        'WHEN user has filled in the correct information '
        'THEN user presses the button and receives an event', (tester) async {
      // GIVEN
      when(() => signUpBloc.state).thenReturn(const SignUpState(isValid: true));

      // WHEN
      await tester.pumpWidget(signUpPage);

      // THEN
      await tester.tap(find.byType(NSElevatedButton));

      verify(() => signUpBloc.add(
          SubmitSignUpPressed(name: '', email: '', password: ''))).called(1);
    });

    testWidgets(
        'GIVEN user enters the SignInPage '
        'WHEN user login failed '
        'THEN shows SnackBar when status is submission failure',
        (tester) async {
      // GIVEN
      whenListen(
        signUpBloc,
        Stream.fromIterable([
          const SignUpState(status: FormSubmissionStatus.loading),
          const SignUpState(status: FormSubmissionStatus.failure),
        ]),
        initialState: const SignUpState(),
      );

      // WHEN
      await tester.pumpWidget(signUpPage);

      // THEN
      await tester.pump();
      expect(find.byType(SnackBar), findsOneWidget);
    });
  });
}
