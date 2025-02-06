import 'dart:math';

import 'package:events_platform_frontend/core/services/auth_service.dart';
import 'package:events_platform_frontend/data/repositories/auth_repository.dart';
import 'package:events_platform_frontend/routing/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../core/services/custom_tabs_service.dart';

class AuthViewmodel extends ChangeNotifier{
  final AuthRepository _repository;
  AuthViewmodel(this._repository);

  Future<void> startOAuthFlow(BuildContext context) async {
    try{
      String? loginUrl = await _repository.getOAuthLoginUrl();
      if(loginUrl != null){
        // when i am signed in i get sent straight to this custom tab, but it isnt picked up by the deeplinks?
          context.push(Routes.home);
          CustomTabLauncher().launchGoogleAuthCustomTab(context, loginUrl);
      }
    }catch(e){
      print("error in viewmodel starting OAuth Flow");
    }
  }
}