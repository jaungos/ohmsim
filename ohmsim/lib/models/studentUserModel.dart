import 'dart:convert';
import 'entryModel.dart';

class StudentUser {
  String? id;
  String fname;
  String mname;
  String lname;

  String username;
  String college;
  String course;
  String studentNo;

  String? status;
  String privilege;
  String email;
  String password;
  bool hasDailyEntry;
  String? currentLocation = "";
  List<String> preexistingIllnesses = [];
  List<Map<String, dynamic>> entries = [];

  StudentUser({
    this.id,
    required this.email,
    required this.password,
    required this.fname,
    required this.mname,
    required this.lname,
    required this.username,
    required this.college,
    required this.course,
    required this.studentNo,
    required this.privilege,
    required this.preexistingIllnesses,
    required this.entries,
    this.status,
    this.currentLocation,
    required this.hasDailyEntry,
  });

  factory StudentUser.fromJson(Map<String, dynamic> json) {
    return StudentUser(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      fname: json['fname'],
      mname: json['mname'],
      lname: json['lname'],
      username: json['username'],
      college: json['college'],
      course: json['course'],
      studentNo: json['studentNo'],
      status: json['status'],
      privilege: json['privilege'],
      currentLocation: json['currentLocation'],
      preexistingIllnesses:
          List<String>.from(json['preexistingIllnesses'] ?? []),
      entries: List<Map<String, dynamic>>.from(json['entries'] ?? []),
      hasDailyEntry: json['hasDailyEntry'],
    );
  }

  static List<StudentUser> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data
        .map<StudentUser>((dynamic d) => StudentUser.fromJson(d))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "fname": fname,
      "mname": mname,
      "lname": lname,
      "username": username,
      "college": college,
      "course": course,
      "studentNo": studentNo,
      "status": status,
      "privilege": privilege,
      "currentLocation": currentLocation,
      "preexistingIllnesses": preexistingIllnesses,
      "entries": entries,
      "hasDailyEntry": hasDailyEntry,
    };
  }
}
