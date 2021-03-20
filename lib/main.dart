import 'package:flutter/material.dart';

import 'routes.dart';
import 'ui/screens/login/login_screen.dart';
import 'utils/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.APP_NAME,
      routes: Routes.routes,
      initialRoute: LoginScreen.route,
    );
  }
}
