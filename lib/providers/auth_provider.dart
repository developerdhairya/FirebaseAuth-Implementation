import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:vartaa_messenger/providers/user_image_provider.dart';
import 'package:vartaa_messenger/services/cloud_storage_service.dart';
import 'package:vartaa_messenger/services/firestore_service.dart';
import 'package:vartaa_messenger/services/navigation_service.dart';
import 'package:vartaa_messenger/services/snackbar_service.dart';

enum AuthStatus {
  NotAuthenticated,
  Authenticating,
  Authenticated,
  UserNotFound,
  Error
}

class AuthProvider extends ChangeNotifier {
  User? user;

  AuthStatus? status;

  late FirebaseAuth _auth;

  static AuthProvider instance = AuthProvider();

  AuthProvider() {
    _auth = FirebaseAuth.instance;
    isUserAuthenticated();
  }

  void _autoLogin() {
    if (user!=null) {
      NavigationService.instance.navigateToReplacement("/home");
    }
  }

  void isUserAuthenticated() async{
    user=_auth.currentUser;
    if(user!=null){
      notifyListeners();
      _autoLogin();
    }
  }


  Future<void> loginUserWithEmailAndPassword(
      String _email, String _password) async {
    status = AuthStatus.Authenticating;
    notifyListeners();
    try {
      UserCredential _result = await _auth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      user = _result.user!;
      status = AuthStatus.Authenticated;
      SnackBarService.instance.showSnackBarSuccess("Welcome,${user!.email}");
      //Update Last Seen
      //Navigate to Home Page
    } catch (e) {
      status = AuthStatus.Error;
      SnackBarService.instance.showSnackBarError("Error Authenticating");
    }
    notifyListeners();
  }

  void registerUserWithEmailAndPassword(
      String _email, String _password, String _name) async {
    status = AuthStatus.Authenticating;
    notifyListeners();

    try {
      UserCredential _result = await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      user = _result.user!;
      await FirestoreService.instance.createUserInDB(
          user!.uid, _name, _email, UserImageProvider.instance.userImage.path);
      await CloudStorageService.instance
          .uploadUserImage(user!.uid, UserImageProvider.instance.userImage);
      status = AuthStatus.Authenticated;
      SnackBarService.instance.showSnackBarSuccess("Welcome,${user!.email}");
      //Update Last Seen
      //Navigate to Home Page
    } catch (e) {
      status = AuthStatus.Error;
      SnackBarService.instance.showSnackBarError("Error Authenticating");
    }
    notifyListeners();
  }
}
