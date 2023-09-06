import 'package:daily_quotes/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../helper/AudioHelper.dart';
import '../helper/prefs_helper.dart';
import '../components/menu_button.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  bool isMusicOn = false;
  bool isSoundOn = false;

  // if app is paused, pause music
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      MusicHelper.pauseMusic();
    } else if (state == AppLifecycleState.resumed) {
      MusicHelper.resumeMusic();
    }
  }

  @override
  void initState() {
    super.initState();
    _loadMusicPreference();
    _loadSoundPreference();
    WidgetsBinding.instance.addObserver(this);
    EffectHelper.loadSound();
  }

  _loadMusicPreference() async {
    setState(() {
      isMusicOn = PrefsHelper.getBool('isMusicOn');
    });

    if (isMusicOn) {
      playMusic();
    }
  }

  _loadSoundPreference() async {
    setState(() {
      isSoundOn = PrefsHelper.getBool('isSoundOn');
    });
  }

  playMusic() async {
    MusicHelper.playMusic();
  }

  stopMusic() {
    MusicHelper.stopMusic();
  }

  @override
  dispose() {
    super.dispose();
    MusicHelper.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Removes splash screen when background image is loaded
    return FutureBuilder<void>(
      future: precacheImage(
          const AssetImage("assets/main_background.png"), context),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Container(
            color: const Color(0xFF0B0C0F),
          );
        }
        FlutterNativeSplash.remove();
        return Scaffold(
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage("assets/main_background.png"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    const Color(0x7F0B0C0F).withOpacity(0.5),
                    BlendMode.colorBurn),
              ),
            ),
            child: SafeArea(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // quote logo
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: 48,
                          height: 48,
                          padding: const EdgeInsets.all(4),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Image.asset("assets/icons/logo.png"),
                        ),
                      ),
                      // Settings button
                      GestureDetector(
                        onTap: () {
                          if (isSoundOn) {
                            EffectHelper.playSound();
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SettingsPage(),
                            ),
                          ).then((result) {
                            // Play music and update sound preference if set so
                            if (result != null && result is Map) {
                              setState(() {
                                isMusicOn = result['isMusicOn'] ?? isMusicOn;
                                isSoundOn = result['isSoundOn'] ?? isSoundOn;
                              });

                              isMusicOn
                                  ? MusicHelper.playMusic()
                                  : MusicHelper.stopMusic();
                            }
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            width: 48,
                            height: 48,
                            padding: const EdgeInsets.all(4),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF0B0C0F),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child:
                                Image.asset("assets/icons/settings_icon.png"),
                          ),
                        ),
                      ),
                    ]),
                // Main page text on top of the background image
                Expanded(
                  child: SvgPicture.asset(
                    "assets/text_main_page.svg",
                  ),
                ),

                // Menu buttons
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE3E7EB),
                  ),
                  child: Column(children: [
                    MenuButton(
                      text: "QUOTE OF THE DAY",
                      isSoundEnabled: isSoundOn,
                      onPressed: () {
                        if (isSoundOn) {
                          EffectHelper.playSound();
                        }
                        Navigator.pushNamed(context, '/quote');
                      },
                    ),
                    MenuButton(
                      text: "ABOUT",
                      isSoundEnabled: isSoundOn,
                      onPressed: () {
                        Navigator.pushNamed(context, '/about');
                      },
                    ),
                    MenuButton(
                      text: "QUIT",
                      isSoundEnabled: isSoundOn,
                      onPressed: () {
                        SystemChannels.platform
                            .invokeMethod('SystemNavigator.pop');
                      },
                    ),
                  ]),
                )
              ]),
            ),
          ),
        );
      },
    );
  }
}
