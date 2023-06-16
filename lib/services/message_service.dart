import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logging/logging.dart';

class MessageService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Logger _logger = Logger('MessageService');

  // Mesaj gönderme
  Future<void> sendMessage(String conversationId, String senderId,
      String receiverId, String message) async {
    try {
      await _firestore
          .collection('conversations')
          .doc(conversationId)
          .collection('messages')
          .add({
        'senderId': senderId,
        'receiverId': receiverId,
        'message': message,
        'timestamp': DateTime.now(),
      });
    } catch (e) {
      _logger.severe('Mesaj gönderme hatası: $e');
      rethrow;
    }
  }

  // Tek bir mesajı getirme
  Future<DocumentSnapshot> getMessage(
      String conversationId, String messageId) async {
    try {
      return _firestore
          .collection('conversations')
          .doc(conversationId)
          .collection('messages')
          .doc(messageId)
          .get();
    } catch (e) {
      _logger.severe('Mesaj getirme hatası: $e');
      rethrow;
    }
  }

  // Tüm mesajları getirme
  Stream<QuerySnapshot> getMessages(String conversationId) {
    try {
      return _firestore
          .collection('conversations')
          .doc(conversationId)
          .collection('messages')
          .orderBy('timestamp')
          .snapshots();
    } catch (e) {
      _logger.severe('Tüm mesajları getirme hatası: $e');
      rethrow;
    }
  }

  // Yeni bir konuşma oluşturma
  Future<DocumentReference> createConversation(
      String senderId, String receiverId) async {
    try {
      return _firestore.collection('conversations').add({
        'participants': [senderId, receiverId],
        'lastMessageTimestamp': DateTime.now(),
      });
    } catch (e) {
      _logger.severe('Konuşma oluşturma hatası: $e');
      rethrow;
    }
  }

  // Diğer mesajlaşma işlemleri

  // ...
}
