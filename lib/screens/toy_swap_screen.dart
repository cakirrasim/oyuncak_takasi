import 'package:flutter/material.dart';

class ToySwapScreen extends StatefulWidget {
  const ToySwapScreen({Key? key}) : super(key: key);

  @override
  _ToySwapScreenState createState() => _ToySwapScreenState();
}

class _ToySwapScreenState extends State<ToySwapScreen> {
  List<String> toys = ['Toy 1', 'Toy 2', 'Toy 3', 'Toy 4', 'Toy 5'];
  final _formKey = GlobalKey<FormState>();
  String newOffer = '';

  void showSwapOfferDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Offer Swap'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Enter your swap offer',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onSaved: (value) {
                newOffer = value!;
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Offer Swap'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // TODO: Implement swap offer functionality
                  print('Swap offer: $newOffer');
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          color: Colors
              .blue, // Navigasyon düğmelerinin arka plan rengi olarak mavi seçildi
          child: AppBar(
            title: const Text(
              'Toy Swap',
              style: TextStyle(
                color: Colors.white, // Metin stilinde beyaz renk kullanıldı
              ),
            ),
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: toys.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              toys[index],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              child: const Text('Offer Swap'),
              onPressed: () {
                showSwapOfferDialog(context);
              },
            ),
          );
        },
      ),
    );
  }
}
