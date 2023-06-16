import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:oyuncak_takasi/screens/toy_listing_screen.dart';
import 'package:oyuncak_takasi/screens/toy_swap_screen.dart';
import 'package:oyuncak_takasi/screens/user_profile_screen.dart';
import 'package:oyuncak_takasi/screens/search_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const OyuncakTakasiApp());
}

class OyuncakTakasiApp extends StatefulWidget {
  const OyuncakTakasiApp({Key? key}) : super(key: key);

  @override
  OyuncakTakasiAppState createState() => OyuncakTakasiAppState();
}

class OyuncakTakasiAppState extends State<OyuncakTakasiApp> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    const ToyListingScreen(),
    const ToySwapScreen(),
    const UserProfileScreen(),
    const SearchScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // Singleton özelliği ekliyoruz
  static OyuncakTakasiAppState? _instance;
  factory OyuncakTakasiAppState() {
    return _instance ??= OyuncakTakasiAppState._();
  }
  OyuncakTakasiAppState._();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oyuncak Takası',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _children,
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          backgroundColor: Colors.grey,
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.black,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.swap_horiz),
              label: 'Swap',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
          ],
        ),
      ),
    );
  }
}

