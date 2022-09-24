
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_player/user_preferences.dart';

import 'model/user.dart';

class settingsPage extends StatelessWidget {

  final user = UserPreferences.getUser();
  static final String path = "lib/settings.dart";
  final TextStyle whiteText = TextStyle(
    color: Colors.black,
  );
  final TextStyle greyTExt = TextStyle(
    color: Colors.black45,
  );
  final TextStyle whiteBoldText = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  settingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Theme(
        data: Theme.of(context).copyWith(
          brightness: Brightness.dark,
          primaryColor: Colors.purple,
        ),
        child: DefaultTextStyle(
          style: TextStyle(
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 30.0),
                Row(
                  children: <Widget>[
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: FileImage(File(user.imagePath)),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          buildName(user)
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                ListTile(
                  title: Text(
                    "Languages",
                    style: whiteBoldText,
                  ),
                  subtitle: Text(
                    "English US",
                    style: greyTExt,
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.black45,
                  ),
                  onTap: () {},
                ),
                SwitchListTile(
                  activeColor: Colors.green,
                  title: Text(
                    "Themes",
                    style: whiteBoldText,
                  ),
                  subtitle: Text(
                    "Light Mode",
                    style: greyTExt,
                  ),
                  value: false,
                  onChanged: (val) {},
                ),
                ListTile(
                  title: Text(
                    "Exit",
                    style: whiteBoldText,
                  ),
                  onTap: () {
                    SystemNavigator.pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget buildName(User user) => Column(
    children: [
      Text(
        user.name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
      ),
      const SizedBox(height: 4),
      Text(
        user.email,
        style: TextStyle(color: Colors.black),
      )
    ],
  );
}