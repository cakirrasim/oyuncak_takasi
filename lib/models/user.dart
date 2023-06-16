import 'package:oyuncak_takasi/models/toy.dart';

class User {
  final String id;
  final String name;
  final String email;
  List<Toy> toys;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.toys = const [],
  });
}
