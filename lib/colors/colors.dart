import 'dart:ui';

import 'package:flutter/material.dart';
class CustomColors{
  CustomColors._();
  static bool isDark (BuildContext context)=>Theme.of(context).brightness==Brightness.dark;
  static Color  backgroundColor(BuildContext context)=>isDark(context)? const Color(0xFF303030): const Color(0xFFECFCF3);
  static Color appbar(BuildContext context)=>isDark(context)? const Color(0xFF303030):Color(0xFFECFCF3);
  static Color appbararrowicon(BuildContext context)=>isDark(context)?const Color(0xFFECFCF3):Color(0xFF000000);

  static Color  addtaskprimarygreen(BuildContext context)=>isDark(context)? const Color(0xFF303030): const Color(0xFF84C5A5);
  static Color  addtaskcategory(BuildContext context)=>isDark(context)? const Color(0xFF3C3C3C): Colors.white;
  static Color  addtaskdivider(BuildContext context)=>isDark(context)? const Color(0xFF84C5A5):Colors.white;
  static Color  addtaskbutton(BuildContext context)=>isDark(context)? const Color(0xFF84C5A5):Color(0xFF84C5A5);
  static Color  blacktext(BuildContext context)=>isDark(context)? const Color(0xB3FFFFFF): const Color(0xFF000000);
  static Color  greytext(BuildContext context)=>isDark(context)? const Color(0x99FFFFFF):const Color(0xFF616161);
  static Color  navigation (BuildContext context)=>isDark(context)? const Color(0xFF000000):Color(0xFF84C5A5);
  static Color  floating(BuildContext context)=>isDark(context)? const Color(0xFF424242):Color(0xFFA8E6C1);
  static Color  floatingicon(BuildContext context)=>isDark(context)? const Color(0xFF000000):Color(0xFF000000);

  static Color  card(BuildContext context)=>isDark(context)? const Color(0xFF3C3C3C):Colors.white;
  static Color  cardborder(BuildContext context)=>isDark(context)? const Color(0xFF84C5A5):Colors.white;
  static Color  editdeletepanel(BuildContext context)=>isDark(context)? const Color(0xFF3A3A3A):Color(0xFFECFCF3);
}
// Color primaryMint=Color(0xFF84C5A5);
// Color lightMint = Color(0xFFEAFBF0);
// Color darkMint = Color(0xFF7BCF9D);