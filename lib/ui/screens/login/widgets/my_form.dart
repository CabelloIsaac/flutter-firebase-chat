import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _controllerEmail,
            validator: _validatorEmail,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(labelText: "Correo electrónico"),
          ),
          TextFormField(
            controller: _controllerPassword,
            validator: _validatorPassword,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              labelText: "Contraseña",
              suffixIcon: IconButton(
                icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility),
                onPressed: _showOrHidePassord,
              ),
            ),
            obscureText: _obscurePassword,
          ),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _login,
              child: Text("Acceder"),
            ),
          ),
        ],
      ),
    );
  }

  void _showOrHidePassord() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  String _validatorEmail(String value) {
    // if (value.trim().isEmpty) {
    //   return "Please, enter your email address";
    // } else if (!EmailValidator.validate(value.trim())) {
    //   return "Please, enter a valid email address";
    // }
    // return null;
  }

  String _validatorPassword(String value) {
    if (value.trim().isEmpty)
      return "Please, enter your password";
    else if (value.trim().length < 6)
      return "Password should be at least 6 characters";
    return null;
  }

  void _login() {}
}
