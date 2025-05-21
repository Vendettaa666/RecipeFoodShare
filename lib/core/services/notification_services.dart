// services/notification_service.dart
import '../../models/app_notification.dart';

class NotificationService {
  static List<AppNotification> getAllNotifications() {
    return [
      AppNotification(
        id: '1',
        title: 'New Recipe Added',
        description: 'A new recipe has been added to your feed.',
        timestamp: DateTime.now().subtract(Duration(days: 1)),
      ),
      AppNotification(
        id: '2',
        title: 'Recipe Liked',
        description: 'Your recipe has been liked by a user.',
        timestamp: DateTime.now().subtract(Duration(hours: 2)),
      ),
      AppNotification(
        id: '3',
        title: 'Comment on Recipe',
        description: 'A user has commented on your recipe.',
        timestamp: DateTime.now().subtract(Duration(hours: 3)),
      ),
      AppNotification(
        id: '4',
        title: 'New Follower',
        description: 'A new follower has started following you.',
        timestamp: DateTime.now().subtract(Duration(days: 2)),
      ),
      AppNotification(
        id: '5',
        title: 'Recipe Shared',
        description: 'Your recipe has been shared on social media.',
        timestamp: DateTime.now().subtract(Duration(hours: 4)),
      ),
    ];
  }
}