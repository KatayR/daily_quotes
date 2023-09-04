import 'dart:math';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:daily_quotes/constants/quotes.dart';
import 'package:daily_quotes/helper/prefs_helper.dart';
import 'package:flutter/services.dart';
import '../helper/AudioHelper.dart';

class QuotePage extends StatefulWidget {
  const QuotePage({super.key});

  @override
  State<QuotePage> createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  String currentQuote = '';
  String currentAuthor = '';
  late int lastQuoteIndex;
  bool isSoundOn = false;

  @override
  void initState() {
    super.initState();
    lastQuoteIndex = PrefsHelper.getLastQuoteIndex();
    currentQuote = getNextQuote();
    _loadSoundPreference();
  }

  _loadSoundPreference() async {
    setState(() {
      isSoundOn = PrefsHelper.getBool('isSoundOn') ?? false;
    });
  }

  String getNextQuote() {
    if (lastQuoteIndex >= quotes.length) {
      lastQuoteIndex = 0;
    }
    PrefsHelper.setLastQuoteIndex(lastQuoteIndex + 1);
    final fullQuote = quotes[lastQuoteIndex++].split(" — ");
    currentQuote = fullQuote[0];
    currentAuthor = fullQuote[1];
    return currentQuote;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () {
            if (isSoundOn) {
              EffectHelper.playSound();
            }
            Navigator.pop(context);
          },
          child: const Row(
            children: [
              Icon(Icons.arrow_back_ios, color: Colors.black),
              Text(
                'MENU',
                style: TextStyle(
                  color: Color(0xFF0B0C0F),
                  fontSize: 20,
                  fontFamily: 'Besley',
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          // author container
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.00, -1.00),
                end: Alignment(0, 1),
                colors: [Color(0xFFFFAF14), Color(0xFFFF7902)],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 98.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: LayoutBuilder(
                  // code for centering author name vertically, between
                  // top of the screen and bottom containers
                  builder: (BuildContext context, BoxConstraints constraints) {
                    double totalHeight = constraints.maxHeight;
                    double bottomContainerHeight = totalHeight * 0.5;
                    double remainingHeight =
                        totalHeight - bottomContainerHeight;

                    return Padding(
                      padding: EdgeInsets.only(top: remainingHeight / 4),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: DottedBorder(
                          customPath: (size) {
                            return Path()
                              ..moveTo(0, size.height)
                              ..lineTo(size.width, size.height);
                          },
                          dashPattern: const [5, 4],
                          strokeWidth: 1,
                          color: const Color(0xFFFFE3AC),
                          child: Text(
                            currentAuthor.toUpperCase(),
                            style: const TextStyle(
                              color: Color(0xFFFFE3AC),
                              fontSize: 24,
                              fontFamily: 'Besley',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          // "quote" container
          Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              children: [
                LayoutBuilder(
                  // code for calculating logo size
                  builder: (context, constraints) {
                    final double containerHeight = constraints.maxHeight;
                    final double containerWidth = constraints.maxWidth;
                    final double logoArea = containerHeight *
                        containerWidth *
                        0.02; // 2% of container area
                    final double logoSideLength = sqrt(logoArea);

                    return Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.5,
                          decoration: const ShapeDecoration(
                            color: Color(0xFFE3E7EB),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(100),
                              ),
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Text(
                                currentQuote,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color(0xFF0B0C0F),
                                  fontSize: 20,
                                  fontFamily: 'Helvetica Neue',
                                  fontWeight: FontWeight.w400,
                                  height: 1.25,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Image.asset(
                            "assets/icons/logo.png",
                            width: logoSideLength,
                            height: logoSideLength,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          // Bottom buttons
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
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
                    child: IconButton(
                      onPressed: () {
                        if (isSoundOn) {
                          EffectHelper.playSound();
                        }
                        Clipboard.setData(ClipboardData(
                            text: "$currentQuote — $currentAuthor"));
                        // show toast message
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Copied to clipboard'),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.copy,
                        color: Color(0xFFE3E7EB),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 48,
                      height: 48,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF66C03F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {
                          if (isSoundOn) {
                            EffectHelper.playSound();
                          }
                          setState(() {
                            getNextQuote();
                          });
                        },
                        icon: const Icon(
                          Icons.autorenew,
                          color: Color(0xFFE3E7EB),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
