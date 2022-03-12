import 'package:flutter/material.dart';
import 'package:project/ui/TextInput.dart';
import 'package:project/ui/SettingsButton.dart';

class TopRow extends StatelessWidget {
  const TopRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: TextInput(),
        ),
        SettingsButton(),
      ],
    );
  }
}
