import 'dart:io';

import 'package:flutter/material.dart';
import 'package:oyuncak_takasi/services/auth_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  final Logger _logger = Logger();
  String _email = '';
  String _password = '';
  String _username = '';
  String _profilePictureUrl = '';

  void _performRegister() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      dynamic user = await _authService.registerWithEmailAndPassword(
          _email, _password, _username, _profilePictureUrl);
      if (user == null) {
        _logger.e('Kayıt başarısız oldu');
      } else {
        _logger.i('Kayıt başarılı: ${user.uid}');
      }
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      String url = await _uploadFile(image);
      setState(() {
        _profilePictureUrl = url;
      });
    }
  }

  Future<String> _uploadFile(XFile file) async {
    File imageFile = File(file.path);
    String fileName = path.basename(imageFile.path);

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("profile_pictures/$fileName");

    UploadTask uploadTask = ref.putFile(imageFile);
    await uploadTask.whenComplete(() => null);

    String returnURL = '';
    await ref.getDownloadURL().then((fileURL) {
      returnURL = fileURL;
    });

    return returnURL;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kayıt Ol'),
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
              TextFormField(
                decoration: const InputDecoration(labelText: 'Kullanıcı Adı'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Lütfen bir kullanıcı adı girin';
                  }
                  return null;
                },
                onSaved: (value) => _username = value!,
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Profil Resmi URL'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Lütfen bir profil resmi URL\'si girin';
                  }
                  return null;
                },
                onSaved: (value) => _profilePictureUrl = value!,
              ),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Profil Resmi Seç'),
              ),
              ElevatedButton(
                onPressed: _performRegister,
                child: const Text('Kayıt Ol'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
