import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:events_platform_frontend/core/services/auth_service.dart';
import 'package:flutter/cupertino.dart';

// repository is for business logic , deciding when to refresh tokens, decode jwts and store/retrieve creds
class AuthRepository extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  // for checking if person is logged in
  Future<bool> isLoggedIn() async {
    print("here?");
    try {
      // do i need to nullcheck here? null checking is done within the decode jwt method and exceptions are thrown...?
      JWT decodedJwt = await _authService.decodeJwt();
      print(decodedJwt.payload["exp"]);
      int expiryDate = decodedJwt.payload["exp"];

      final expirationDateTime =
      DateTime.fromMillisecondsSinceEpoch(expiryDate * 1000);
      print("now: ${DateTime.now()}, token exp: $expirationDateTime ");
      if (expirationDateTime.isBefore(DateTime.now())) {
        print(
            "expiiration date ($expirationDateTime) is before now (${DateTime
                .now()}) so the token is expired");
        return false;
      }
      // jwt valid
      print(
          "expiiration date ($expirationDateTime) is after now (${DateTime
              .now()}) so the token is valid");

      return true;
    } catch (e) {
      print("some error decoding or something idk: $e");
      return false;
    }
  }

  Future<String?> getOAuthLoginUrl() async {
    return _authService.initBackendOAuthFlow();
  }

  Future<bool> logIn(String authCode) async {
    return await _authService.sendAuthCodeToBackend(authCode);
  }

  Future<void> logOut() async {
    _isAuthenticated = false;
    notifyListeners();
    return await _authService.removeJwt();
  }

  Future<void> checkAuthentication(String? authCode) async {
    if (authCode != null) {
      _isAuthenticated = await logIn(authCode);
    } else {
      _isAuthenticated = await isLoggedIn();
    }
    // notify UI of changed value of _isAuthenticated
    notifyListeners();
  }


}
