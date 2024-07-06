import 'package:flutter/material.dart';
import '../models/story.dart';

class StoryDetail extends StatelessWidget {
  final Story story;

  StoryDetail({required this.story});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(story.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(story.photoUrl),
            SizedBox(height: 10),
            Text(story.description, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
