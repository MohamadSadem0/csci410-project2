import 'package:flutter/material.dart';
import '../screens/event_details_screen.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final String location;

  EventCard({
    required this.title,
    required this.description,
    required this.date,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailsScreen(
              title: title,
              description: description,
              date: date,
              location: location,
            ),
          ),
        );
      },
      child: Card(
        child: ListTile(
          title: Text(title),
          subtitle: Text(description),
          trailing: Text(date),
        ),
      ),
    );
  }
}
