import 'dart:io';

import 'package:flutter/material.dart';
import 'package:music_player/user_preferences.dart';

import 'model/user.dart';

class MyHeaderDrawer extends StatefulWidget {
  @override
  _MyHeaderDrawerState createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  final user = UserPreferences.getUser();
  @override
  Widget build(BuildContext context) {
    return Container(

      color: Colors.green,
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: FileImage(File(user.imagePath))
              ),
            ),
          ),
          buildName(user)

        ],
      ),
    );
  }
  Widget buildName(User user) => Column(
    children: [
      Text(
        user.name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
      ),
      const SizedBox(height: 4),
      Text(
        user.email,
        style: TextStyle(color: Colors.white),
      )
    ],
  );
}