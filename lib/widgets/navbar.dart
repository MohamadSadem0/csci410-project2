import 'package:flutter/material.dart';
import '../screens/announcements_screen.dart';
import '../screens/even_screen.dart';
import '../screens/add_event_screen.dart';
import '../screens/add_announcement_screen.dart';
import '../screens/login_screen.dart';

class NavBar extends StatelessWidget {
  final String role;

  NavBar({required this.role});

  void logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'UniConnect',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                SizedBox(height: 8),
                Text(
                  'Role: $role',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.announcement),
            title: Text('Announcements'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AnnouncementsScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.event),
            title: Text('Events'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EventsScreen()),
              );
            },
          ),
          if (role == 'admin')
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Add Announcement'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddAnnouncementScreen(role: role)),
                );
              },
            ),
          if (role == 'admin')
            ListTile(
              leading: Icon(Icons.add_circle),
              title: Text('Add Event'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddEventScreen(role: role)),
                );
              },
            ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () => logout(context),
          ),
        ],
      ),
    );
  }
}
