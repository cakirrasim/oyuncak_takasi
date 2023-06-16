import 'package:flutter/material.dart';
import 'package:oyuncak_takasi/screens/toy_details_screen.dart';
import 'package:oyuncak_takasi/services/database_service.dart';
import 'package:oyuncak_takasi/utils/constants.dart';

class ToyListingScreen extends StatefulWidget {
  const ToyListingScreen({Key? key}) : super(key: key);

  @override
  ToyListingScreenState createState() => ToyListingScreenState();
}

class ToyListingScreenState extends State<ToyListingScreen> {
  DatabaseService dbService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toy Listings'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: dbService.getToys(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      snapshot.data?[index]['name'],
                      style: Constants.titleStyle, // Başlık stilini uygula
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ToyDetailsScreen(
                              toyName: snapshot.data?[index]['name'],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
