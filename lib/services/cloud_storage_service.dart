import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class CloudStorageService {
  late FirebaseStorage _storage;
  late Reference _baseRef;

  static CloudStorageService instance = CloudStorageService();

  String _profileImages = "profile_storage";

  CloudStorageService() {
    _storage = FirebaseStorage.instance;
    _baseRef = _storage.ref();
  }

  Future<TaskSnapshot> uploadUserImage(String _uid, File ? _image) async {
    return _baseRef.child(_profileImages).child(_uid).putFile(_image!);
  }
}
