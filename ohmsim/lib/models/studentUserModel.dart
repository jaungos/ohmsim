/*

Reasons why I did this model:

id: unique identifier of a user object in the database
name: required since each of the user objects must have a name

The following are nullables for these reasons:

username, college, studentNo - for the basic user privilege


status - whether they are quarantined, under monitor, or healthy

privilege - whether they are a user, admin, or monitor, also used by Provider 

to determine which view should be seen by the end-user.

*/

import 'dart:convert';

class studentUser {
  // String id;
  String email;
  String fname;
  String mname;
  String lname;
  String course;
  String username;
  String college;
  String studentNo;

  String status;
  String privilege;

  String currentLocation = "";
  List<String> preexistingIllnesses = [];
  studentUser(
      {required this.email,
      // required this.id,
      required this.fname,
      required this.mname,
      required this.lname,
      required this.username,
      required this.college,
      required this.course,
      required this.studentNo,
      required this.status,
      required this.privilege});

  factory studentUser.fromJson(Map<String, dynamic> json) {
    return studentUser(
      // id: json['id'],
      email: json['email'],
      fname: json['fname'],
      mname: json['mname'],
      lname: json['lname'],
      username: json['username'],
      college: json['college'],
      course: json['course'],
      studentNo: json['studentNo'],
      status: json['status'],
      privilege: json['privilege'],
    );
  }

  static List<studentUser> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data
        .map<studentUser>((dynamic d) => studentUser.fromJson(d))
        .toList();
  }

  Map<String, dynamic> toJson(studentUser user) {
    return {
      // "id": this.id,
      "email": this.email,
      "fname": this.fname,
      "mname": this.mname,
      "lname": this.lname,
      "username": this.username,
      "college": this.college,
      "course": this.course,
      "studentNo": this.studentNo,
      "status": this.status,
      "privilege": this.privilege,
    };
  }
}
