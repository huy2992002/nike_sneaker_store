import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nike_sneaker_store/features/notification/bloc/notification_bloc.dart';
import 'package:nike_sneaker_store/features/notification/bloc/notification_event.dart';
import 'package:nike_sneaker_store/features/notification/bloc/notification_state.dart';
import 'package:nike_sneaker_store/repository/product_repository.dart';
import 'package:nike_sneaker_store/repository/user_repository.dart';

import '../../repository/mock_product_repository.dart';
import '../../repository/mock_user_repository.dart';
import '../../utils/mock_data.dart';

void main() {
  late ProductRepository productRepository;
  late UserRepository userRepository;
  late NotificationBloc notificationBloc;

  setUp(() {
    productRepository = MockProductRepository();
    userRepository = MockUserRepository();
    notificationBloc = NotificationBloc(productRepository, userRepository);
  });

  group('Cart Bloc Test', () {
    test('initial state is Notification Bloc', () {
      expect(notificationBloc.state, equals(const NotificationState()));
    });

    blocTest(
      'emit list notification when started',
      build: () => notificationBloc,
      act: (bloc) {
        bloc.add(NotificationStarted(userId: 'userId'));
      },
      expect: () => [
        const NotificationState(
          status: NotificationViewStatus.loading,
        ),
        NotificationState(
          notifications: MockData.mockNotifications,
          status: NotificationViewStatus.success,
        ),
      ],
    );

    blocTest(
      'emit message when started failure',
      build: () => notificationBloc,
      act: (bloc) {
        bloc.add(NotificationStarted(userId: ''));
      },
      expect: () => [
        const NotificationState(
          status: NotificationViewStatus.loading,
        ),
        const NotificationState(
          message: 'Exception: An error occurred, please check UserId',
          status: NotificationViewStatus.failure,
        ),
      ],
    );

    blocTest(
      'emit is read when on pressed read notification',
      build: () => notificationBloc,
      seed: () => NotificationState(notifications: MockData.mockNotifications),
      act: (bloc) {
        bloc.add(
            NotificationReadPressed(userId: 'userId', notificationId: '12345'));
      },
      expect: () => [
        NotificationState(
            notifications: MockData.mockNotifications,
            itemStatus: ListNotificationStatus.readLoading),
        NotificationState(notifications: [
          MockData.mockNotifications[0].copyWith(isRead: true)
        ], itemStatus: ListNotificationStatus.readSuccess),
      ],
    );

    blocTest(
      'emit message when on pressed read notification failure',
      build: () => notificationBloc,
      seed: () => NotificationState(notifications: MockData.mockNotifications),
      act: (bloc) {
        bloc.add(NotificationReadPressed(userId: '', notificationId: '12345'));
      },
      expect: () => [
        NotificationState(
            notifications: MockData.mockNotifications,
            itemStatus: ListNotificationStatus.readLoading),
        NotificationState(
          notifications: MockData.mockNotifications,
          itemStatus: ListNotificationStatus.readFailure,
          message: 'Exception: An error occurred, please check UserId',
        ),
      ],
    );

    blocTest(
      'emit list notification empty when on pressed remove all',
      build: () => notificationBloc,
      seed: () => NotificationState(notifications: MockData.mockNotifications),
      act: (bloc) {
        bloc.add(NotificationRemoveAllPressed(userId: 'userId'));
      },
      expect: () => [
        NotificationState(
          notifications: MockData.mockNotifications,
          itemStatus: ListNotificationStatus.removeLoading,
        ),
        const NotificationState(
          // notifications: [],
          itemStatus: ListNotificationStatus.removeSuccess,
        ),
      ],
    );

    blocTest(
      'emit message when on pressed remove all failure',
      build: () => notificationBloc,
      seed: () => NotificationState(notifications: MockData.mockNotifications),
      act: (bloc) {
        bloc.add(NotificationRemoveAllPressed(userId: ''));
      },
      expect: () => [
        NotificationState(
          notifications: MockData.mockNotifications,
          itemStatus: ListNotificationStatus.removeLoading,
        ),
        NotificationState(
          notifications: MockData.mockNotifications,
          itemStatus: ListNotificationStatus.removeFailure,
          message: 'Exception: An error occurred, please check UserId',
        ),
      ],
    );
  });
}
