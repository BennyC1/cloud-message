import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    initFCM();
  }

  void initFCM() async {
    print("INIT FCM...");

    await FirebaseMessaging.instance.requestPermission();

    await Future.delayed(Duration(seconds: 2)); // 🔥 penting

    String? token = await FirebaseMessaging.instance.getToken();

    print("TOKEN DEVICE:");
    print(token ?? "TOKEN NULL ❌");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Notifikasi masuk: ${message.notification?.title}");
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: Text("FCM Ready")),
      ),
    );
  }
}