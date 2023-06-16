import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logging/logging.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _logger = Logger('DatabaseService');

  // Kullanıcı hesaplarıyla ilgili işlemler

  // Kullanıcı oluşturma
  Future<void> createUser(String userId, String username, String email) async {
    try {
      await _firestore.collection('users').doc(userId).set({
        'username': username,
        'email': email,
        // Diğer kullanıcı verileri
      });
    } catch (e, stackTrace) {
      _logger.severe('Kullanıcı oluşturma hatası: $e', e, stackTrace);
      rethrow;
    }
  }

  // Kullanıcı bilgilerini alma
  Future<Object?> getUser(String userId) async {
    try {
      final DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(userId).get();
      return snapshot.data();
    } catch (e, stackTrace) {
      _logger.severe('Kullanıcı bilgileri alma hatası: $e', e, stackTrace);
      rethrow;
    }
  }

  // Oyuncaklarla ilgili işlemler

  // Oyuncak listeleme
  Future<void> addToy(String userId, String toyName, String description,
      String imageUrl, String ageGroup) async {
    try {
      await _firestore.collection('toys').add({
        'userId': userId,
        'toyName': toyName,
        'description': description,
        'imageUrl': imageUrl,
        'ageGroup': ageGroup,
        // Diğer oyuncak verileri
      });
    } catch (e, stackTrace) {
      _logger.severe('Oyuncak ekleme hatası: $e', e, stackTrace);
      rethrow;
    }
  }

  // Oyuncakları getirme
  Stream<QuerySnapshot<Map<String, dynamic>>> getToys() {
    return _firestore.collection('toys').snapshots();
  }

  // Diğer veritabanı işlemleri

  // ...
}
