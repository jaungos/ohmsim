// Define a provider class
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:ohmsim/api/firebase_adminMonitor_api.dart';
import 'package:ohmsim/api/firebase_studentuser_api.dart';
import 'package:ohmsim/main.dart';
import 'package:ohmsim/models/adminMonitor.dart';
import 'package:ohmsim/models/studentUserModel.dart';
import '../models/entryModel.dart';

import '../api/firebase_auth_api.dart';

class AuthProvider with ChangeNotifier {
  late FirebaseAuthAPI authService;
  late FirebaseStudentUserAPI studentAuthService;
  late FirebaseAdminMonitorAPI adminMonitorAuthService;
  late Stream<User?> uStream;
  User? userObj;

  AuthProvider() {
    authService = FirebaseAuthAPI();
    studentAuthService = FirebaseStudentUserAPI();
    adminMonitorAuthService = FirebaseAdminMonitorAPI();
    fetchAuthentication();
  }

  Stream<User?> get userStream => uStream;
  User? get currentUser => authService.currentUser;

  void fetchAuthentication() {
    uStream = authService.getUser();

    notifyListeners();
  }

  void fetchUserObj() {
    userObj = authService.currentUser;

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
      final credential = await authService.signUpAdminMonitor(
        signUpData.email,
        signUpData.password,
        signUpData.fname,
        signUpData.mname,
        signUpData.lname,
        signUpData.employeeNo,
        signUpData.position,
        signUpData.homeUnit,
        signUpData.privilege,
      );

      // ======================== @TODO: add this method in adminMonitor provider ========================
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
      final credential = await authService.signUpStudent(
        signUpData.email,
        signUpData.password,
        signUpData.fname,
        signUpData.mname,
        signUpData.lname,
        signUpData.username,
        signUpData.college,
        signUpData.course,
        signUpData.studentNo,
      );

      // ======================== @TODO: add this method in studentUser provider ========================
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

  Future<String?> searchPrivilegeByEmail(String? email) async {
    print('The email to search is $email');
    try {
      var currentUser = await studentAuthService.searchStudentByEmail(email);
      if (currentUser != null) {
        // print(currentUser.email);
        // print(currentUser.privilege);
        notifyListeners();
        return currentUser.privilege;
      }

      var currentUser1 =
          await adminMonitorAuthService.searchStudentByEmail(email);
      if (currentUser1 != null) {
        // print(currentUser1.email);
        // print(currentUser1.privilege);
        notifyListeners();
        return currentUser1.privilege;
      }
    } catch (e) {
      print(e);
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

  // @TODO: implement proper logging out to reset the currentUser
  Future<void> signOut() async {
    print(currentUser);
    await authService.signOut();
    print(currentUser);
    notifyListeners();
  }
}
