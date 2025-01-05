import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(UniConnectApp());
}

class UniConnectApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniConnect',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(),
    );
  }
}
