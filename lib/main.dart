import 'package:firebase_all_authentications/emailAuthentication.dart';
import 'package:firebase_all_authentications/facebookAuthentication.dart';
import 'package:firebase_all_authentications/googleAuthentication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'local_push_notifications/local_push_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: const FirebaseOptions(
      //     apiKey: "AIzaSyCP-NAG6VrBpQMS0QjhPfwEQrdyyjQ94IU",
      //     authDomain: "fir-authentications-62974.firebaseapp.com",
      //     projectId: "fir-authentications-62974",
      //     storageBucket: "fir-authentications-62974.appspot.com",
      //     messagingSenderId: "202013423553",
      //     appId: "1:202013423553:web:a711f95a185d5692342140")
      );
  LocalNotificationService localNotificationService =
      LocalNotificationService();

  await localNotificationService.initializeSettingOfNotification();
  FirebaseMessaging.onMessage.listen((message) async {
    localNotificationService.showNotification(
        title: 'Notification', body: 'latu latu bam bam');
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amberAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(
        title: 'Authentication',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber,
        appBar: AppBar(
          elevation: 30,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //
              EmailAuthentication(),
              //
              const Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: GoogleAuthentication(),
                  ),
                  //
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: FacebookAuthentication(),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
