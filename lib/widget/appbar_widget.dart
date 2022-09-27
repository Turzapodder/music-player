import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/user_preferences.dart';

AppBar buildAppBar(BuildContext context) {
  final user = UserPreferences.getUser();
  final isDarkMode = user.isDarkMode;

  return AppBar(
    leading: BackButton(
      color: Colors.green,
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}