import 'dart:math';

import 'package:events_platform_frontend/data/repositories/auth_repository.dart';
import 'package:events_platform_frontend/routing/routes.dart';
import 'package:flutter/cupertino.dart';

import '../../core/services/custom_tabs_service.dart';

class AuthViewmodel extends ChangeNotifier{
  final AuthRepository _repository = AuthRepository();

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
}