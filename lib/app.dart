import 'package:flutter/material.dart';
import 'package:my_contact/home.dart';
// import 'package:my_contact/home.dart';
// import 'package:my_contact/modal_bottom_sheet.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}
