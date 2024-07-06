import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storative/models/story.dart';

class ApiService {
  static const String baseUrl = 'https://story-api.dicoding.dev/v1';

  static Future<String?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['loginResult']['token'];
    } else {
      return null;
    }
  }

  static Future<bool> register(
      String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );

    return response.statusCode == 200;
  }

  static Future<List<Story>> getStories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$baseUrl/stories'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['listStory'] as List)
          .map((story) => Story.fromJson(story))
          .toList();
    } else {
      throw Exception('Failed to load stories');
    }
  }

  static Future<bool> addStory(String description, XFile image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/stories'))
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['description'] = description
      ..files.add(await http.MultipartFile.fromPath('photo', image.path));

    final response = await request.send();

    return response.statusCode == 200;
  }
}
