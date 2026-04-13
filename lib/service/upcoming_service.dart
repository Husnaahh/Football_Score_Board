import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/upcoming_model.dart';

class UpcomingService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<UpcomingModel>> getUpcomingMatch() {
    return firestore
        .collection('upcomingMatches')
        .orderBy('matchDateTime')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return UpcomingModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  Future<void> addUpcomingMatch(UpcomingModel model) async {
    await firestore.collection('upcomingMatches').add(model.toMap());
  }

  Future<void> deleteUpcomingMatch(String id) async {
    await firestore.collection('upcomingMatches').doc(id).delete();
  }
}