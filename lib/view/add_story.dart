import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/api_service.dart';

class AddStory extends StatefulWidget {
  @override
  _AddStoryState createState() => _AddStoryState();
}

class _AddStoryState extends State<AddStory> {
  final TextEditingController _descriptionController = TextEditingController();
  XFile? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Story'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_image != null) Image.file(File(_image!.path)),
            ElevatedButton(
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image =
                    await picker.pickImage(source: ImageSource.camera);
                setState(() {
                  _image = image;
                });
              },
              child: Text('Camera'),
            ),
            ElevatedButton(
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);
                setState(() {
                  _image = image;
                });
              },
              child: Text('Gallery'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_image != null && _descriptionController.text.isNotEmpty) {
                  bool success = await ApiService.addStory(
                    _descriptionController.text,
                    _image!,
                  );
                  if (success) {
                    Navigator.pop(context);
                  } else {
                    // Handle error
                  }
                }
              },
              child: Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }
}
