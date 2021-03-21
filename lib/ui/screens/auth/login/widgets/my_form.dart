import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  AuthProvider _authProvider;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<AuthProvider>(context);
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
    if (value.trim().isEmpty) {
      return "Introduce tu correo electrónico";
    } else if (!EmailValidator.validate(value.trim())) {
      return "Introduce un correo electrónico válido";
    }
    return null;
  }

  String _validatorPassword(String value) {
    if (value.trim().isEmpty)
      return "Introduce tu contraseña";
    else if (value.trim().length < 6) return "La contraseña es muy corta";
    return null;
  }

  void _login() {
    if (_formKey.currentState.validate()) {
      String email = _controllerEmail.text.trim();
      String password = _controllerPassword.text.trim();
      _authProvider.signInWithEmailAndPassword(email, password);
    } else {
      print("Error in some field");
    }
  }
}
