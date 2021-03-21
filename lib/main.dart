import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';
import 'package:flutter_firebase_chat/providers/complete_user_data_provider.dart';
import 'package:provider/provider.dart';

import 'auth_screens_manager.dart';
import 'routes.dart';
import 'utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider.instance()),
        ChangeNotifierProvider(create: (_) => CompleteUserDataProvider()),
      ],
      child: MaterialApp(
        title: Constants.APP_NAME,
        routes: Routes.routes,
        home: AuthScreensManager(),
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            elevation: 0,
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(15),
            ),
          ),
        ),
      ),
    );
  }
}
