import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:music_player/profile.dart';
import 'package:music_player/settings.dart';

import 'edit-profile.dart';
import 'musicList.dart';
import 'my_drawer_header.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  var currentPage = DrawerSections.musicList;

  final List<Widget> _pages = [
    musicPage(),
    profilePage(),
    editProfile(),
    settingsPage()
  ];
  @override
  Widget build(BuildContext context) {
    if (currentPage == DrawerSections.musicList) {
      _pages[0] = musicPage();
    } else if (currentPage == DrawerSections.profile) {
      _pages[1] = profilePage();
    } else if (currentPage == DrawerSections.editProfile) {
      _pages[2] = editProfile();
    } else if (currentPage == DrawerSections.settings) {
      _pages[3] = settingsPage();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text("Gaan Shuno"),
      ),
      body: _pages[_selectedIndex],
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(),
                MyDrawerList()
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.indigoAccent,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical:20),
          child: GNav(
            backgroundColor: Colors.indigoAccent,
            color: Colors.white,
            activeColor: Colors.black,
            tabBackgroundColor: Colors.white,
            gap: 8,
            selectedIndex: _selectedIndex,
            onTabChange:(index){
              setState(() {
                _selectedIndex=index;
              });
            },
            padding: EdgeInsets.all(10),
            tabs: const [
              GButton(icon: Icons.home,
                  text: 'Home'),
              GButton(icon: Icons.favorite_border,
                  text: 'Playlist'),
              GButton(icon: Icons.person,
                text: 'Profile',),
              GButton(icon: Icons.settings,
                text: 'Settings',),
            ],
          ),
        ),
      ),
    );
  }
  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Music List", Icons.dashboard_outlined,
              _pages[0] == DrawerSections.musicList ? true : false),
          menuItem(2, "Profile", Icons.people_alt_outlined,
              _pages[1] == DrawerSections.profile ? true : false),
          menuItem(3, "Edit Profile", Icons.event,
              _pages[2] == DrawerSections.editProfile ? true : false),
          menuItem(4, "Settings", Icons.notes,
              _pages[3] == DrawerSections.settings ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              _selectedIndex = 0;
            } else if (id == 2) {
              _selectedIndex = 1;
            } else if (id == 3) {
              _selectedIndex = 2;
            } else if (id == 4) {
              _selectedIndex = 3;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  musicList,
  profile,
  editProfile,
  settings,
}


