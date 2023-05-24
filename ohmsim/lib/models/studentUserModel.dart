import 'dart:convert';

class StudentUser {
  String id;
  String fname;
  String mname;
  String lname;

  String username;
  String college;
  String studentNo;

  String status;
  String privilege;

  String currentLocation = "";
  List<String> preexistingIllnesses = [];

  StudentUser({
    required this.id,
    required this.fname,
    required this.mname,
    required this.lname,
    required this.username,
    required this.college,
    required this.studentNo,
    required this.status,
    required this.privilege,
    required this.currentLocation,
    required this.preexistingIllnesses,
  });

  factory StudentUser.fromJson(Map<String, dynamic> json) {
    return StudentUser(
      id: json['id'],
      fname: json['fname'],
      mname: json['mname'],
      lname: json['lname'],
      username: json['username'],
      college: json['college'],
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
      "fname": this.fname,
      "mname": this.mname,
      "lname": this.lname,
      "username": this.username,
      "college": this.college,
      "studentNo": this.studentNo,
      "status": this.status,
      "privilege": this.privilege,
      "currentLocation": this.currentLocation,
      "preexistingIllnesses": this.preexistingIllnesses,
    };
  }
}
