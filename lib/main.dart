import 'package:flutter/material.dart';
import 'Pages/class_page.dart';
import 'home_page.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: App(),
      routes: {
        "ClassPage" :(context) => ClassPage(),
      },
    )
  );
}



