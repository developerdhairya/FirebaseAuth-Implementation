import 'dart:io';
import 'package:flutter/material.dart';
import 'package:vartaa_messenger/services/low-lvl/media_service.dart';
import 'package:vartaa_messenger/services/low-lvl/snackbar_service.dart';

enum UserImageStatus {
  NotFetched,
  Fetching,
  Fetched,
  Error,
}

class UserImageProvider extends ChangeNotifier {
  late File userImage;

  UserImageStatus? status;

  static UserImageProvider instance = UserImageProvider();

  void addUserImage() async {
    status = UserImageStatus.Fetching;
    try {
      userImage = await MediaService.instance.getImageFromLibrary();
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
