import 'package:flutter/material.dart';
import '../helper/AudioHelper.dart';

class MenuButton extends StatelessWidget {
  MenuButton(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.isSoundEnabled});
  bool isSoundEnabled;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (isSoundEnabled) {
          EffectHelper.playSound();
        }
        onPressed();
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
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
