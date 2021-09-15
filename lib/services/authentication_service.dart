// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class AuthenticationService{
//
//   void registerUserWithEmailAndPassword(
//       String _email, String _password, String _name) async {
//       UserCredential _result = await _auth.createUserWithEmailAndPassword(
//           email: _email, password: _password);
//       user = _result.user!;
//       await FirestoreService.instance.createUserInDB(
//           user.uid, _name, _email, UserAvatarProvider.instance.userImage.path);
//       if (UserAvatarProvider.instance.status == UserImageStatus.Fetched) {
//         await CloudStorageService.instance
//             .uploadUserImage(user.uid, UserAvatarProvider.instance.userImage);
//       }
//       status = AuthStatus.Authenticated;
//       SnackBarService.instance.showSnackBarSuccess("Welcome,${user.email}");
//       //Update Last Seen
//       //Navigate to Home Pages
//     } catch (e) {
//       debugPrint(e.toString());
//       status = AuthStatus.Error;
//       SnackBarService.instance.showSnackBarError("Error Authenticating");
//     }
//     notifyListeners();
//   }
// }
//
//
// }