import 'package:activityforecast/models/theme.dart';
import 'package:flutter/material.dart';

// Primary (orange banner), secondary (dark blue), tertiary (purple), quaternary (white), and quinary (button colour/) colours from a provider
class ThemeProvider extends ChangeNotifier {
  final List themes = const [
    ColourScheme(
        primary: Color(0xffAC8598),
        secondary: Colors.white,
        tertiary: Color(0xffCB9894),
        quaternary: Color(0xff807A86),
        quinary: Color(0xff8BABA1)),
    ColourScheme(
        primary: Color(0xff22333B),
        secondary: Color(0xffEAE0D5),
        tertiary: Color(0xffAC9375),
        quaternary: Color(0xff0A0908),
        quinary: Color(0xff5E503F)),
    ColourScheme(
        primary: Color(0xff0081A7),
        secondary: Colors.white,
        // secondary: Color(0xffEAF0CE),
        tertiary: Color(0xffC0C5C1),
        quaternary: Color(0xff3F334D),
        quinary: Color(0xff574B60)),
    ColourScheme(
        primary: Color(0xffD05353),
        secondary: Colors.white,
        // secondary: Color(0xffEAF0CE),
        tertiary: Color(0xffC0C5C1),
        quaternary: Color(0xff3F334D),
        quinary: Color(0xff574B60)),
    ColourScheme(
        primary: Color(0xffE5E5E5),
        secondary: Color(0xff242F40),
        // secondary: Color(0xffEAF0CE),
        tertiary: Color(0xffCCA43B),
        quaternary: Color(0xffFFFFFF),
        quinary: Color(0xff4B88A2)),
  ];
  // ColourScheme currentTheme = ColourScheme(
  //     primary: Color(0xff011627),
  //     secondary: Color(0xffEAE0D5),
  //     tertiary: Color(0xff2EC4B6),
  //     quaternary: Color(0xffE71D36),
  //     quinary: Color(0xffFF9F1C));
// var firstTheme = {
//   "primary": Color(0xffAAA95A),
//   "secondary": Color(0xff82816D),
//   "tertiary": Color(0xffCEFF1A),
//   "quaternary": Color(0xff3A3335),
//   "quinary": Color(0xff78C0E0),
// };
  // ColourScheme currentTheme = ColourScheme(
  //     primary: Color(0xffAAA95A),
  //     secondary: Color(0xff3A3335),
  //     tertiary: Color(0xff82816D),
  //     quaternary: Color(0xffCEFF1A),
  //     quinary: Color(0xffc06e52));
  // // quinary: Color(0xff477998));

  // ColourScheme currentTheme = ColourScheme(
  //     primary: Color(0xffAAA95A),
  //     secondary: Color(0xff3A3335),
  //     tertiary: Color(0xff82816D),
  //     quaternary: Color(0xffCEFF1A),
  //     quinary: Color(0xfffa7e61));
  // // quinary: Color(0xff477998));

  ColourScheme currentTheme = ColourScheme(
      primary: Color(0xffAC8598),
      secondary: Colors.white,
      tertiary: Color(0xffCB9894),
      quaternary: Color(0xff807A86),
      quinary: Color(0xff8BABA1));

  void changeTheme(int index) {
    currentTheme = themes[index]; // remove from theM MORE ACTIVITIES

    notifyListeners();
  }

  //     ColourScheme currentTheme = ColourScheme(
  // primary: Color(0xff011627),
  // secondary: Color(0xffEAE0D5),
  // tertiary: Color(0xffFF9F1C),
  // quaternary: Color(0xffE71D36),
  // quinary: Color(0xff2EC4B6));
// var firstTheme = {
//   "primary": Color(0xff011627),
//   "secondary": Color(0xffFF9F1C),
//   "tertiary": Color(0xff2EC4B6),
//   "quaternary": Color(0xffFDFFFC),
//   "quinary": Color(0xffE71D36),
// };

// var firstTheme = {
//   "primary": Color(0xff22333B),
//   "secondary": Color(0xff5E503F),
//   "tertiary": Color(0xffAC9375),
//   "quaternary": Color(0xffEAE0D5),
//   "quinary": Color(0xff0A0908),
// };

  // ColourScheme currentTheme = const ColourScheme(
  //     primary: Color(0xff9F9AA4),
  //     secondary: Colors.white,
  //     tertiary: Color(0xffE7CFCD),
  //     quaternary: Color(0xffB5C9C3),
  //     quinary: Color(0xffCAB1BD));

  // var firstTheme = {
//   "primary": Color(0xff9F9AA4),
//   "secondary": Color(0xffE7CFCD),
//   "tertiary": Color(0xffB5C9C3),
//   "quaternary": Colors.white,
//   "quinary": Color(0xffE7CFCD),
// };

}
