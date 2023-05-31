import 'dart:convert';

class Entry {
  String? id;
  late List<String> symptoms;
  late bool closeContact;
  bool approvedByAdmin = false;
  String email;

  Entry({
    this.id,
    required this.symptoms,
    required this.closeContact,
    required this.email,
  });

  factory Entry.fromJson(Map<String, dynamic> json) {
    return Entry(
        id: json['id'],
        symptoms: List<String>.from(json['symptoms'] ?? []),
        closeContact: json['closeContact'],
        email: json['email']);
  }
  static List<Entry> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Entry>((dynamic d) => Entry.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "symptoms": this.symptoms,
      "closeContact": this.closeContact,
      "email": this.email,
    };
  }
}
