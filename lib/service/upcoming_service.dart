import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/upcoming_model.dart';

class UpcomingService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // 🔹 GET STREAM (for listing matches)
  Stream<List<UpcomingModel>> getUpcomingMatch() {
    return firestore
        .collection('upcoming_matches')
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return UpcomingModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  // 🔹 ADD MATCH
  Future<void> addUpcomingMatch(UpcomingModel model) async {
    await firestore.collection('upcoming_matches').add({
      "teamAName": model.teamAName ?? '',
      "teamBName": model.teamBName ?? '',
      "teamALogo": model.teamALogo ?? '',
      "teamBLogo": model.teamBLogo ?? '',
      "date": model.date ?? '',
      "time": model.time ?? '',
      "createdAt": DateTime.now().millisecondsSinceEpoch,
    });
  }

  // 🔹 DELETE MATCH
  Future<void> deleteUpcomingMatch(String id) async {
    await firestore.collection('upcoming_matches').doc(id).delete();
  }

  Future<void> updateUpcomingMatch(String id, UpcomingModel model) async {
    await firestore.collection('upcoming_matches').doc(id).update({
      "teamAName": model.teamAName,
      "teamBName": model.teamBName,
      "teamALogo": model.teamALogo,
      "teamBLogo": model.teamBLogo,
      "date": model.date,
      "time": model.time,
    });
  }

  // 🔥 MAIN VALIDATION (IMPORTANT)
  Future<bool> isMatchConflict({
    required String teamA,
    required String teamB,
    required String date,
    required String time,
  }) async {
    final result = await firestore
        .collection('upcoming_matches')
        .where('date', isEqualTo: date)
        .where('time', isEqualTo: time)
        .get();

    for (var doc in result.docs) {
      final data = doc.data();

      final existingA = data['teamAName'];
      final existingB = data['teamBName'];

      // ❌ Same match OR reversed match
      if ((existingA == teamA && existingB == teamB) ||
          (existingA == teamB && existingB == teamA)) {
        return true;
      }

      // ❌ Same team playing at same time
      if (existingA == teamA ||
          existingB == teamA ||
          existingA == teamB ||
          existingB == teamB) {
        return true;
      }
    }

    return false;
  }
}