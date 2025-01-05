import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/event_model.dart';
import '../widgets/event_card.dart';

class EventsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Events')),
      body: FutureBuilder<List<Event>>(
        future: ApiService.getEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading events: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No events available'));
          } else {
            final events = snapshot.data!;
            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return EventCard(
                  title: event.title,
                  description: event.description,
                  date: event.date,
                  location: event.location,
                );
              },
            );
          }
        },
      ),
    );
  }
}
