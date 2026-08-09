abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationSuccess extends NotificationState {
  final int count;

  NotificationSuccess(this.count);
}

class NotificationFailure extends NotificationState {
  final String error;

  NotificationFailure(this.error);
}
