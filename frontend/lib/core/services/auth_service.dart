import 'dart:core';

import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import 'custom_tabs_service.dart';

//service layers handles only calls to external data sources like backend/other apis?
//doesnt contain any logic relating to the UI
//no state management! (like knowing whether or not the user is logged in)

class AuthService {
  // instance of auth
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final String authBaseUrl = "http://10.0.2.2:8080/api/v1/auth";
  final _storage = FlutterSecureStorage();

  Future<String?> initBackendOAuthFlow() async {
    final url = Uri.parse("$authBaseUrl/redirect-to-google");
    final response = await http.get(url);
    print("getting google rdr on backend");

    if (response.statusCode == 200) {
      return(response.body);
      // this line to go to viewmodel
    } else {
      print("null response on requesting OAuth Login Url (in service method)");
      return null;
    }
  }

  //
  Future<bool> sendAuthCodeToBackend(String authCode) async {
    final response = await http.post(Uri.parse("$authBaseUrl/token-exchange"),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {"code": authCode});

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("response good, the new token is: ${response.body}");

      print("storing JWT in secure storage");
      await _storage.write(key: 'jwt_token', value: response.body);
      return true;
    } else {
      print("failed");
      return false;
    }
  }

  // JWT stuff
  Future<String?> getJwt() async {
    print("beforehand here?");
    // null return here is legit as it signifies user is logged out?
    return await _storage.read(key: 'jwt_token');
  }

  Future<void> saveJwt(String jwt) async {
    await _storage.write(key: 'jwt_token', value: jwt);
  }

  Future<void> removeJwt() async {
    await _storage.delete(key: 'jwt_token');
  }

  Future<JWT> decodeJwt() async {
    try {
      String? jwtString = await getJwt();
      if (jwtString == null) {
        throw Exception("Failed to get JWT String");
      }
      print("decoding jwt: $jwtString");
      JWT? decodedJwt = JWT.tryDecode(jwtString);
      // could this ever happen?
      print('jwt decoded: $decodedJwt');
      if(decodedJwt == null){
        throw Exception("decoding the jwt resulted in null?");
      }
      return decodedJwt;
    } catch (e) {
      print("exception in decoding jwt");
      rethrow;
    }
  }

  Future<String> getGoogleId() async {
    print('getting googleId from jwt');
    JWT decodedJwt = await decodeJwt();
    print("trying to get payload... payoad: ${decodedJwt.payload}");
    return decodedJwt.payload['sub'];
  }

  // Moved to auth repository
  // Future<bool> isLoggedIn() async {
  //   print("here?");
  //   try {
  //      JWT decodedJwt = await decodeJwt();
  //     print(decodedJwt.payload["exp"]);
  //     int expiryDate = decodedJwt.payload["exp"];
  //
  //     final expirationDateTime =
  //         DateTime.fromMillisecondsSinceEpoch(expiryDate * 1000);
  //     print("now: ${DateTime.now()}, token exp: $expirationDateTime ");
  //     if (expirationDateTime.isBefore(DateTime.now())) {
  //       print(
  //           "expiiration date ($expirationDateTime) is before now (${DateTime.now()}) so the token is expired");
  //       return false;
  //     }
  //     // jwt valid
  //     print(
  //         "expiiration date ($expirationDateTime) is after now (${DateTime.now()}) so the token is valid");
  //
  //     return true;
  //   } catch (e) {
  //     print("some error decoding or something idk: $e");
  //     return false;
  //   }
  }






  // get current user (from firebase?) TODO am i cutting firebase out?
  User? getCurrentUser() {
    // return _firebaseAuth.currentUser;
  }

  // google sign in with firebase - am i scrapping this?
  signInToFirebaseWithGoogleTokens() async {
    // get tokens from backend after token exchange
    try {
      // create new credentials for the user out of the tokens.
      final credential = GoogleAuthProvider.credential(
          // change this
          // accessToken: gAuth.accessToken,
          // idToken: gAuth.idToken,
          );

      // sign in to firebase using the constructed credential from the google creds
      // final UserCredential userCredential =
          // await _firebaseAuth.signInWithCredential(credential);
      print("accessToken: ${credential.accessToken}");
      print("idToken: ${credential.idToken}");
      print("oooooooooo");
      return {
        // "userCredential": userCredential,
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

