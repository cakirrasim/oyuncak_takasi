import 'package:flutter/material.dart';
import 'package:oyuncak_takasi/screens/add_toy_screen.dart';
import 'package:oyuncak_takasi/services/auth_service.dart';
import 'package:oyuncak_takasi/screens/login_screen.dart';
import 'package:oyuncak_takasi/utils/constants.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: Constants.primaryButtonStyle,
              child: const Text('Add Toy'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddToyScreen()),
                );
              },
            ),
            ElevatedButton(
              style: Constants.secondaryButtonStyle,
              child: const Text('Çıkış Yap'),
              onPressed: () {
                AuthService().signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
