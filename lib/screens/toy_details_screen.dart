import 'package:flutter/material.dart';
import 'package:oyuncak_takasi/utils/constants.dart';

class ToyDetailsScreen extends StatefulWidget {
  final String toyName;

  const ToyDetailsScreen({Key? key, required this.toyName}) : super(key: key);

  @override
  _ToyDetailsScreenState createState() => _ToyDetailsScreenState();
}

class _ToyDetailsScreenState extends State<ToyDetailsScreen> {
  List<String> comments = [
    'Great toy!',
    'Looks fun!',
    'My kids would love this!'
  ];
  final _formKey = GlobalKey<FormState>();
  String newComment = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.toyName),
        backgroundColor: Constants.primaryColor, // Başlık çubuğu rengi
      ),
      body: Column(
        children: [
          // Oyuncak detayları buraya gelecek
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(comments[index]),
                  subtitle: const Text(
                    'Username',
                    style:
                        Constants.subtitleStyle, // Kullanıcı adı stilini uygula
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Add a comment',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        newComment = value!;
                      },
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      setState(() {
                        comments.add(newComment);
                      });
                    }
                  },
                  color: Constants.primaryColor, // İkon rengini güncelle
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
