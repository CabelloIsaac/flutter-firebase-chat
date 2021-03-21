import 'package:flutter/material.dart';

import 'widgets/header.dart';
import 'widgets/my_form.dart';

class CompleteUserDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Header(),
              SizedBox(height: 40),
              MyForm(),
            ],
          ),
        ),
      ),
    );
  }
}
