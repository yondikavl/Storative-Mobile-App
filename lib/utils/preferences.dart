import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences with ChangeNotifier {
  String? _token;

  String? get token => _token;

  Preferences() {
    _loadToken();
  }

  Future<void> _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    notifyListeners();
  }

  Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = token;
    await prefs.setString('token', token);
    notifyListeners();
  }

  Future<void> clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = null;
    await prefs.remove('token');
    notifyListeners();
  }
}
