import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> createUser(String uid, Map<String, dynamic> userData) async {
    return await userCollection.doc(uid).set(userData);
  }

  Future updateUser(String uid, Map<String, dynamic> userData) async {
    return await userCollection.doc(uid).update(userData);
  }

  Future deleteUser(String uid) async {
    return await userCollection.doc(uid).delete();
  }

  Stream<QuerySnapshot> getUser(String uid) {
    return userCollection.doc(uid).collection('user').snapshots();
  }
}
