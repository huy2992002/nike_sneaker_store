import 'package:equatable/equatable.dart';
import 'package:nike_sneaker_store/models/notification_model.dart';

enum NotificationViewStatus { initial, loading, success, failure }

enum ListNotificationStatus {
  initial,
  readLoading,
  readSuccess,
  readFailure,
  removeLoading,
  removeSuccess,
  removeFailure,
}

class NotificationState extends Equatable {
  const NotificationState({
    this.notifications = const [],
    this.status = NotificationViewStatus.initial,
    this.itemStatus = ListNotificationStatus.initial,
    this.message = '',
  });

  final List<NotificationModel> notifications;
  final NotificationViewStatus status;
  final ListNotificationStatus itemStatus;
  final String message;

  NotificationState copyWith({
    List<NotificationModel>? notifications,
    NotificationViewStatus? status,
    ListNotificationStatus? itemStatus,
    String? message,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      status: status ?? this.status,
      itemStatus: itemStatus ?? this.itemStatus,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [notifications, status, message, itemStatus];
}
