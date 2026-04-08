class UserModel {
  final String? uid;
  final String? name;
  final String? email;

  UserModel({
    this.uid,
    this.name,
    this.email
  });

  factory UserModel.fromMap(Map<String,dynamic> map,String docId) {
    return UserModel(
        uid: docId,
        name: map['name'],
        email: map['email']
    );
  }

  Map<String,dynamic> toMap() {
    return {
      'name' : name,
      'email' : email
    };
  }
}