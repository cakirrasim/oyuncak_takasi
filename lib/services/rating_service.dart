import 'package:cloud_firestore/cloud_firestore.dart';

class RatingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Kullanıcının takas deneyimini değerlendirme
  Future<void> rateUser(String userId, int rating) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'rating': rating,
      });
    } catch (e) {
      print('Kullanıcı değerlendirme hatası: $e');
      rethrow;
    }
  }

  // Kullanıcının değerlendirme bilgisini alma
  Future<int> getUserRating(String userId) async {
    try {
      final DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(userId).get();
      final Map<String, dynamic>? userData =
          snapshot.data() as Map<String, dynamic>?;

      if (userData != null && userData.containsKey('rating')) {
        return userData['rating'] as int;
      }
      return 0;
    } catch (e) {
      print('Kullanıcı değerlendirme bilgisi alma hatası: $e');
      rethrow;
    }
  }

  // Diğer değerlendirme işlemleri

  // ...
}
