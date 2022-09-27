import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/home.dart';
import 'package:music_player/musicList.dart';
import 'package:music_player/onboard_screen/onboard.dart';
import 'package:flutter/services.dart';
import 'package:music_player/playlistPage.dart';
import 'package:music_player/song_page.dart';
import 'package:music_player/themes.dart';
import 'package:music_player/user_preferences.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/songModelProvider.dart';

int? isviewed;
Future main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);



  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isviewed = prefs.getInt('onBoard');
  await UserPreferences.init();

  runApp(ChangeNotifierProvider(
    create: (context) => SongModelProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final String title = 'User Profile';

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.getUser();
    return ThemeProvider(
      initTheme: user.isDarkMode ? MyThemes.darkTheme : MyThemes.lightTheme,
      child: Builder(
        builder: (context, ) => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Theme.of(context),
          title: title,
          home: SplashScreen(),
          getPages: [
            GetPage(name: '/', page: () =>  musicPage()),
            GetPage(name: '/song', page: () =>  SongScreen()),
            GetPage(name: '/playlist', page: () =>  const PlaylistScreen()),
          ],
        ),
      ),
    );
  }
}

class SplashScreen  extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Lottie.asset('assets/logo.json'),
          const Text('Gaan Shuno', style: TextStyle(fontSize: 30, color: Colors.black, fontFamily: 'Poppins'),)
        ],
      ),
      backgroundColor: Colors.white,
      nextScreen: isviewed != 0 ? OnBoard() : Home(),
      splashIconSize: 450,
      duration: 3500,
    );
  }
}
