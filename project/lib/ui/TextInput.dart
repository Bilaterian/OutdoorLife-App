import 'package:flutter/material.dart';

class TextInput extends StatelessWidget{
  const TextInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return const TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Search Map',
      ),
    );
  }
}