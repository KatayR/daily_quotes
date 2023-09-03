import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: precacheImage(
          const AssetImage("assets/main_background.png"), context),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SvgPicture.asset("assets/loading.svg",
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                semanticsLabel: 'Loading'),
          );
        }

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/settings');
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
                  Expanded(
                    child: SvgPicture.asset("assets/text_main_page.svg",
                        semanticsLabel: 'Text Main Page'),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE3E7EB),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: Column(
                        children: [
                          MenuButton(
                            text: "QUOTE OF THE DAY",
                            onPressed: () {
                              Navigator.pushNamed(context, '/quote');
                            },
                          ),
                          const SizedBox(height: 16),
                          MenuButton(
                            text: "ABOUT",
                            onPressed: () {
                              Navigator.pushNamed(context, '/about');
                            },
                          ),
                          const SizedBox(height: 16),
                          MenuButton(
                            text: "QUIT",
                            onPressed: () {
                              SystemChannels.platform
                                  .invokeMethod('SystemNavigator.pop');
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
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
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 48,
        // padding: const EdgeInsets.all(10),
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
    );
  }
}
