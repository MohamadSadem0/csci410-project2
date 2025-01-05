import 'package:flutter/material.dart';
import 'package:project2/screens/add_announcement_screen.dart';
import '../widgets/navbar.dart';
import 'announcements_screen.dart';
import 'even_screen.dart';
import 'add_event_screen.dart';

class HomeScreen extends StatelessWidget {
  final String role;

  HomeScreen({required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: NavBar(role: role),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.blue, Colors.blueAccent]),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to UniConnect!',
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Role: $role',
                  style: TextStyle(color: Colors.white70, fontSize: 18),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              padding: EdgeInsets.all(16.0),
              children: [
                _buildFeatureCard(
                  context,
                  title: 'Announcements',
                  icon: Icons.announcement,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AnnouncementsScreen()),
                  ),
                ),
                _buildFeatureCard(
                  context,
                  title: 'Events',
                  icon: Icons.event,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EventsScreen()),
                  ),
                ),
                if (role == 'admin')
                  _buildFeatureCard(
                    context,
                    title: 'Add Event',
                    icon: Icons.add_circle,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddEventScreen(role: role)),
                    ),
                  ),
                if (role == 'admin')
                  _buildFeatureCard(
                    context,
                    title: 'Add Announcement',
                    icon: Icons.add,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddAnnouncementScreen(role: role)),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, {required String title, required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.blue),
            SizedBox(height: 8),
            Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
