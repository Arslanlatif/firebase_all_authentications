import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthentication extends StatefulWidget {
  const GoogleAuthentication({super.key});

  @override
  State<GoogleAuthentication> createState() => _GoogleAuthenticationState();
}

class _GoogleAuthenticationState extends State<GoogleAuthentication> {
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    return FirebaseAuth.instance.signInWithCredential(credential);
  }

  signOutFromGoogle() async {
    await GoogleSignIn().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: FirebaseAuth.instance.currentUser != null
            ? signInWithGoogle
            : signOutFromGoogle,
        icon: const Icon(
          Icons.g_mobiledata_outlined,
          size: 60,
        ));
  }
}
