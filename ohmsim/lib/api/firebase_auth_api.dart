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
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(credential);
    } on FirebaseAuthException catch (e) {
      // if (e.code == 'user-not-found') {
      //   print('No user found for that email.');
      // } else if (e.code == 'wrong-password') {
      //   print('Wrong password provided for that user.');
      // }
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
      String studentNo) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      await user?.updateDisplayName('$fname $mname $lname');

      print(credential);
    } on FirebaseAuthException catch (e) {
      // if (e.code == 'weak-password') {
      //   print('The password provided is too weak.');
      // } else if (e.code == 'email-already-in-use') {
      //   print('The account already exists for that email.');
      // }
      throw e.message!;
    }
    // } catch (e) {
    //   print(e);
    // }
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

      print(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
