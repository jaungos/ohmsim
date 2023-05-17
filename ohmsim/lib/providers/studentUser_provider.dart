import 'package:flutter/material.dart';
import '../models/studentUserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../api/firebase_studentuser_api.dart';
class studentUserProvider with ChangeNotifier{
  late FirebaseStudentUserAPI firebaseService;
  late Stream<QuerySnapshot> _studentUserStream;

  studentUserProvider(){
    firebaseService = FirebaseStudentUserAPI();
    fetchStudentUsers();
  }
  Stream<QuerySnapshot> get users => _studentUserStream;

  fetchStudentUsers(){
    _studentUserStream = firebaseService.getAllStudentUsers();
    notifyListeners();
  }
  void addStudentUser(studentUser user) async {
    String message = await firebaseService.addStudentUser(user.toJson(user));
    print(message);

    notifyListeners();
  }
}