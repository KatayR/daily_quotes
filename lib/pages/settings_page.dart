import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:daily_quotes/helper/prefs_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helper/AudioHelper.dart';
import 'package:restart_app/restart_app.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isSoundOn = false;
  bool isMusicOn = false;
  bool isNotificationOn = false;

  @override
  void initState() {
    super.initState();
    _loadInitialPreferences();
  }

  @override
  dispose() {
    super.dispose();
  }

  _loadInitialPreferences() async {
    setState(() {
      isSoundOn = PrefsHelper.getBool('isSoundOn') ?? false;
      isMusicOn = PrefsHelper.getBool('isMusicOn') ?? false;
      isNotificationOn = PrefsHelper.getBool('isNotificationOn') ?? false;
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
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(children: [
                      const Text(
                        'SETTINGS',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontFamily: 'Besley',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const OptionText(text: 'Sound'),
                          Switch(
                            activeColor: const Color(0xffE3E7EB),
                            activeTrackColor: const Color(0xFF66C03F),
                            inactiveThumbColor: const Color(0xffE3E7EB),
                            inactiveTrackColor: const Color(0xFF0B0C0F),
                            splashRadius: 50.0,
                            value: isSoundOn,
                            onChanged: (value) => setState(() {
                              isSoundOn = value;
                              PrefsHelper.setBool('isSoundOn', value);
                            }),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const OptionText(text: 'Music'),
                          Switch(
                            activeColor: const Color(0xffE3E7EB),
                            activeTrackColor: const Color(0xFF66C03F),
                            inactiveThumbColor: const Color(0xffE3E7EB),
                            inactiveTrackColor: const Color(0xFF0B0C0F),
                            splashRadius: 50.0,
                            value: isMusicOn,
                            onChanged: (value) => setState(() {
                              isMusicOn = value;
                              // if (isMusicOn) {
                              //   AudioHelper.playMusic();
                              // } else {
                              //   AudioHelper.stopMusic();
                              //   // Restart.restartApp();
                              // }
                            }),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const OptionText(text: 'Notifications'),
                          Switch(
                            activeColor: const Color(0xffE3E7EB),
                            activeTrackColor: const Color(0xFF66C03F),
                            inactiveThumbColor: const Color(0xffE3E7EB),
                            inactiveTrackColor: const Color(0xFF0B0C0F),
                            splashRadius: 50.0,
                            value: isNotificationOn,
                            onChanged: (value) => setState(() {
                              isNotificationOn = value;
                              PrefsHelper.setBool('isNotificationOn', value);
                            }),
                          ),
                        ],
                      ),
                    ]),
                  ),
                  // MARK
                  Container(
                    color: Color(0xFFE3E7EB),
                    width: double.infinity,
                    height: 240,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MenuButton(
                            onPressed: () {
                              PrefsHelper.setBool('isMusicOn', isMusicOn);

                              // restart app
                              Restart.restartApp();
                            },
                            text: 'SAVE'),
                        MenuButton(
                            onPressed: () => SystemChannels.platform
                                .invokeMethod('SystemNavigator.pop'),
                            text: 'QUIT'),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 200,
                right: 10,
                child: Image.asset(
                  'assets/icons/logo.png',
                  width: 100,
                  height: 100,
                  scale: 2.8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  const MenuButton({super.key, required this.onPressed, required this.text});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 48,
          decoration: ShapeDecoration(
            color: const Color(0xFF0B0C0F),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Center(
            child: Text(
              text,
              // textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFFE3E7EB),
                fontSize: 20,
                fontFamily: 'Besley',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OptionText extends StatelessWidget {
  final String text;

  const OptionText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontFamily: 'Helvetica Neue',
        fontWeight: FontWeight.w400,
        height: 1.25,
      ),
    );
  }
}
