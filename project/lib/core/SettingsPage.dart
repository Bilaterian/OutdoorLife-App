import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget{
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Settings',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => Navigator.pop(context, false),
          ),
          title: const Text('Settings'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

            ],
          ),
        ),
      ),
    );
  }
}