import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart'; // Logger kütüphanesini ekleyin

class ToyService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Logger _logger = Logger(); // Logger örneğini oluşturun

  // Oyuncak ekleme
  Future<void> addToy(Map<String, dynamic> toyData) async {
    try {
      await _firestore.collection('toys').add(toyData);
    } catch (e) {
      _logger.e('Oyuncak ekleme hatası: $e'); // Log oluşturun
      rethrow;
    }
  }

  // Oyuncakları getirme
  Stream<QuerySnapshot> getToys() {
    return _firestore.collection('toys').snapshots();
  }

  // Oyuncak bilgisini güncelleme
  Future<void> updateToy(String toyId, Map<String, dynamic> updatedData) async {
    try {
      await _firestore.collection('toys').doc(toyId).update(updatedData);
    } catch (e) {
      _logger.e('Oyuncak güncelleme hatası: $e'); // Log oluşturun
      rethrow;
    }
  }

  // Oyuncak silme
  Future<void> deleteToy(String toyId) async {
    try {
      await _firestore.collection('toys').doc(toyId).delete();
    } catch (e) {
      _logger.e('Oyuncak silme hatası: $e'); // Log oluşturun
      rethrow;
    }
  }

  // Firebase hatalarını yönetmek için bir fonksiyon
  String handleFirebaseErrors(FirebaseException error) {
    String errorMessage = '';

    if (error.code == 'permission-denied') {
      errorMessage = 'Bu işlemi yapmak için izniniz yok.';
    } else if (error.code == 'not-found') {
      errorMessage = 'Aradığınız oyuncak bulunamadı.';
    } else {
      errorMessage = 'Beklenmeyen bir hata oluştu.';
    }

    return errorMessage;
  }
}
