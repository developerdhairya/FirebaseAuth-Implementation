import 'package:flutter/material.dart';

class NavigationService{

  late GlobalKey<NavigatorState> _navigatorKey;

  static NavigationService instance=NavigationService();

  NavigationService(){
    _navigatorKey=GlobalKey<NavigatorState>();
  }

  Future<dynamic> navigateToReplacement(String _routeName){
    return _navigatorKey.currentState!.pushReplacementNamed(_routeName);
  }

  Future<dynamic> navigateTo(String _routeName){
    return _navigatorKey.currentState!.pushNamed(_routeName);
  }

  Future<dynamic> navigateToRoute(MaterialPageRoute _route){
    return _navigatorKey.currentState!.push(_route);
  }

  void goBack(){
    return _navigatorKey.currentState!.pop();
  }

}