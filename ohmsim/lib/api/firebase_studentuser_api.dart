import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ohmsim/models/studentUserModel.dart';

class FirebaseStudentUserAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  static final FirebaseAuth auth = FirebaseAuth.instance;

  Future<StudentUser?> searchStudentByEmail(String? email) async {
    Map<String, dynamic> studentResult = {};
    try {
      final student = await db
          .collection('studentUsers')
          .where('email', isEqualTo: email)
          .get();
      if (student.docs.isNotEmpty) {
        studentResult = student.docs[0].data();

        return StudentUser(
          email: studentResult['email'],
          password: studentResult['password'],
          fname: studentResult['fname'],
          mname: studentResult['mname'],
          lname: studentResult['lname'],
          username: studentResult['username'],
          studentNo: studentResult['studentNo'],
          college: studentResult['college'],
          course: studentResult['course'],
          privilege: studentResult['privilege'],
          preexistingIllnesses:
              List<String>.from(studentResult['preexistingIllnesses']),
          hasDailyEntry: studentResult['hasDailyEntry'],
        );
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> addStudentUser(Map<String, dynamic> user) async {
    try {
      await db.collection("studentUsers").add(user);

      return "Successfully added student user!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Stream<QuerySnapshot> getAllStudentUsers() {
    return db.collection("studentUsers").snapshots();
  }

  Future<String> deleteStudentUser(String? id) async {
    try {
      await db.collection("studentUsers").doc(id).delete();

      return "Successfully deleted student user!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> editTodayEntry(Map<String, dynamic> entryData) async {
    try {
      // Implement edit today's entry functionality here

      return "Successfully edited today's entry!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> deleteTodayEntry(String? id) async {
    try {
      // Implement delete today's entry functionality here

      return "Successfully deleted today's entry!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }
}
