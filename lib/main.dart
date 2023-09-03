import 'package:daily_quotes/pages/about_page.dart';
import 'package:daily_quotes/pages/main_page.dart';
import 'package:daily_quotes/pages/quote_page.dart';
import 'package:daily_quotes/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:audioplayers/audioplayers.dart';
import 'helper/prefs_helper.dart';

AudioCache cache = AudioCache();
AudioPlayer player = AudioPlayer();

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await PrefsHelper.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isMusicOn = false;

  @override
  void initState() {
    super.initState();
    _loadMusicPreference();
  }

  _loadMusicPreference() async {
    // play on loop
    player.setReleaseMode(ReleaseMode.loop);
    player.play(
      AssetSource(
        'sounds/testMusic.wav',
      ),
    );
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // setState(() {
    //   isMusicOn = prefs.getBool('isMusicOn') ?? true;
    // });
    //
    // if (isMusicOn) {
    //   playMusic();
    // }
  }

  playMusic() async {
    await player!.setSource(AssetSource('assets/sounds/music.mp3'));
    player!.setReleaseMode(ReleaseMode.loop);
    player!.play(AssetSource('assets/sounds/music.mp3'));
  }

  stopMusic() {
    player?.stop();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        debugShowCheckedModeBanner: false,
        home: const MainPage(),
        routes: {
          '/quote': (context) => const QuotePage(),
          '/about': (context) => const AboutPage(),
          '/settings': (context) => const SettingsPage(),
        });
  }
}
