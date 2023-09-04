import 'package:daily_quotes/constants/about.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../helper/AudioHelper.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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
                  const Column(children: [
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
                              EffectHelper.playSound();
                              Navigator.pop(context);
                            },
                            text: 'BACK'),
                        MenuButton(
                            onPressed: () {
                              EffectHelper.playSound();
                              SystemChannels.platform
                                  .invokeMethod('SystemNavigator.pop');
                            },
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
