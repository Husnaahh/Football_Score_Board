import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String? id;
  final String teamA;
  final String teamB;
  final String time;
  final DateTime? createdAt;

  NotificationModel({
    this.id,
    required this.teamA,
    required this.teamB,
    required this.time,
    this.createdAt,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map, String id) {
    return NotificationModel(
      id: id,
      teamA: map['teamA'] ?? '',
      teamB: map['teamB'] ?? '',
      time: map['time'] ?? '',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() => {
    'teamA': teamA,
    'teamB': teamB,
    'time': time,
    'createdAt': Timestamp.fromDate(DateTime.now()),
  };
}