import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nike_sneaker_store/features/notification/bloc/notification_bloc.dart';
import 'package:nike_sneaker_store/features/notification/bloc/notification_event.dart';
import 'package:nike_sneaker_store/features/notification/bloc/notification_state.dart';
import 'package:nike_sneaker_store/features/notification/view/notifications_page.dart';
import 'package:nike_sneaker_store/features/notification/view/widgets/card_notification.dart';
import 'package:nike_sneaker_store/resources/ns_color.dart';
import 'package:nike_sneaker_store/services/remote/supabase_services.dart';

import '../../utils/mock_data.dart';
import '../../utils/mock_supabase.dart';
import '../../utils/ns_pump_widget.dart';

class MockNotificationBloc
    extends MockBloc<NotificationEvent, NotificationState>
    implements NotificationBloc {}

void main() {
  late NotificationBloc notificationBloc;
  late Widget notificationPage;

  setUp(() {
    notificationBloc = MockNotificationBloc();
    notificationPage = NsPumpWidget(
        home: MultiBlocProvider(
      providers: [
        RepositoryProvider<SupabaseServices>(
          create: (context) => SupabaseServices(
            supabaseClient: MockSupabase(),
          ),
        ),
        BlocProvider<NotificationBloc>(
          create: (context) => notificationBloc,
        ),
      ],
      child: const NotificationsPage(),
    ));
  });

  group('Notification Page Test', () {
    testWidgets(
        'GIVEN the user is signed in '
        'WHEN there is no notifications yet '
        'THEN displays text that there are no notifications', (tester) async {
      // GIVEN
      when(() => notificationBloc.state).thenReturn(
        const NotificationState(), // notifications = []
      );

      // WHEN
      await tester.pumpWidget(notificationPage);

      // THEN
      expect(find.byType(CardNotification), findsNothing);
      expect(find.text('Currently there are no notification'), findsOneWidget);
    });

    testWidgets(
        'GIVEN the user is signed in '
        'WHEN users want to read notifications '
        'THEN displays unread notifications in color', (tester) async {
      // GIVEN
      when(() => notificationBloc.state).thenReturn(
        NotificationState(notifications: MockData.mockNotifications),
      );

      // WHEN
      await tester.pumpWidget(notificationPage);

      // Find the text widget
      final textTitle =
          tester.widget<Text>(find.text(MockData.mockNotifications[0].title));
      expect(textTitle.style?.color, NSColor.primary);
    });

    testWidgets(
        'GIVEN the user is signed in '
        'WHEN users want to read notifications '
        'THEN displays the color of notifications that have been read',
        (tester) async {
      // GIVEN
      when(() => notificationBloc.state).thenReturn(
        NotificationState(
            notifications: [MockData.mockNotifications[0]..isRead = true]),
      );

      // WHEN
      await tester.pumpWidget(notificationPage);

      // Find the text widget
      final textTitle =
          tester.widget<Text>(find.text(MockData.mockNotifications[0].title));
      expect(textTitle.style?.color, NSColor.onPrimaryContainer);
    });
  });
}
