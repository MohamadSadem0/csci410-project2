import 'package:flutter/material.dart';

class AnnouncementDetailsScreen extends StatelessWidget {
  final String title;
  final String message;

  AnnouncementDetailsScreen({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Announcement Details')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text(message, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
