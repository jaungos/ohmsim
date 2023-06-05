import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ohmsim/api/firebase_studentuser_api.dart';
import 'package:ohmsim/models/adminMonitor.dart';
import 'package:ohmsim/models/studentUserModel.dart';
import '../api/firebase_adminMonitor_api.dart';

class AdminMonitorProvider with ChangeNotifier {
  late FirebaseAdminMonitorAPI firebaseService;
  late FirebaseStudentUserAPI studentUserAPI;
  late Stream<QuerySnapshot> _adminMonitorStream;

  AdminMonitorProvider() {
    firebaseService = FirebaseAdminMonitorAPI();
    studentUserAPI = FirebaseStudentUserAPI();
    fetchAdminMonitors();
  }

  Stream<QuerySnapshot> get adminMonitors => _adminMonitorStream;

  fetchAdminMonitors() {
    _adminMonitorStream = firebaseService.getAdminMonitors();
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

  Future<String> elevateUser(
    StudentUser user,
    String newPrivilege,
  ) async {
    try {
      await firebaseService.elevateUser(user, newPrivilege);
      notifyListeners();
      return newPrivilege == 'Admin'
          ? "Successfully elevated user to admin!"
          : "Successfully elevated user to monitor";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> elevateEntranceMonitor(
    String adminMonitorId,
  ) async {
    try {
      await firebaseService.elevateAdminMonitor(adminMonitorId);
      notifyListeners();
      return "Successfully elevated user to admin!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  void deleteStudentUser(String? id) async {
    String message = await studentUserAPI.deleteStudentUser(id);
    print(message);

    notifyListeners();
  }
}
