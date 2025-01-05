import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/announcement_model.dart';
import '../models/event_model.dart';

class ApiService {
  static const String baseUrl = 'http://mohamadserhal.atwebpages.com/';

  static dynamic _processResponse(http.Response response) {
    try {
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {"error": "Server error: ${response.statusCode}"};
      }
    } catch (e) {
      return {"error": "Failed to parse server response: $e"};
    }
  }

  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login.php'),
        body: {'email': email, 'password': password},
      );
      return _processResponse(response);
    } catch (e) {
      return {"error": "Login failed: $e"};
    }
  }

  static Future<Map<String, dynamic>> register(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register.php'),
        body: {'name': name, 'email': email, 'password': password},
      );
      return _processResponse(response);
    } catch (e) {
      return {"error": "Registration failed: $e"};
    }
  }

  static Future<List<Announcement>> getAnnouncements() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/get_announcements.php'));
      final data = _processResponse(response);
      if (data is List) {
        return data.map((json) => Announcement.fromJson(json)).toList();
      } else {
        throw Exception(data['error'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      throw Exception('Failed to load announcements: $e');
    }
  }

  static Future<Map<String, dynamic>> addEvent(
      String title, String description, String eventDate, String location, String role) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/add_event.php'),
        body: {
          'title': title,
          'description': description,
          'event_date': eventDate,
          'location': location,
          'role': role,
        },
      );
      return _processResponse(response);
    } catch (e) {
      return {"error": "Failed to add event: $e"};
    }
  }

  static Future<List<Event>> getEvents() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/get_events.php'));
      final data = _processResponse(response);
      if (data is List) {
        return data.map((json) => Event.fromJson(json)).toList();
      } else {
        throw Exception(data['error'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      throw Exception('Failed to load events: $e');
    }
  }

  static Future<Map<String, dynamic>> addAnnouncement(String title, String message, String role) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/add_announcement.php'),
        body: {'title': title, 'message': message, 'role': role},
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {"error": "Failed to add announcement. Server error."};
      }
    } catch (e) {
      return {"error": "Failed to add announcement: $e"};
    }
  }
}
