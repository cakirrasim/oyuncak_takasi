import 'package:cloud_firestore/cloud_firestore.dart';

class SwapService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId;

  SwapService({required this.userId});

  // Takas ekleme
  Future<void> addSwap(Map<String, dynamic> swapData) async {
    try {
      await _firestore.collection('swaps').add(swapData);
    } catch (e) {
      rethrow;
    }
  }

  // Takasları getirme
  Stream<QuerySnapshot> getSwaps() {
    return _firestore.collection('swaps').snapshots();
  }

  // Takas bilgisini güncelleme
  Future<void> updateSwap(
      String swapId, Map<String, dynamic> updatedData) async {
    try {
      await _firestore.collection('swaps').doc(swapId).update(updatedData);
    } catch (e) {
      rethrow;
    }
  }

  // Takas silme
  Future<void> deleteSwap(String swapId) async {
    try {
      await _firestore.collection('swaps').doc(swapId).delete();
    } catch (e) {
      rethrow;
    }
  }

  // Kullanıcının takasları
  Stream<QuerySnapshot> getUserSwaps() {
    return _firestore
        .collection('swaps')
        .where('userId', isEqualTo: userId)
        .snapshots();
  }
}
