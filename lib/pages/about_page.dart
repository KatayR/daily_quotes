import 'package:daily_quotes/components/quote_logo.dart';
import 'package:daily_quotes/constants/about.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/menu_button.dart';
import '../helper/prefs_helper.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  bool isSoundOn = false;

  @override
  void initState() {
    super.initState();
    _loadSoundPreference();
  }

  _loadSoundPreference() async {
    setState(() {
      isSoundOn = PrefsHelper.getBool('isSoundOn');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xFFE3E7EB), Color(0xFFB5B9C0)],
          ),
        ),
        child: SafeArea(
          child: Stack(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(children: [
                  // title
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'ABOUT',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'Besley',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  // the "about" text
                  Padding(
                    padding: EdgeInsets.all(28.0),
                    child: Text(
                      aboutText,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Helvetica Neue',
                        fontWeight: FontWeight.w400,
                        height: 1.25,
                      ),
                    ),
                  ),
                ]),
                // the "back" and "quit" buttons
                Container(
                  color: const Color(0xFFE3E7EB),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MenuButton(
                          text: 'BACK',
                          isSoundEnabled: isSoundOn,
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(height: 16),
                        MenuButton(
                          text: 'QUIT',
                          isSoundEnabled: isSoundOn,
                          onPressed: () => SystemChannels.platform
                              .invokeMethod('SystemNavigator.pop'),
                        ),
                      ]),
                ),
              ],
            ),
            const QuoteLogo(),
          ]),
        ),
      ),
    );
  }
}
