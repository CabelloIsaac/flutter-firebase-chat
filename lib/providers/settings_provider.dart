import 'package:hive/hive.dart';

class SettingsProvider {
  static bool isDarkTheme() {
    return Hive.box("settings").get("darkTheme", defaultValue: false);
  }

  static void setDarkTheme(bool value) {
    Hive.box("settings").put("darkTheme", value);
  }
}
