import 'package:flutter/material.dart';
import '../model/league_logo_model.dart';
import '../model/league_model.dart';
import '../service/league_service.dart';

class LeagueController with ChangeNotifier {
  final LeagueService leagueService = LeagueService();

  LeagueLogoModel? selectedTeam;

  void setSelecTeam(LeagueLogoModel team) {
    selectedTeam = team;
    notifyListeners();
  }

  void clearSelectedTeam() {
    selectedTeam = null;
    notifyListeners();
  }

  Stream<List<LeagueModel>> get leagueMaches {
    return leagueService.getLeague();
  }

  Future<void> addLeague(LeagueModel model) async {
    await leagueService.addLeague(model);
    clearSelectedTeam();
    notifyListeners();
  }

  Future<void> deleteLeague(String id) async {
    await leagueService.deleteLeague(id);
    notifyListeners();
  }
}