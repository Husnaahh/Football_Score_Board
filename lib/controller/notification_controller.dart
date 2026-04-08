import 'package:flutter/material.dart';

import '../model/notification_model.dart';

class NotificationController extends ChangeNotifier {
  final List<NotificationModel> _notifications = [];

  List<NotificationModel> get notifications => _notifications;

  void addNotification(NotificationModel model) {
    _notifications.add(model);
    notifyListeners();
  }
}