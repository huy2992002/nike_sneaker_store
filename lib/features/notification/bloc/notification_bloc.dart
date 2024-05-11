// ignore_for_file: cascade_invocations, avoid_function_literals_in_foreach_calls

import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_sneaker_store/features/notification/bloc/notification_event.dart';
import 'package:nike_sneaker_store/features/notification/bloc/notification_state.dart';
import 'package:nike_sneaker_store/models/user_model.dart';
import 'package:nike_sneaker_store/repository/product_repository.dart';
import 'package:nike_sneaker_store/repository/user_repository.dart';
import 'package:nike_sneaker_store/services/handle_error/error_extension.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc(this.productRepository, this.userRepository)
      : super(const NotificationState()) {
    on<NotificationStarted>(_onStarted);
    on<NotificationReadPressed>(_onReadNotification);
    on<NotificationRemoveAllPressed>(_onRemoveAll);
  }

  final ProductRepository productRepository;
  final UserRepository userRepository;

  Future<void> _onStarted(
      NotificationStarted event, Emitter<NotificationState> emit) async {
    emit(state.copyWith(status: NotificationViewStatus.loading));
    try {
      final notifications =
          await productRepository.fetchNotifications(event.userId);
      emit(state.copyWith(
        status: NotificationViewStatus.success,
        notifications: notifications,
      ));
    } on SocketException catch (e) {
      emit(state.copyWith(
        status: NotificationViewStatus.failure,
        message: e.getFailure().message,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: NotificationViewStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onReadNotification(
      NotificationReadPressed event, Emitter<NotificationState> emit) async {
    emit(state.copyWith(itemStatus: ListNotificationStatus.readLoading));
    try {
      final notifications = [...state.notifications];
      notifications.forEach((e) {
        if (e.uuid == event.notificationId) {
          e.isRead = true;
        }
      });
      await userRepository.updateInformationUser(UserModel(
        uuid: event.userId,
        notifications: notifications,
      ));
      emit(state.copyWith(
        notifications: notifications,
        itemStatus: ListNotificationStatus.readSuccess,
      ));
    } on SocketException catch (e) {
      emit(state.copyWith(
        itemStatus: ListNotificationStatus.readFailure,
        message: e.getFailure().message,
      ));
    } catch (e) {
      emit(state.copyWith(
        itemStatus: ListNotificationStatus.readFailure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onRemoveAll(NotificationRemoveAllPressed event,
      Emitter<NotificationState> emit) async {
    emit(state.copyWith(itemStatus: ListNotificationStatus.removeLoading));

    try {
      await userRepository.updateInformationUser(UserModel(
        uuid: event.userId,
        notifications: const [],
      ));
      emit(state.copyWith(
        itemStatus: ListNotificationStatus.removeSuccess,
        notifications: [],
      ));
    } on SocketException catch (e) {
      emit(state.copyWith(
        itemStatus: ListNotificationStatus.removeFailure,
        message: e.getFailure().message,
      ));
    } catch (e) {
      emit(state.copyWith(
        itemStatus: ListNotificationStatus.removeFailure,
        message: e.toString(),
      ));
    }
  }
}
