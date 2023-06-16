import 'package:flutter/material.dart';
import 'package:oyuncak_takasi/models/toy.dart';
import 'package:oyuncak_takasi/utils/constants.dart';

class ToyCard extends StatelessWidget {
  final Toy toy;

  const ToyCard({Key? key, required this.toy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              toy.name,
              style: Constants.titleStyle,
            ),
            const SizedBox(height: 8),
            Text(
              'Yaş Grubu: ${toy.ageGroup}',
              style: Constants.subtitleStyle,
            ),
            const SizedBox(height: 8),
            Image.network(
              toy.imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              style: Constants.primaryButtonStyle,
              onPressed: () {
                // Takas teklifi yapma işlemleri
              },
              child: const Text('Takas Teklifi Yap'),
            ),
          ],
        ),
      ),
    );
  }
}
