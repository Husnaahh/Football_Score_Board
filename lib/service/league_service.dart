import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/league_model.dart';

class LeagueService {
  final FirebaseFirestore league = FirebaseFirestore.instance;

  Stream<List<LeagueModel>> getLeague() {
    return league.collection('leagues').snapshots().map((snapshot) {
      return snapshot.docs.map((docs) {
        return LeagueModel.fromMap(docs.data(), docs.id);
      }).toList();
    });
  }

  Future<void> addLeague(LeagueModel model) async {
    await league.collection('leagues').add(model.toMap());
  }

  Future<void> deleteLeague(String id) async {
    await league.collection('leagues').doc(id).delete();
  }
}