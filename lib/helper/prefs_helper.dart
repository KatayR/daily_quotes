// prefs_helper.dart
import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper {
  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static int getLastQuoteIndex() {
    return prefs.getInt('lastQuoteIndex') ?? 0;
  }

  static setLastQuoteIndex(int value) {
    prefs.setInt('lastQuoteIndex', value);
  }
}
