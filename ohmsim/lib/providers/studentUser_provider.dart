import 'package:flutter/material.dart';
import '../models/studentUserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../api/firebase_studentuser_api.dart';

class StudentUserProvider with ChangeNotifier {
  late FirebaseStudentUserAPI firebaseService;
  late Stream<QuerySnapshot> _studentUserStream;

  StudentUserProvider() {
    firebaseService = FirebaseStudentUserAPI();
    fetchStudentUsers();
  }

  Stream<QuerySnapshot> get users => _studentUserStream;

  fetchStudentUsers() {
    _studentUserStream = firebaseService.getAllStudentUsers();
    notifyListeners();
  }

  void addStudentUser(StudentUser user) async {
    String message = await firebaseService.addStudentUser(user.toJson());
    print(message);

    notifyListeners();
  }

  void deleteStudentUser(String? id) async {
    String message = await firebaseService.deleteStudentUser(id);
    print(message);

    notifyListeners();
  }

  void editTodayEntry(StudentUser user) async {
    String message = await firebaseService.editTodayEntry(user.toJson());
    print(message);

    notifyListeners();
  }

  void deleteTodayEntry(String? id) async {
    String message = await firebaseService.deleteTodayEntry(id);
    print(message);

    notifyListeners();
  }
}
