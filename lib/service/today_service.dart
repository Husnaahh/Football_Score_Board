
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/today_model.dart';

class TodayService {
  final FirebaseFirestore today = FirebaseFirestore.instance;

  Stream<List<TodayModel>> getTodayMatch() {
    return today.collection('todayMatches').snapshots().map((snapshot) {
      return snapshot.docs.map((docs) {
        return TodayModel.fromMap(docs.data(), docs.id);
      }).toList();
    });
  }

  Future<void> addTodayMatch(TodayModel model) async {
    await today.collection('todayMatches').add(model.toMap());
  }

  Future<void> deleteTodayMatch(String id) async {
    await today.collection('todayMatches').doc(id).delete();
  }
}
