import 'dart:convert';

class Entry {
  String? id;
  late List<String> symptoms;
  late bool closeContact;
  bool approvedByAdmin = false;
  String email;
  DateTime date;

  Entry({
    this.id,
    required this.symptoms,
    required this.closeContact,
    required this.email,
    required this.date,
  });

  factory Entry.fromJson(Map<String, dynamic> json) {
    return Entry(
      id: json['id'],
      symptoms: List<String>.from(json['symptoms'] ?? []),
      closeContact: json['closeContact'],
      email: json['email'],
      date: json['date'],
    );
  }
  static List<Entry> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Entry>((dynamic d) => Entry.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "symptoms": symptoms,
      "closeContact": closeContact,
      "email": email,
      "date": date,
    };
  }
}
