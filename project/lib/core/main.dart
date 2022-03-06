import 'package:flutter/material.dart';
import 'package:project/ui/MapDisplay.dart';
import 'package:project/ui/TopRow.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OutdoorLife',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('OutdoorLife'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TopRow(),
              const SizedBox(//replace this at some point with the weather
                height: 300,
              ),
              MapDisplay(),
            ],
          ),
        ),
      ),
    );
  }
}
