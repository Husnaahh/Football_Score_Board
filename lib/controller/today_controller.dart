

import 'package:flutter/cupertino.dart';
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

  void clearSelectedTeamA() {
    selectedTeamA = null;
    notifyListeners();
  }

  void setTeamB(TeamBLogoModel teamB) {
    selectedTeamB = teamB;
    notifyListeners();
  }

  void clearSelectedTeamB() {
    selectedTeamB = null;
    notifyListeners();
  }

  void clearSelectTime() {
    selectedTime = null;
    notifyListeners();
  }

  Stream<List<TodayModel>> get todayMaches {
    return todayService.getTodayMatch();
  }

  Future<void> addTodayMatch(TodayModel model) async {
    await todayService.addTodayMatch(model);
    clearSelectedTeamA();
    clearSelectedTeamB();
  }

  Future<void> deleteTodayMatch(String id) async {
    await todayService.deleteTodayMatch(id);
    notifyListeners();
  }
}