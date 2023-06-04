import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ohmsim/models/adminMonitor.dart';

class FirebaseAuthAPI {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<User?> getUser() {
    return auth.authStateChanges();
  }

  User? get currentUser => auth.currentUser;

  Future<void> signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    }
  }

  Future<void> signUpStudent(
    String email,
    String password,
    String fname,
    String mname,
    String lname,
    String username,
    String college,
    String course,
    String studentNo,
    String privilege,
    List<String> preexistingIllnesses,
  ) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      await user?.updateDisplayName('$fname $mname $lname');

      await FirebaseFirestore.instance.collection('studentUsers').add({
        'email': email,
        'password': password,
        'fname': fname,
        'mname': mname,
        'lname': lname,
        'username': username,
        'college': college,
        'course': course,
        'studentNo': studentNo,
        'privilege': privilege,
        'preexistingIllnesses': preexistingIllnesses,
      });
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    } catch (e) {
      print(e);
    }
  }

  Future<void> signUpAdminMonitor(
    String email,
    String password,
    String fname,
    String mname,
    String lname,
    String employeeNo,
    String position,
    String homeUnit,
    String privilege,
  ) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      await user?.updateDisplayName('$fname $mname $lname');

      await FirebaseFirestore.instance.collection('adminMonitor').add({
        'email': email,
        'fname': fname,
        'mname': mname,
        'lname': lname,
        'password': password,
        'employeeNo': employeeNo,
        'position': position,
        'homeUnit': homeUnit,
        'privilege': privilege,
      });
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
