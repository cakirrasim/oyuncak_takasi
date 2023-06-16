import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddToyScreen extends StatefulWidget {
  const AddToyScreen({Key? key}) : super(key: key);

  @override
  _AddToyScreenState createState() => _AddToyScreenState();
}

class _AddToyScreenState extends State<AddToyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _toyNameController = TextEditingController();
  final _descriptionController = TextEditingController();

  final List<String> _ageGroups = [
    "0 - 2 Yaş",
    "3 - 5 Yaş",
    "6 - 9 Yaş",
    "10 - 12 Yaş",
    "13+ Yaş",
  ];

  final List<String> _categories = [
    "Action Figures and Accessories",
    "Arts and Crafts",
    "Baby and Early Childhood Toys",
    "Bikes, Scooters, and Ride-Ons",
    "Building Toys",
    "Dolls and Accessories",
    "Educational and Science Toys",
    "Electronic Toys",
    "Games and Puzzles",
    "Outdoor Play",
    "Plush Toys",
    "Pretend Play",
    "Vehicles and Remote-Control Toys",
  ];

  final List<String> _subCategories = [
    "Board Games",
    "Action Figures",
    "Stuffed Animals",
    "Dollhouses",
    "Ride-On Toys",
    "Construction Sets",
  ];

  String _selectedAgeGroup = '';
  String _selectedCategory = '';
  String _selectedSubCategory = '';
  XFile? _imageFile;

  @override
  void dispose() {
    _toyNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    XFile? selected = await ImagePicker().pickImage(source: source);
    setState(() {
      _imageFile = selected;
    });
  }

  Future<void> _uploadToy() async {
    String toyName = _toyNameController.text;
    String description = _descriptionController.text;

    // Upload the image to Firebase Storage
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('toys/${DateTime.now().toString()}.jpg');

    UploadTask uploadTask = ref.putFile(File(_imageFile!.path));
    await uploadTask.whenComplete(() async {
      // Get the download URL
      String downloadURL = await ref.getDownloadURL();

      // Save the toy info to Firestore
      FirebaseFirestore.instance.collection('toys').add({
        'name': toyName,
        'description': description,
        'ageGroup': _selectedAgeGroup,
        'category': _selectedCategory,
        'subCategory': _selectedSubCategory,
        'imageUrl': downloadURL,
      });

      // Clear the form
      _toyNameController.clear();
      _descriptionController.clear();
      setState(() {
        _selectedAgeGroup = '';
        _selectedCategory = '';
        _selectedSubCategory = '';
        _imageFile = null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Toy"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _toyNameController,
                  decoration: const InputDecoration(labelText: 'Toy Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a toy name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                DropdownSearch<String>(
                  items: _ageGroups,
                  onChanged: (value) {
                    _selectedAgeGroup = value!;
                  },
                ),
                DropdownSearch<String>(
                  items: _categories,
                  onChanged: (value) {
                    _selectedCategory = value!;
                  },
                ),
                DropdownSearch<String>(
                  items: _subCategories,
                  onChanged: (value) {
                    _selectedSubCategory = value!;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    _pickImage(ImageSource.gallery);
                  },
                  child: const Text("Pick Image"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        _selectedAgeGroup.isNotEmpty &&
                        _selectedCategory.isNotEmpty &&
                        _selectedSubCategory.isNotEmpty &&
                        _imageFile != null) {
                      _uploadToy();
                    }
                  },
                  child: const Text("Upload Toy"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
