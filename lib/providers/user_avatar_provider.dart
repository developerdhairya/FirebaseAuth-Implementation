import 'dart:io';
import 'package:flutter/material.dart';
import 'package:vartaa_messenger/services/media_service.dart';
import 'package:vartaa_messenger/services/snackbar_service.dart';

enum UserImageStatus {
  NotFetched,
  Fetching,
  Fetched,
  Error,
}

class UserAvatarProvider extends ChangeNotifier {

  ImageProvider userAvatar=NetworkImage(
      "https://cdn0.iconfinder.com/data/icons/occupation-002/64/programmer-programming-occupation-avatar-512.png");

  late File userImage;

  UserImageStatus? status;

  static UserAvatarProvider instance = UserAvatarProvider();

  void getImageFromLibrary() async {
    status = UserImageStatus.Fetching;
    try {
      userImage=await MediaService.instance.getImageFromLibrary();
      userAvatar = FileImage(userImage);
      status = UserImageStatus.Fetched;
      SnackBarService.instance
          .showSnackBarSuccess("Fetched Image Successfully");
    } catch (e) {
      status = UserImageStatus.Error;
      SnackBarService.instance.showSnackBarError("Error Getting Image !");
    }
    notifyListeners();
  }
}
