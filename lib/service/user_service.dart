import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user_model.dart';

class UserService {
  final CollectionReference users =
  FirebaseFirestore.instance.collection('users');

  Future<void> createUser(UserModel user) async {
    await users.doc(user.uid).set(user.toMap());
    print("✅ User saved: ${user.uid} with role ${user.role}");
  }

  Future<UserModel?> getUser(String uid) async {
    final doc = await users.doc(uid).get();

    print("DOC EXISTS: ${doc.exists}");
    print("DOC DATA: ${doc.data()}");

    if (doc.exists && doc.data() != null) {
      return UserModel.fromMap(doc.data() as Map<String, dynamic>);
    }

    return null;
  }
}