import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/upcoming_model.dart';

class UpcomingService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<UpcomingModel>> getUpcomingMatch() {
    return firestore
        .collection('upcoming_matches')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return UpcomingModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

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


  Future<void> deleteUpcomingMatch(String id) async {
    await firestore.collection('upcoming_matches').doc(id).delete();
  }
}