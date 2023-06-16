import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oyuncak_takasi/services/auth_service.dart';
import 'package:logger/logger.dart';
import 'package:oyuncak_takasi/screens/toy_listing_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class LoginScreenState {
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  final Logger _logger = Logger();

  void _performLogin() async {
    AuthService authService = AuthService();
    User? user =
        await authService.signInWithEmailAndPassword(_email, _password);
    if (user != null) {
      _logger.i('Giriş başarılı: ${user.uid}');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ToyListingScreen(),
        ),
      );
    } else {
      _logger.e('Giriş başarısız');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giriş Yap'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Lütfen bir email girin';
                  }
                  return null;
                },
                onSaved: (value) => _email = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Şifre'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Lütfen bir şifre girin';
                  }
                  return null;
                },
                onSaved: (value) => _password = value!,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
                    _performLogin();
                  }
                },
                child: const Text('Giriş Yap'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
