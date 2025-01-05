class Event {
  final String title;
  final String description;
  final String date;
  final String location;

  Event({
    required this.title,
    required this.description,
    required this.date,
    required this.location,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json['title'],
      description: json['description'],
      date: json['event_date'],
      location: json['location'],
    );
  }
}
