import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {}

class NotificationStarted extends NotificationEvent {
  NotificationStarted({required this.userId});

  final String userId;
  @override
  List<Object?> get props => [userId];
}

class NotificationReadPressed extends NotificationEvent {
  NotificationReadPressed({required this.userId, required this.notificationId});

  final String userId;
  final String notificationId;

  @override
  List<Object?> get props => [userId, notificationId];
}

class NotificationRemoveAllPressed extends NotificationEvent {
  NotificationRemoveAllPressed({required this.userId});

  final String userId;

  @override
  List<Object?> get props => [userId];
}
