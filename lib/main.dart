import 'package:abogida/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Pages/class_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(

    debugShowCheckedModeBanner: false,
    home: Auth().check(),

    routes: {
      "ClassPage": (context) => const ClassPage(),
    },
  ));
}
