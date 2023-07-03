import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart';

class Noti {
  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    AndroidInitializationSettings androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    DarwinInitializationSettings darwinInitializationSettings =
        const DarwinInitializationSettings(
            requestSoundPermission: false,
            requestAlertPermission: false,
            requestBadgePermission: false);
    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitialize,
        iOS: darwinInitializationSettings,
        linux: null);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future showNotification(
      {var id = 0,
      required String title,
      required String body,
      var payload,
      required FlutterLocalNotificationsPlugin fln}) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('123', 'local channel',
            channelDescription: 'This is channel',
            importance: Importance.high,
            priority: Priority.high,
            onlyAlertOnce: true,
            ticker: 'ticker',
            actions: [
          AndroidNotificationAction('0', 'Fuck',
              cancelNotification: true,
              titleColor: Colors.black,
              allowGeneratedReplies: true,
              showsUserInterface: true)
        ]);

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    await fln.show(0, title, body, notificationDetails);
  }
}

class Notificatins extends StatefulWidget {
  const Notificatins({super.key});

  @override
  State<Notificatins> createState() => _NotificatinsState();
}

class _NotificatinsState extends State<Notificatins> {
  LocalNotificationService localNotificationService =
      LocalNotificationService();

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.pinkAccent,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                onPressed: () async {
                  var tokenid = await FirebaseMessaging.instance.getToken();
                  await FirebaseFirestore.instance
                      .collection("Users")
                      .add({"token": tokenid});
                  await localNotificationService.showNotification(
                      body: 'pao japhian', title: 'Nasibo lal');
                },
                child: const Text('Notification')),
            ElevatedButton(
                onPressed: () async {
                  triggerNotifiation();
                },
                child: const Text('trigger')),
          ],
        )));
  }
}

class LocalNotificationService {
  static LocalNotificationService? _localNotificationServise;

  LocalNotificationService._internal();

  factory LocalNotificationService() {
    return _localNotificationServise ??= LocalNotificationService._internal();
  }

  //make the instance of the flutter local notification
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //method to initialize the notification setting
  Future<void> initializeSettingOfNotification() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings,
      macOS: null,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('123', 'local chanel',
            channelDescription: 'this is channel',
            importance: Importance.high,
            priority: Priority.high,
            ticker: 'ticker',
            actions: [
          AndroidNotificationAction(
            '0',
            'second',
            showsUserInterface: true,
            allowGeneratedReplies: true,
          )
        ]);

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails();

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      2,
      title,
      body,
      notificationDetails,
      payload: 'data',
    );
  }
}

void triggerNotifiation() async {
  try {
    await post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: {
          'content-type': 'application/json',
          'Authorization':
              'key=AAAALwjwN8E:APA91bEB2jcBI-klk0Oz2INve1uyX5UNak0npeMfJZ4xQ9HV3gcbTZ_nqxMn5UrYU3BpYGUCTTCET8dG1eyrlV5LCNHDImerXMNygUC2htKNY6sPnWiwNgQvVPk-in9crEmzQkjomr4o'
        },
        body: jsonEncode(
          <String, dynamic>{
            "priority": "high",
            "data": <String, dynamic>{
              "click_action": "FLUTTER_NOTIFICATION_CLICK",
              "status": "done",
            },
            "notification": <String, dynamic>{
              "title": "Hello motherboard",
              "body": "waheed ki gand ma lullay",
              "channel": "dbfood",
              "priority": "high",
              "alert": true,
            },
            "to":
                "fOle0AAGSWiP1Wdbe3mgWL:APA91bE8KvPt-cJJfCOdbvsdcp9DlyeIWEPac6GNr_yre6OBrHZA3CQD_FCuWktpGjtV_z85LY5XAG_6zGMWRrWZZUZnF0CrPeFcpXU5APR1RQy_Uc2y0DOBaS_MTtE0Y0P-Q5l4EKyP"
          },
        ));
  } catch (e) {
    print(e);
  }
}
