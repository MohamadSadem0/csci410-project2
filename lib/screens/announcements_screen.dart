import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/announcement_model.dart';
import '../widgets/announcement_card.dart';

class AnnouncementsScreen extends StatelessWidget {
  const AnnouncementsScreen({Key? key}) : super(key: key);

  Future<List<Announcement>> fetchAnnouncements() async {
    try {
      return await ApiService.getAnnouncements();
    } catch (e) {
      throw Exception('Error fetching announcements: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Announcements'),
      ),
      body: FutureBuilder<List<Announcement>>(
        future: fetchAnnouncements(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Failed to load announcements.\n${snapshot.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No announcements available'),
            );
          } else {
            final announcements = snapshot.data!;
            return ListView.builder(
              itemCount: announcements.length,
              itemBuilder: (context, index) {
                final announcement = announcements[index];
                return AnnouncementCard(
                  title: announcement.title,
                  message: announcement.message,
                );
              },
            );
          }
        },
      ),
    );
  }
}
