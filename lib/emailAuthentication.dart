import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailAuthentication extends StatelessWidget {
  EmailAuthentication({super.key});

  final TextEditingController emailTEC = TextEditingController();
  final TextEditingController passwordTEC = TextEditingController();
  //
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> signinWithEmailAndPassword() async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: emailTEC.text.trim(), password: passwordTEC.text.trim());
      //
      ScaffoldMessenger(
          child: SnackBar(content: Text(userCredential.user.toString())));
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //
        Padding(
          padding: const EdgeInsets.only(top: 150, left: 30, right: 30),
          child: TextField(
              controller: emailTEC,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  hintText: 'i.e arslanlatif030@gmail.com',
                  label: Text('Email'))),
        ),
        //
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
          child: TextField(
              controller: passwordTEC,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  hintText: 'i.e arslanlatif030',
                  label: Text('Password'))),
        ),
        //
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: ElevatedButton(
              onPressed: () {
                signinWithEmailAndPassword();
              },
              child: const Text('Sign in')),
        ),
      ],
    );
  }
}
