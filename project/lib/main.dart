import 'package:flutter/material.dart';
import 'view/pages/create_new_activity_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CreateNewActivityPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}