// models/app_notification.dart
class AppNotification {
  final String id;
  final String title;
  final String description;
  final DateTime timestamp;

  AppNotification({
    required this.id,
    required this.title,
    required this.description,
    required this.timestamp,
  });
}