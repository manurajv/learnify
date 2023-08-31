import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('users');

  Future<void> saveUserData(String uid, String email, String role) async {
    try {
      await usersCollection.doc(uid).set({
        'email': email,
        'role': role,
      });
    } catch (e) {
      print(e.toString());
    }
  }

// Other methods for fetching and updating user data
}
