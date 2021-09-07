import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:vartaa_messenger/services/snackbar_service.dart';

enum AuthStatus {
  NotAuthenticated,
  Authenticating,
  Authenticated,
  UserNotFound,
  Error
}

class AuthProvider extends ChangeNotifier {

  late User user;

  AuthStatus ? status;

  late FirebaseAuth _auth;

  static AuthProvider instance = AuthProvider();

  AuthProvider() {
    _auth = FirebaseAuth.instance;
  }

  void loginUserWithEmailAndPassword(String _email, String _password) async {
    status = AuthStatus.Authenticating;
    notifyListeners();
    try {
      UserCredential _result = await _auth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      user=_result.user!;
      status=AuthStatus.Authenticated;
      //Navigate to Home Page
      SnackBarService.instance.showSnackBarSuccess("Welcome,${user.email}");
      debugPrint("Login Successful");
    } catch (e) {
      status=AuthStatus.Error;
      //Display Error
      debugPrint("Login Failed"+e.toString());
      SnackBarService.instance.showSnackBarError("Error Authenticating");
    }
    notifyListeners();
  }
}
