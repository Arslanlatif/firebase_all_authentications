import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookAuthentication extends StatefulWidget {
  const FacebookAuthentication({super.key});

  @override
  State<FacebookAuthentication> createState() => _FacebookAuthenticationState();
}

class _FacebookAuthenticationState extends State<FacebookAuthentication> {
  Future<UserCredential> signInWithFacebook() async {
    late OAuthCredential facebookAuthCredential;
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      print(e);
    }
    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: signInWithFacebook, icon: const Icon(Icons.facebook));
  }
}
