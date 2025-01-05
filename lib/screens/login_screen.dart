import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String message = '';

  Future<void> loginUser() async {
    setState(() {
      message = 'Logging in...';
    });

    try {
      final response = await ApiService.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      if (response.containsKey('message')) {
        setState(() {
          message = response['message'];
        });

        if (response['message'] == 'Login successful') {
          final role = response['user']['role'];
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(role: role),
            ),
          );
        } else {
          setState(() {
            message = 'Unexpected server response.';
          });
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
        message = 'Failed to login. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                onPressed: loginUser,
                child: Text('Login'),
              ),
              SizedBox(height: 10),
              Text(
                message,
                style: TextStyle(color: message.startsWith('Login') ? Colors.green : Colors.red),
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Text('Don’t have an account? Register here'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
