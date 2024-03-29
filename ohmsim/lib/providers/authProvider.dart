// Define a provider class
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ohmsim/api/firebase_adminMonitor_api.dart';
import 'package:ohmsim/api/firebase_studentuser_api.dart';
import 'package:ohmsim/models/adminMonitor.dart';
import 'package:ohmsim/models/studentUserModel.dart';
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

  String _privilege = "Student";
  String get privilege => _privilege;

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
        signUpData.status,
      );

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
        signUpData.privilege,
        signUpData.preexistingIllnesses,
        signUpData.entries,
        signUpData.hasDailyEntry,
        signUpData.status,
      );

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
      return false;
    }
  }

  Future<String?> searchPrivilegeByEmail(String email) async {
    try {
      var currentUser1 = await studentAuthService.searchStudentByEmail(email);
      if (currentUser1 != null) {
        notifyListeners();

        return currentUser1.privilege;
      }

      var currentUser2 =
          await adminMonitorAuthService.searchAdminMonitorByEmail(email);
      if (currentUser2 != null) {
        notifyListeners();
        print("d3 ${currentUser2.privilege}");
        return currentUser2.privilege;
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

  Future<void> signOut() async {
    print(currentUser);
    await authService.signOut();
    print(currentUser);
    notifyListeners();
  }
}
