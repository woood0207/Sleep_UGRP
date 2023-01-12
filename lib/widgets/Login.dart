import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();
class Login extends StatelessWidget {
  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth = await googleUser
          .authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential authResult = await _auth.signInWithCredential(
          credential);
      final User? user = authResult.user;

      if (user != null) {
        // Sign in successful
        print("Sign in successful: ${user.displayName}");
      } else {
        // Sign in unsuccessful
        print("Sign in unsuccessful");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SNS Login"),
      ),
      body: Column(
        children: [
          TextButton(
            child: Text("Google Login"),
            onPressed:signInWithGoogle,
          ),
        ],
      ),
    );
  }
}

