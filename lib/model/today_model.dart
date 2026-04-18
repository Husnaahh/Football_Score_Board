import 'package:cloud_firestore/cloud_firestore.dart';

class TodayModel {
  final String? id;
  final String? teamAName;
  final String? teamBName;
  final String? teamALogo;
  final String? teamBLogo;
  final String? date;
  final String? time;
  final int? scoreA;
  final int? scoreB;

  TodayModel({
    this.id,
    this.teamAName,
    this.teamBName,
    this.teamALogo,
    this.teamBLogo,
    this.date,
    this.time,
    this.scoreA,
    this.scoreB,
  });

  factory TodayModel.fromMap(Map<String, dynamic> data, String id) {
    return TodayModel(
      id: id,
      teamAName: data['teamAName'],
      teamBName: data['teamBName'],
      teamALogo: data['teamALogo'],
      teamBLogo: data['teamBLogo'],
      date: data['date'],
      time: data['time'],
      scoreA: data['scoreA'] ?? 0,
      scoreB: data['scoreB'] ?? 0,
    );
  }

  factory TodayModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TodayModel.fromMap(data, doc.id);
  }

  Map<String, dynamic> toMap() {
    return {
      'teamAName': teamAName,
      'teamBName': teamBName,
      'teamALogo': teamALogo,
      'teamBLogo': teamBLogo,
      'date': date,
      'time': time,
      'scoreA': scoreA,
      'scoreB': scoreB,
    };
  }
}