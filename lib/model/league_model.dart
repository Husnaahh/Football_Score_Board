class LeagueModel {
  final String? id;
  final String? imageUrl;
  final String? name;

  LeagueModel({
    this.id,
    this.imageUrl,
    this.name,
  });

  factory LeagueModel.fromMap(Map<String,dynamic> map,String id) {
    return LeagueModel(
      id: id,
      imageUrl: map['imageUrl'],
      name: map['name'],
    );
  }

  Map<String,dynamic> toMap() {
    return {
      'imageUrl' : imageUrl,
      'name' : name,
    };
  }
}