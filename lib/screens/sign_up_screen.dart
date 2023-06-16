import 'package:flutter/material.dart';
import 'package:oyuncak_takasi/main.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _password = '';

  void _submit() {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();

    // TODO: Implement sign up functionality

    print('Name: $_name, Email: $_email, Password: $_password');

    // Navigate to the main screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const OyuncakTakasiApp(),
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) => value!.isEmpty ? 'Name is required.' : null,
              onSaved: (value) => _name = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) =>
                  value!.isEmpty ? 'Email is required.' : null,
              onSaved: (value) => _email = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) =>
                  value!.isEmpty ? 'Password is required.' : null,
              onSaved: (value) => _password = value!,
            ),
            ElevatedButton(
              child: const Text('Sign Up'),
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
