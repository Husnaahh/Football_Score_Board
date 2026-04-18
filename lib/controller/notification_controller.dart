import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/notification_model.dart';

class NotificationController extends ChangeNotifier {
  final _collection = FirebaseFirestore.instance.collection('notifications');

  Stream<List<NotificationModel>> get notifications {
    return _collection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs
        .map((doc) => NotificationModel.fromMap(doc.data(), doc.id))
        .toList());
  }

  Future<void> addNotification(NotificationModel model) async {
    await _collection.add(model.toMap());
  }
}