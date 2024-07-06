import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storative/view/add_story.dart';
import 'package:storative/view/login.dart';
import 'package:storative/view/register.dart';
import 'package:storative/view/story_list.dart';
import 'utils/preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Preferences(),
      child: MaterialApp(
        title: 'Dicoding Stories',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Consumer<Preferences>(
          builder: (context, prefs, _) {
            return prefs.token == null ? Login() : StoryList();
          },
        ),
        routes: {
          '/login': (_) => Login(),
          '/register': (_) => Register(),
          '/stories': (_) => StoryList(),
          '/stories/add': (_) => AddStory(),
        },
      ),
    );
  }
}
