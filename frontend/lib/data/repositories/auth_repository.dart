import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:events_platform_frontend/core/services/auth_service.dart';
import 'package:events_platform_frontend/data/providers/loading_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

// repository is for business logic , deciding when to refresh tokens, decode jwts and store/retrieve creds
class AuthRepository extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isAuthenticated = false;
  final LoadingProvider loadingProvider;

  AuthRepository(this.loadingProvider);

  bool get isAuthenticated => _isAuthenticated;

  // for checking if person is logged in - checks JWT time
  Future<bool> isLoggedIn() async {
    print("in the 'isloggedin");
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
    print("logging out");
    _isAuthenticated = false;
    notifyListeners();
    return await _authService.removeJwt();
  }

  Future<void> checkAuthentication(String? authCode) async {
    loadingProvider.setLoading(true);
    notifyListeners();
    if (authCode != null) {
      print("authcode received from OAuth server, attempting to login");
      _isAuthenticated = await logIn(authCode);
      print("changing status to authenticated as a result of sccesful login");
    } else {
      print("no authcode, checking if already logged in... and setting isAuthenticated to the result");
      _isAuthenticated = await isLoggedIn();
    }
    // notify UI of changed value of _isAuthenticated
    loadingProvider.setLoading(false);
    notifyListeners();
  }


}
