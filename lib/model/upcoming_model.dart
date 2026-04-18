class UpcomingModel {
  final String? id;
  final String? teamAName;
  final String? teamALogo;
  final String? teamBName;
  final String? teamBLogo;
  final String? date;
  final String? time;

  UpcomingModel({
    this.id,
    this.teamAName,
    this.teamALogo,
    this.teamBName,
    this.teamBLogo,
    this.date,
    this.time,
  });

  factory UpcomingModel.fromMap(Map<String, dynamic> map, String id) {
    return UpcomingModel(
      id: id,
      teamAName: map['teamAName'],
      teamALogo: map['teamALogo'],
      teamBName: map['teamBName'],
      teamBLogo: map['teamBLogo'],
      date: map['date'],
      time: map['time'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'teamAName': teamAName,
      'teamALogo': teamALogo,
      'teamBName': teamBName,
      'teamBLogo': teamBLogo,
      'date': date,
      'time': time,
    };
  }
}