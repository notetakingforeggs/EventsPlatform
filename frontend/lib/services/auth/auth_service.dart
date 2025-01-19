import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // instance of auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // get current user
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  // google sign in
  signInWithGoogle() async {


    // check if user is signed in




    // begin sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    print(gUser);
    // check for cancel
    if (gUser == null) return;

    // obtain details from the request
    final GoogleSignInAuthentication gAuth = await gUser.authentication;
    print(gAuth);

    // create new credentials for the user.
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    print("credential is $credential");

    // sign in
    return await _firebaseAuth.signInWithCredential(credential);
  }
}
