class Announcement {
  final String title;
  final String message;

  Announcement({required this.title, required this.message});

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      title: json['title'],
      message: json['message'],
    );
  }
}
