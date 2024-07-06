import 'package:flutter/material.dart';
import '../services/api_service.dart';

class Register extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                bool success = await ApiService.register(
                  _nameController.text,
                  _emailController.text,
                  _passwordController.text,
                );
                if (success) {
                  Navigator.pop(context);
                } else {
                  // Handle registration error
                }
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
