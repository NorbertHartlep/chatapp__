import 'package:chatapp/start_page.dart';
import 'package:chatapp/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zego_zimkit/services/services.dart';
import 'package:firebase_core/firebase_core.dart';

 Future main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  ZIMKit zimkit = ZIMKit();
  zimkit.init(
    appID: Utils.id,
    appSign: Utils.SignIn
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const StartPage(),
    );
  }
}
