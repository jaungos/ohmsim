import 'package:flutter/material.dart';
import 'package:ohmsim/models/adminMonitor.dart';
import '../models/adminMonitor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../api/firebase_adminMonitor_api.dart';

class adminProvider with ChangeNotifier {
  late FirebaseAdminMonitorAPI firebaseService;
  late Stream<QuerySnapshot> _adminStream;

  studentUserProvider() {
    firebaseService = FirebaseAdminMonitorAPI();
    fetchAdminMonitors();
  }

  Stream<QuerySnapshot> get users => _adminStream;

  fetchAdminMonitors() {
    _adminStream = firebaseService.getAdminMonitors();
    notifyListeners();
  }

  void elevateUser(adminMonitor user) async {
    String message = await firebaseService.elevateUser(user.toJson(user));
    print(message);

    notifyListeners();
  }
}
