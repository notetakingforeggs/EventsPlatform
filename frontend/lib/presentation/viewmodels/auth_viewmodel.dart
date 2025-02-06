import 'dart:math';

import 'package:events_platform_frontend/data/repositories/auth_repository.dart';
import 'package:events_platform_frontend/routing/routes.dart';
import 'package:flutter/cupertino.dart';

import '../../core/services/custom_tabs_service.dart';

class AuthViewmodel extends ChangeNotifier{
  final AuthRepository _repository = AuthRepository();
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  Future<void> checkAuthentication(String? authCode)async{
    if(authCode != null){
      _isAuthenticated = await _repository.logIn(authCode);
    }else{
      _isAuthenticated = await _repository.isLoggedIn();
    }
    // notify UI of changed value of _isAuthenticated
    notifyListeners();
  }

  Future<void> startOAuthFlow(BuildContext context) async {
    try{
      String? loginUrl = await _repository.getOAuthLoginUrl();
      if(loginUrl != null){
        CustomTabLauncher().launchGoogleAuthCustomTab(context, loginUrl);
      }
    }catch(e){
      print("error in viewmodel starting OAuth Flow");
    }
  }

  Future<void> logOut() async{
    await _repository.logOut();
    _isAuthenticated = false;
    notifyListeners();
  }

}