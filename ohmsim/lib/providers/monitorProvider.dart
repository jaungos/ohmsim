import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/adminMonitor.dart';
import '../api/firebase_adminMonitor_api.dart';

class MonitorProvider with ChangeNotifier {
  late FirebaseAdminMonitorAPI firebaseService;
  late Stream<QuerySnapshot> _monitorStream;

  MonitorProvider() {
    firebaseService = FirebaseAdminMonitorAPI();
    fetchAdminMonitors();
  }

  Stream<QuerySnapshot> get monitorStream => _monitorStream;

  fetchAdminMonitors() {
    _monitorStream = firebaseService.getAdminMonitors();
    notifyListeners();
  }

  void searchStudentLogs(String searchText) async {

  }

  void viewEnteredStudentsLogs() {
  }


  void updateLogs(String location, String studentNo, String status) {
  }
}
