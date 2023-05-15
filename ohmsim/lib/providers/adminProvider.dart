// Define a provider class
import 'package:flutter/material.dart';
import 'package:ohmsim/models/samplemodel.dart';

class AdminProvider with ChangeNotifier {
  List entitiesToElevate = [];
  List listOfAllStudents = [];
  List listOfQuarantinedStudents = [];
  List listOfMonitoredStudents = [];
  String studentToQuarantine = "";
  String userMode = "";

  // String _type = "";
  // String _signupType = "";

  // String get id => _id;
  // String get signupType => _signupType;

  // List<List<String>> data = [
  //   ["Juan Makasalanan", "123456", "User"]
  // ];

  Future<Map> viewAllUsers(username, password) {
    // for (int i = 0; i < data.length; i++) {
    //   if (data[i][0] == username && data[i][1] == password) {
    //     _id = i.toString();
    //     _type = data[i][2];
    //     return Future.value({"isLoggedIn": true, "message": "Logged in!"});
    //   }
    // }

    // return Future.value(
    //     {"isLoggedIn": false, "message": "User does not exist"});
    return Future.value({});
  }
}
