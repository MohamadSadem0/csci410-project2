import 'package:flutter/material.dart';
import '../screens/announcement_details_screen.dart';

class AnnouncementCard extends StatelessWidget {
  final String title;
  final String message;

  AnnouncementCard({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnnouncementDetailsScreen(
              title: title,
              message: message,
            ),
          ),
        );
      },
      child: Card(
        child: ListTile(
          title: Text(title),
          subtitle: Text(message),
        ),
      ),
    );
  }
}
