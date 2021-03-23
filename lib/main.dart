import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';
import 'package:flutter_firebase_chat/providers/chats_provider.dart';
import 'package:flutter_firebase_chat/providers/complete_user_data_provider.dart';
import 'package:flutter_firebase_chat/providers/message_input_provider.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'auth_screens_manager.dart';
import 'providers/settings_provider.dart';
import 'providers/users_provider.dart';
import 'routes.dart';
import 'utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setStatusBarTransparent();
  await Firebase.initializeApp();
  await _initHive();
  runApp(MyApp());
}

void setStatusBarTransparent() {
  if (!kIsWeb) {
    final SystemUiOverlayStyle mySystemTheme =
        SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    );
    SystemChrome.setSystemUIOverlayStyle(mySystemTheme);
  }
}

Future<void> _initHive() async {
  if (kIsWeb) {
    Hive.init(null);
  } else {
    final appDocsDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocsDir.path);
  }
  await Hive.openBox('settings');
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider.instance()),
        ChangeNotifierProvider(create: (_) => CompleteUserDataProvider()),
        ChangeNotifierProvider(create: (_) => ChatsProvider()),
        ChangeNotifierProvider(create: (_) => UsersProvider()),
        ChangeNotifierProvider(create: (_) => MessageInputProvider()),
      ],
      child: StreamBuilder<BoxEvent>(
        stream: Hive.box("settings").watch(key: "darkTheme"),
        builder: (context, snapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: Constants.APP_NAME,
            home: AuthScreensManager(),
            routes: Routes.routes,
            theme: _themeDataLight(),
            themeMode: _themeModeManager(),
            darkTheme: _themeDataDark(),
          );
        },
      ),
    );
  }

  ThemeMode _themeModeManager() {
    return SettingsProvider.isDarkTheme() ? ThemeMode.dark : ThemeMode.light;
  }

  ThemeData _themeDataLight() {
    return ThemeData(
      primaryColor: Colors.blue,
      accentColor: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
      brightness: Brightness.light,
      primaryColorBrightness: Brightness.light,
      appBarTheme: AppBarTheme(
        color: Colors.white,
        brightness: Brightness.light,
        elevation: 0.0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(20.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 16.0),
        ),
      ),
    );
  }

  ThemeData _themeDataDark() {
    return ThemeData(
      primaryColor: Colors.blue.shade400,
      primaryColorBrightness: Brightness.dark,
      primaryColorLight: Colors.black,
      brightness: Brightness.dark,
      primaryColorDark: Colors.blue.shade400,
      indicatorColor: Colors.white,
      canvasColor: Colors.black,
      // next line is important!
      appBarTheme: AppBarTheme(
        color: Colors.black,
        brightness: Brightness.dark,
        elevation: 0.0,
      ),
      accentColor: Colors.blue.shade400,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(20.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 16.0),
        ),
      ),
    );
  }
}
