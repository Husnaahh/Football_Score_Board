class UpcomingModel {
  final String? id;
  final String? teamALogo;
  final String? teamAName;
  final String? teamBLogo;
  final String? teamBName;
  final String? time;

  UpcomingModel({
    this.id,
    this.teamALogo,
    this.teamAName,
    this.teamBLogo,
    this.teamBName,
    this.time
  });

  factory UpcomingModel.fromMap(Map<String,dynamic> map,String id) {
    return UpcomingModel(
        id: id,
        teamALogo: map['teamALogo'],
        teamAName: map['teamAName'],
        teamBLogo: map['teamBLogo'],
        teamBName: map['teamBName'],
        time: map['time']
    );
  }

  Map<String,dynamic> toMap() {
    return {
      'teamALogo' : teamALogo,
      'teamAName' : teamAName,
      'teamBLogo' : teamBLogo,
      'teamBName' : teamBName,
      'time' : time
    };
  }
}