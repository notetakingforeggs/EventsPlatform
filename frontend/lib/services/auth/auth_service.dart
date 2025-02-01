import 'dart:convert';

import 'package:events_platform_frontend/models/AppUser.dart';
import 'package:events_platform_frontend/services/api/api_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../custom_tabs/custom_tabs_1.dart';

class AuthService {
  // instance of auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final String authBaseUrl = "http://10.0.2.2:8080/api/v1/auth";
  final _storage = FlutterSecureStorage();


  // delete this because signin happening elsewhere?
  // final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
  //   'email',
  //   'https://www.googleapis.com/auth/calendar',
  // ]);

  Future<void> initBackendOAuthFlow(BuildContext context) async {
    final url = Uri.parse("$authBaseUrl/redirect-to-google");
    final response = await http.get(url);
    print("getting google rdr on backend");

    if(response.statusCode == 200) {

      print(response.body);
      CustomTabLauncher().launchGoogleAuthCustomTab(context, response.body);
    } else{
      print("fuckery");
    }
  }

  //
  sendAuthCodeToBackend(String authCode)async{

    final response = await http.post(
        Uri.parse("$authBaseUrl/token-exchange"),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {"code" : authCode}
    );

    // TODO in here is too retreive the JWT and store it or something and add to all future requsts.
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("response good: ${response.body}");
      await _storage.write(key: 'jwt:token', value: response.body);
    } else {
      print("failed");
    }
    // TODO something with the response, firebase here?
  }

  Future<String?> getJwt() async{
    return await _storage.read(key: 'jwt_token');
  }

  // get current user
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  // google sign in
  signInToFirebaseWithGoogleTokens() async {

    // get tokens from backend after token exchange
    try{
      // create new credentials for the user out of the tokens.
      final credential = GoogleAuthProvider.credential(
        // change this
        // accessToken: gAuth.accessToken,
        // idToken: gAuth.idToken,
      );

      // sign in to firebase using the constructed credential from the google creds
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      print("accessToken: ${credential.accessToken}");
      print("idToken: ${credential.idToken}");
      print("oooooooooo");
      return {
        "userCredential": userCredential,
        "googleIdToken": credential.idToken,
        "googleAccessToken": credential.accessToken,
      };
    } catch (error) {
      print("user unable to sign in error: $error");
      rethrow;
    }
  }


  checkGoogleSignIn() async {
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn().signInSilently();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      print(googleAuth.accessToken); // This will refresh the token if expired
    }
  }


  // refactor to be a backend call.
  signOut() async {
  //   try {
  //     if (await _googleSignIn.isSignedIn()) {
  //       await _googleSignIn.signOut();
  //       print("user signed out from google");
  //     }
  //     await _firebaseAuth.signOut();
  //     print("user signed out from firebasea");
  //   } catch (e) {
  //     print("there has been some error signing out: $e");
  //   }
  }
}
