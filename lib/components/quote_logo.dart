import 'package:flutter/material.dart';

class QuoteLogo extends StatelessWidget {
  const QuoteLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 160,
      right: 10,
      child: Image.asset(
        'assets/icons/logo.png',
        width: 100,
        height: 100,
        scale: 2.8,
      ),
    );
  }
}
