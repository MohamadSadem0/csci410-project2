import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AddAnnouncementScreen extends StatefulWidget {
  final String role;

  AddAnnouncementScreen({required this.role});

  @override
  _AddAnnouncementScreenState createState() => _AddAnnouncementScreenState();
}

class _AddAnnouncementScreenState extends State<AddAnnouncementScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  String statusMessage = '';

  Future<void> addAnnouncement() async {
    setState(() {
      statusMessage = 'Adding announcement...';
    });

    try {
      final response = await ApiService.addAnnouncement(
        titleController.text.trim(),
        messageController.text.trim(),
        widget.role,
      );

      if (response.containsKey('message')) {
        setState(() {
          statusMessage = response['message'];
        });
        titleController.clear();
        messageController.clear();
      } else {
        setState(() {
          statusMessage = response['error'] ?? 'An unknown error occurred.';
        });
      }
    } catch (e) {
      setState(() {
        statusMessage = 'Failed to add announcement. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Announcement')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: messageController,
              decoration: InputDecoration(labelText: 'Message'),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: addAnnouncement,
              child: Text('Add Announcement'),
            ),
            SizedBox(height: 10),
            Text(
              statusMessage,
              style: TextStyle(color: statusMessage.contains('success') ? Colors.green : Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
