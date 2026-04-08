import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/upcoming_model.dart';

class UpcomingService {
  final FirebaseFirestore today = FirebaseFirestore.instance;

  Stream<List<UpcomingModel>> getUpcomingMatch() {
    return today.collection('upcomingMatches').snapshots().map((snapshot) {
      return snapshot.docs.map((docs) {
        return UpcomingModel.fromMap(docs.data(), docs.id);
      }).toList();
    });
  }

  Future<void> addUpcomingMatch(UpcomingModel model) async {
    await today.collection('upcomingMatches').add(model.toMap());
  }

  Future<void> deleteUpcomgMatch(String id) async {
    await today.collection('upcomingMatches').doc(id).delete();
  }
}