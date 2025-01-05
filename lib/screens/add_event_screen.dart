import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/api_service.dart';

class AddEventScreen extends StatefulWidget {
  final String role;

  AddEventScreen({required this.role});

  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  DateTime? selectedDate;
  String message = '';

  Future<void> pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  Future<void> addEvent() async {
    if (selectedDate == null) {
      setState(() {
        message = 'Please select a date.';
      });
      return;
    }

    try {
      final response = await ApiService.addEvent(
        titleController.text.trim(),
        descriptionController.text.trim(),
        DateFormat('yyyy-MM-dd').format(selectedDate!),
        locationController.text.trim(),
        widget.role,
      );

      setState(() {
        message = response['message'] ?? response['error'] ?? 'An error occurred';
      });
    } catch (e) {
      setState(() {
        message = 'Failed to add event.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Event')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            GestureDetector(
              onTap: pickDate,
              child: AbsorbPointer(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: selectedDate == null
                        ? 'Select Date'
                        : 'Date: ${DateFormat('yyyy-MM-dd').format(selectedDate!)}',
                  ),
                ),
              ),
            ),
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: addEvent,
              child: Text('Add Event'),
            ),
            SizedBox(height: 10),
            Text(
              message,
              style: TextStyle(color: message.contains('success') ? Colors.green : Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
