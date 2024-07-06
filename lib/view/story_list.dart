import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storative/models/story.dart';
import 'package:storative/view/story_detail.dart';
import '../services/api_service.dart';
import '../utils/preferences.dart';

class StoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stories'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Provider.of<Preferences>(context, listen: false).clearToken();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Story>>(
        future: ApiService.getStories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No stories found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Story story = snapshot.data![index];
                return ListTile(
                  leading: Image.network(story.photoUrl),
                  title: Text(story.name),
                  subtitle: Text(story.description),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StoryDetail(story: story),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/stories/add');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
