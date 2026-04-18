import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/team_logo_model.dart';
import '../model/today_model.dart';
import '../service/today_service.dart';

class TodayController with ChangeNotifier {
  final TodayService todayService = TodayService();

  TeamALogoModel? selectedTeamA;
  TeamBLogoModel? selectedTeamB;
  TimeOfDay? selectedTime;

  void setTeamA(TeamALogoModel teamA) {
    selectedTeamA = teamA;
    notifyListeners();
  }

  void setTeamB(TeamBLogoModel teamB) {
    selectedTeamB = teamB;
    notifyListeners();
  }

  void clearSelections() {
    selectedTeamA = null;
    selectedTeamB = null;
    selectedTime = null;
    notifyListeners();
  }

  Stream<List<TodayModel>> get todayMatches {
    return todayService.getTodayMatch();
  }

  Future<void> addTodayMatch(TodayModel model) async {
    await todayService.addTodayMatch(model);
    clearSelections();
  }

  Future<void> deleteTodayMatch(String id) async {
    await todayService.deleteTodayMatch(id);
    notifyListeners();
  }
  Future<void> updateScore(String id, int scoreA, int scoreB) async {
    await FirebaseFirestore.instance
        .collection('today_matches')
        .doc(id)
        .update({
      'scoreA': scoreA,
      'scoreB': scoreB,
    });

    notifyListeners();
  }
}