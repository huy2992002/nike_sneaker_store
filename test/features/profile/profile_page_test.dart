import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nike_sneaker_store/components/button/ns_elevated_button.dart';
import 'package:nike_sneaker_store/components/text_form_field/ns_text_form_field.dart';
import 'package:nike_sneaker_store/features/profile/bloc/profile_bloc.dart';
import 'package:nike_sneaker_store/features/profile/bloc/profile_event.dart';
import 'package:nike_sneaker_store/features/profile/bloc/profile_state.dart';
import 'package:nike_sneaker_store/features/profile/view/profile_page.dart';
import 'package:nike_sneaker_store/services/remote/supabase_services.dart';

import '../../utils/mock_supabase.dart';
import '../../utils/ns_pump_widget.dart';

class MockProfileBloc extends MockBloc<ProfileEvent, ProfileState>
    implements ProfileBloc {}

void main() {
  late ProfileBloc profileBloc;
  late Widget profilePage;

  setUp(() {
    profileBloc = MockProfileBloc();
    profilePage = NsPumpWidget(
      home: MultiRepositoryProvider(
        providers: [
          BlocProvider<ProfileBloc>(create: (context) => profileBloc),
          RepositoryProvider<SupabaseServices>(
            create: (context) =>
                SupabaseServices(supabaseClient: MockSupabase()),
          ),
        ],
        child: const ProfilePage(),
      ),
    );
  });

  group('Profile Page Test', () {
    testWidgets(
        'GIVEN the user is signed in '
        'WHEN user has not entered enough information '
        'THEN disable button', (tester) async {
      // GIVEN
      when(() => profileBloc.state).thenReturn(
        const ProfileState(), // canAction == false
      );

      // WHEN
      await tester.pumpWidget(profilePage);

      // THEN
      final button =
          tester.widget<NSElevatedButton>(find.byType(NSElevatedButton));
      expect(button.onPressed, isNull);
    });

    testWidgets(
        'GIVEN the user is signed in '
        'WHEN user is waiting to save data '
        'THEN disable button & information cannot be edited', (tester) async {
      // GIVEN
      when(() => profileBloc.state).thenReturn(
        const ProfileState(buttonStatus: ProfileSaveStatus.loading),
      );

      // WHEN
      await tester.pumpWidget(profilePage);

      // THEN
      final button =
          tester.widget<NSElevatedButton>(find.byType(NSElevatedButton));
      final textFieldName =
          tester.widget<NSTextFormField>(find.byWidgetPredicate(
        (Widget widget) =>
            widget is NSTextFormField && widget.hintText == 'Your Name',
      ));

      final textFieldAddress =
          tester.widget<NSTextFormField>(find.byWidgetPredicate(
        (Widget widget) =>
            widget is NSTextFormField && widget.hintText == 'Location',
      ));
      expect(button.isDisable, isTrue);
      expect(textFieldName.readOnly, isTrue);
      expect(textFieldAddress.readOnly, isTrue);
    });
  });
}
