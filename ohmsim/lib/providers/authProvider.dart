// Define a provider class
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:ohmsim/main.dart';
import 'package:ohmsim/models/adminMonitor.dart';
import 'package:ohmsim/models/studentUserModel.dart';
import '../models/entryModel.dart';

import '../api/firebase_auth_api.dart';

class AuthProvider with ChangeNotifier {
  late FirebaseAuthAPI authService;
  late Stream<User?> uStream;
  User? userObj;

  AuthProvider() {
    authService = FirebaseAuthAPI();
    fetchAuthentication();
  }

  Stream<User?> get userStream => uStream;
  User? get currentUser => authService.currentUser;

  void fetchAuthentication() {
    uStream = authService.getUser();

    notifyListeners();
  }

  String _id = "";
  String _privilege = "Student";
  String _view = "";
  String _status = "";
  String _name = "";
  String _email = "";

  String get id => _id;
  String get privilege => _privilege;
  String get view => _view;
  String get status => _status;
  String get name => _name;
  String get email => _email;

  Future<bool> signUpAdminMonitor(AdminMonitor signUpData) async {
    try {
      // final credential = await authService.signUpAdminMonitor(
      //   signUpData.email,
      //   signUpData.password,
      //   signUpData.fname,
      //   signUpData.mname,
      //   signUpData.lname,
      //   signUpData.username,
      //   signUpData.employeeNo,
      //   signUpData.position,
      //   signUpData.homeUnit,
      //   signUpData.privilege,
      // );

      // Store additional user data in Firestore
      await FirebaseFirestore.instance.collection('adminMonitor').add({
        'email': signUpData.email,
        'fname': signUpData.fname,
        'mname': signUpData.mname,
        'lname': signUpData.lname,
        'password': signUpData.password,
        'employeeNo': signUpData.employeeNo,
        'position': signUpData.position,
        'homeUnit': signUpData.homeUnit,
        'privilege': signUpData.privilege,
      });

      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      // Handle any errors
      print(e);
      return false;
    }
  }

  Future<bool> signUpStudent(StudentUser signUpData) async {
    try {
      // final credential = await authService.signUpStudent(
      //   signUpData.email,
      //   signUpData.password,
      //   signUpData.fname,
      //   signUpData.mname,
      //   signUpData.lname,
      //   signUpData.username,
      //   signUpData.college,
      //   signUpData.course,
      //   signUpData.studentNo,
      // );

      // Store additional user data in Firestore
      await FirebaseFirestore.instance.collection('studentUsers').add({
        'email': signUpData.email,
        'password': signUpData.password,
        'fname': signUpData.fname,
        'mname': signUpData.mname,
        'lname': signUpData.lname,
        'username': signUpData.username,
        'college': signUpData.college,
        'course': signUpData.course,
        'studentNo': signUpData.studentNo,
        'privilege': signUpData.privilege,
      });

      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      // Handle any errors
      // print(e);
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      await authService.signIn(email, password);
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      // if (e.code == 'user-not-found') {
      //   print('No user found for that email.');
      // } else if (e.code == 'wrong-password') {
      //   print('Wrong password provided for that user.');
      // }
      return false;
    }
  }

  Future<void> switchSignUpPrivilege(String newPrivilege) {
    _privilege = newPrivilege;
    notifyListeners();

    return Future.value();
  }

  Future<void> getCredentials() {
    _name = "Juan Makasalanan";
    _privilege = "Admin";

    return Future.value();
  }

  Future<void> signOut() {
    _id = "";
    _privilege = "Student";
    _view = "";

    _status = "";

    _name = "";
    _email = "";

    notifyListeners();

    return authService.signOut();
  }
}
