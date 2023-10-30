import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/screens/home.dart';
import 'package:hackathon/screens/login.dart';
import 'package:hackathon/screens/signup.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async{
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  requestStoragePermission();
  await Firebase.initializeApp();
}

Future<void> requestStoragePermission() async {
  final status = await Permission.storage.request();
  if (status.isGranted) {
    // Permission is granted, you can now proceed with file upload.
  } else if (status.isPermanentlyDenied) {
    // The user permanently denied the permission, take them to app settings.
    openAppSettings();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: home(),
    );
  }
}
