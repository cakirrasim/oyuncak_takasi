import 'package:flutter/material.dart';

import 'package:oyuncak_takasi/utils/constants.dart';

class UserRating extends StatelessWidget {
  final double rating;

  const UserRating({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (index) => Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Constants.accentColor,
        ),
      ),
    );
  }
}
