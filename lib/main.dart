import "package:firebase_core/firebase_core.dart";
import 'package:flutter/material.dart';
import 'login.dart';

//Future<void>
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyCtsgS9Syw_FMGojoMxUfjbmfrvDHq5pxc",
    appId: "1:712874113212:web:4ac3e60efda66f7da278b9",
    messagingSenderId: "712874113212",
    projectId: "chatunlimited-cc5ea",
  ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat With Companian',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.orange[900],
      ),
      home: Home(),
    );
  }
}
