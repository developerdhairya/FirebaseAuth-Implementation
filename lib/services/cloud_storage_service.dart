import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:vartaa_messenger/providers/user_avatar_provider.dart';

class CloudStorageService {
  late FirebaseStorage _storage;
  late Reference _baseRef;

  static CloudStorageService instance = CloudStorageService();

  String _profileImages = "profile_storage";

  CloudStorageService() {
    _storage = FirebaseStorage.instance;
    _baseRef = _storage.ref();
  }

  Future<String> uploadUserImage(String _uid) async {
    Reference _reference = _baseRef.child(_profileImages).child(_uid);
    TaskSnapshot _uploadSnapshot =
        await _reference.putFile(UserAvatarProvider.instance.userImage);
    return await _reference.getDownloadURL();
  }
}
