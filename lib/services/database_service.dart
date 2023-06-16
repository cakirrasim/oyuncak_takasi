import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

final Logger _logger = Logger();

class DatabaseService {
  final CollectionReference toysCollection =
      FirebaseFirestore.instance.collection('toys');

  Future<List<Map<String, dynamic>>> getToys() async {
    QuerySnapshot querySnapshot = await toysCollection.get();
    final allData = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
    _logger.i(allData);
    return allData;
  }

  void addToy(String id, String toyName, String description, String ageGroup, String category, String subCategory, String imageUrl) {
  toysCollection.add({
    'id': id,
    'name': toyName,
    'description': description,
    'ageGroup': ageGroup,
    'category': category,
    'subCategory': subCategory,
    'imageUrl': imageUrl,
  });
 }

}
