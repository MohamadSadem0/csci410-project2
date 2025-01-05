import 'package:flutter/material.dart';

class EventDetailsScreen extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final String location;

  EventDetailsScreen({
    required this.title,
    required this.description,
    required this.date,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Event Details')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text('Date: $date', style: TextStyle(fontSize: 16)),
            Text('Location: $location', style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Text(description, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
