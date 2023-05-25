import 'dart:convert';

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
  String? privilege;
  String email;
  String password;
  String? currentLocation = "";
  List<String>? preexistingIllnesses = [];

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
    this.status,
    this.privilege,
    this.currentLocation,
    this.preexistingIllnesses,
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
      preexistingIllnesses: List<String>.from(json['preexistingIllnesses'] ?? []),
    );
  }

  static List<StudentUser> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<StudentUser>((dynamic d) => StudentUser.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "email": this.email,
      "password": this.password,
      "fname": this.fname,
      "mname": this.mname,
      "lname": this.lname,
      "username": this.username,
      "college": this.college,
      "course": this.course,
      "studentNo": this.studentNo,
      "status": this.status,
      "privilege": this.privilege,
      "currentLocation": this.currentLocation,
      "preexistingIllnesses": this.preexistingIllnesses,
    };
  }
}
