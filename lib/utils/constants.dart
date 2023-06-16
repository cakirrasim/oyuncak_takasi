import 'package:flutter/material.dart';

class Constants {
  // Renkler
  static const Color primaryColor = Color(0xFF123456);
  static const Color accentColor = Color(0xFF789ABC);
  static const Color backgroundColor = Color(0xFFF0F0F0);

  // Metin Stilleri
  static const TextStyle headingStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle titleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 16,
    color: Colors.grey,
  );

  // Düğme Stilleri
  static final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: primaryColor,
    textStyle: const TextStyle(fontSize: 16),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  static final ButtonStyle secondaryButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: primaryColor,
    backgroundColor: Colors.white,
    textStyle: const TextStyle(fontSize: 16),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: const BorderSide(color: primaryColor),
    ),
  );

  // Diğer Sabitler
  static const List<String> ageGroups = ['0-2', '3-5', '6-8', '9-12'];
  static const List<String> toyTypes = [
    'Oyuncak Araba',
    'Yapı Oyuncakları',
    'Kuklalar',
    'Eğitici Oyuncaklar',
    'Puzzle'
  ];

  // ... diğer sabitler ve ayarlar buraya eklenebilir.
}
