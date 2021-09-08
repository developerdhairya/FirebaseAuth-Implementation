import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  static FirestoreService instance = FirestoreService();

  late FirebaseFirestore _firestoreDB;

  FirestoreService() {
    _firestoreDB = FirebaseFirestore.instance;
  }

  String _userCollection = "user";

  Future<void> createUserInDB(
      String _uid, String _name, String _email, String _imageURL) async {
    return await _firestoreDB.collection(_userCollection).doc(_uid).set({
      "name": _name,
      "email": _email,
      "image": _imageURL,
      "lastSeen": DateTime.now().toUtc(),
    });
  }
}
