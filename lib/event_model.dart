class Event {
  final DateTime date;
  final String event;
  final String day;

  Event({required this.date, required this.event, required this.day});

  factory Event.fromJson(Map<String, dynamic> json) {
    final dateParts = json['date'].split('-');
    final date = DateTime(
      int.parse(dateParts[2]), // year
      int.parse(dateParts[1]), // month
      int.parse(dateParts[0]), // day
    );
    return Event(
      date: date,
      event: json['event'],
      day: json['day'],
    );
  }
}
