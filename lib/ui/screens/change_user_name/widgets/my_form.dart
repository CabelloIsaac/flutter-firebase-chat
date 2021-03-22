import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();

  AuthProvider _authProvider;

  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<AuthProvider>(context);
    _controllerName.text = _authProvider.dbUser.name;
    _controllerLastName.text = _authProvider.dbUser.lastName;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _controllerName,
            validator: _validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              labelText: "Nombre",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _controllerLastName,
            validator: _validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              labelText: "Apellido",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _goToSelectAvatar,
              child: Text("Guardar cambios"),
            ),
          ),
        ],
      ),
    );
  }

  String _validator(String value) {
    if (value.trim().isEmpty) {
      return "Completa este campo";
    }
    return null;
  }

  void _goToSelectAvatar() {
    if (_formKey.currentState.validate()) {
      String name = _controllerName.text.trim();
      String lastName = _controllerLastName.text.trim();

      _authProvider.changeUserName(name, lastName);

      Navigator.pop(context);
    }
  }
}
