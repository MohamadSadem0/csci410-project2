import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../utils/password_validator.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String message = '';

  Future<void> registerUser() async {
    final passwordError = PasswordValidator.validatePassword(passwordController.text.trim());

    if (passwordError != null) {
      setState(() {
        message = passwordError;
      });
      return;
    }

    setState(() {
      message = 'Registering...';
    });

    try {
      final response = await ApiService.register(
        nameController.text.trim(),
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (response.containsKey('message')) {
        setState(() {
          message = response['message'];
        });

        if (response['message'] == 'Registration successful.') {
          Navigator.pop(context);
        }
      } else if (response.containsKey('error')) {
        setState(() {
          message = response['error'];
        });
      } else {
        setState(() {
          message = 'An unknown error occurred.';
        });
      }
    } catch (e) {
      setState(() {
        message = 'Failed to register. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: registerUser,
              child: Text('Register'),
            ),
            SizedBox(height: 10),
            Text(
              message,
              style: TextStyle(color: message.contains('successful') ? Colors.green : Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
