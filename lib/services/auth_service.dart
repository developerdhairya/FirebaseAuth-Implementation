import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vartaa_messenger/providers/user_avatar_provider.dart';
import 'package:vartaa_messenger/services/cloud_storage_service.dart';
import 'package:vartaa_messenger/services/firestore_service.dart';
import 'package:vartaa_messenger/services/navigation_service.dart';
import 'package:vartaa_messenger/services/snackbar_service.dart';

class AuthService{

  late FirebaseAuth _auth;

  static AuthService instance=AuthService();

  AuthService(){
    _auth=FirebaseAuth.instance;
  }

  Future<User> _registerUserWithImage(_email,_password,_username) async{
    UserCredential _credentials=await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
    User _user=_credentials.user!;
    String _url=await CloudStorageService.instance.uploadUserImage(_user.uid);
    await FirestoreService.instance.createUserInDB(_user.uid, _username, _email, _url);
    //Update Last Seen
    SnackBarService.instance.showSnackBarSuccess("Welcome,$_username");
    NavigationService.instance.navigateToReplacement("/home");
    return _user;
  }

  Future<User> _registerUserWithoutImage(_email,_password,_username) async{
    UserCredential _credentials=await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
    User _user=_credentials.user!;
    await FirestoreService.instance.createUserInDB(_user.uid, _username, _email, "");
    //Update Last Seen
    SnackBarService.instance.showSnackBarSuccess("Welcome,$_username");
    NavigationService.instance.navigateToReplacement("/home");
    return _user;
  }

  Future<User> registerUser(_email,_password,_username) async{
    if(UserAvatarProvider.instance.status==UserImageStatus.Fetched){
      return await _registerUserWithImage(_email, _password, _username);
    }
    else{
      return await _registerUserWithoutImage(_email, _password, _username);
    }
  }



}