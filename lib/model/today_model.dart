class TodayModel {
  final String? id;
  final String? teamAName;
  final String? teamALogo;
  final String? teamBName;
  final String? teamBLogo;
  final String? time;

  TodayModel({
    this.id,
    this.teamAName,
    this.teamALogo,
    this.teamBName,
    this.teamBLogo,
    this.time,
  });

  factory TodayModel.fromMap(Map<String, dynamic> map, String id) {
    return TodayModel(
      id: id,
      teamAName: map['teamAName'],
      teamALogo: map['teamALogo'],
      teamBName: map['teamBName'],
      teamBLogo: map['teamBLogo'],
      time: map['time'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'teamAName': teamAName,
      'teamALogo': teamALogo,
      'teamBName': teamBName,
      'teamBLogo': teamBLogo,
      'time': time,
    };
  }
}