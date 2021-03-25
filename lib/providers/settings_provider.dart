import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class SettingsProvider with ChangeNotifier {
  bool _isOnMobile = true;

  bool get isOnMobile => _isOnMobile;

  set isOnMobile(bool value) {
    _isOnMobile = value;
    notifyListeners();
  }

  static bool isDarkTheme() {
    return Hive.box("settings").get("darkTheme", defaultValue: false);
  }

  static void setDarkTheme(bool value) {
    Hive.box("settings").put("darkTheme", value);
  }
}
