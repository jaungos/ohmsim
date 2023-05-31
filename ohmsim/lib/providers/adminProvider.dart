import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../api/firebase_adminMonitor_api.dart';
import '../models/adminMonitor.dart';

class AdminProvider with ChangeNotifier {
  late FirebaseAdminMonitorAPI firebaseService;
  late Stream<QuerySnapshot> _adminStream;

  String _screen = "home";
  String get screen => _screen;

  AdminProvider() {
    firebaseService = FirebaseAdminMonitorAPI();
    fetchAdminMonitors();
  }

  Stream<QuerySnapshot> get adminMonitors => _adminStream;

  fetchAdminMonitors() {
    _adminStream = firebaseService.getAdminMonitors();
    notifyListeners();
  }

//  HARDCODEEEEEEEEEEEEEEEEEEEEEEEEEEED
  List<List<String>> _listOfAllUsers = [];
  List _listOfQuarantinedUsers = [];
  List _listOfMonitoredUsers = [];
  String _userToQuarantine = "";
  String _userToMonitor = "";
  String _userToElevate = "";
  String _userToClear = "";

  List<List<String>> sampleUsers = [
    ["Julian Makasalanan", "jumakasalanan@up.edu.ph", "Healthy"],
    ["Alexis Corbi", "acorbi@up.edu.ph", "Monitored"],
    ["Sunshine Dizon", "sdizon@up.edu.ph", "Quarantined"]
  ];

  List<List<String>> get listOfAllUsers => _listOfAllUsers;
  Future<Map> viewAllUsers() async {
    await cleanValues();
    _listOfAllUsers = sampleUsers;
    return Future.value({});
  }

  Future cleanValues() async {
    _listOfAllUsers = [];
    _listOfQuarantinedUsers = [];
    _listOfMonitoredUsers = [];
    _userToQuarantine = "";
    _userToMonitor = "";
    _userToElevate = "";
    return Future.value();
  }

  Future<Map> viewSpecificUsers() async {
    await cleanValues();
    _listOfAllUsers = sampleUsers;
    return Future.value({});
  }

//  HARDCODEEEEEEEEEEEEEEEEEEEEEEEEEEED
  void elevateUser(AdminMonitor user) async {
    String message = await firebaseService.elevateUser(user.toJson());
    print(message);

    notifyListeners();
  }

  void approveDeleteRequest(String studentId) async {
    String message = await firebaseService.approveDeleteRequest(studentId);
    print(message);

    notifyListeners();
  }

  void rejectDeleteRequest(String studentId) async {
    String message = await firebaseService.rejectDeleteRequest(studentId);
    print(message);

    notifyListeners();
  }

  Future<void> changeScreen(String newScreen) async {
    _screen = newScreen;
    notifyListeners();
    return Future.value();
  }
}

class MonitorProvider with ChangeNotifier {
  late FirebaseAdminMonitorAPI firebaseService;

  MonitorProvider() {
    firebaseService = FirebaseAdminMonitorAPI();
  }

  void searchStudentLogs() async {
    // TODO: Implement the search student logs functionality here
  }

  void viewLogsOfStudentsEntered() async {
    // TODO: Implement the view logs of students entered functionality here
  }

  void readGeneratedQR() async {
    // TODO: Implement the read generated QR functionality here
  }

  void updateLogs(Map<String, dynamic> logData) async {
    // TODO: Implement the update logs functionality here
  }

  Future<String> elevateUser(Map<String, dynamic> user) async {
    try {
      await firebaseService.elevateUser(user);

      return "Successfully elevated user to admin/monitor!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }
}
