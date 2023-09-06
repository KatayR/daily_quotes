import 'package:daily_quotes/components/quote_logo.dart';
import 'package:daily_quotes/constants/about.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:daily_quotes/helper/prefs_helper.dart';
import '../components/menu_button.dart';
import '../helper/AudioHelper.dart';
import 'package:url_launcher/url_launcher.dart';

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
      isSoundOn = PrefsHelper.getBool('isSoundOn');
      isMusicOn = PrefsHelper.getBool('isMusicOn');
      isNotificationOn = PrefsHelper.getBool('isNotificationOn');
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
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'SETTINGS',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontFamily: 'Besley',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SettingRow(
                            text: 'Sound',
                            value: isSoundOn,
                            onChanged: (value) => setState(() {
                              if (isSoundOn) {
                                EffectHelper.playSound();
                              }
                              isSoundOn = value;
                            }),
                          ),
                          SettingRow(
                            text: 'Music',
                            value: isMusicOn,
                            onChanged: (value) => setState(() {
                              if (isSoundOn) {
                                EffectHelper.playSound();
                              }
                              isMusicOn = value;
                              if (isMusicOn) {
                                MusicHelper.playMusic();
                              } else {
                                MusicHelper.stopMusic();
                              }
                            }),
                          ),
                          // Privacy Policy Link
                          GestureDetector(
                            onTap: () {
                              launchUrl(
                                Uri.parse(privacyPolicyUrl),
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                'Privacy Policy',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  Container(
                    color: const Color(0xFFE3E7EB),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MenuButton(
                            text: 'SAVE',
                            isSoundEnabled: isSoundOn,
                            onPressed: () async {
                              await PrefsHelper.setBool('isSoundOn', isSoundOn);
                              await PrefsHelper.setBool('isMusicOn', isMusicOn);

                              Navigator.pop(context, {
                                'isMusicOn': isMusicOn,
                                'isSoundOn': isSoundOn
                              });
                            },
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
                ]),
            const QuoteLogo(),
          ]),
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

class SettingRow extends StatefulWidget {
  const SettingRow(
      {super.key,
      required this.text,
      required this.value,
      required this.onChanged});
  final String text;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  State<SettingRow> createState() => _SettingRowState();
}

class _SettingRowState extends State<SettingRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OptionText(text: widget.text),
        Switch(
          activeColor: const Color(0xffE3E7EB),
          activeTrackColor: const Color(0xFF66C03F),
          inactiveThumbColor: const Color(0xffE3E7EB),
          inactiveTrackColor: const Color(0xFF0B0C0F),
          splashRadius: 50.0,
          value: widget.value,
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
