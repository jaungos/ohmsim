import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ohmsim/models/studentUserModel.dart';
import 'package:ohmsim/models/entryModel.dart';
import 'package:ohmsim/providers/authProvider.dart';
import 'package:ohmsim/providers/studentUser_provider.dart';

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
        String docId = student.docs[0].id;
        return StudentUser(
          id: docId,
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
          entries: List<Map<String, dynamic>>.from(studentResult['entries']),
          hasDailyEntry: studentResult['hasDailyEntry'],
          status: studentResult['status'],
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

  Future<String> toggleStatus(String? id, bool hasDailyEntry) async {
    try {
      await db
          .collection("studentUsers")
          .doc(id)
          .update({"hasDailyEntry": hasDailyEntry});

      return "Successfully edited student user!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> addEntry(String? id, Map<String, dynamic> entry) async {
    try {
      DocumentSnapshot doc = await db.collection("studentUsers").doc(id).get();

      if (doc.exists) {
        Map<String, dynamic>? user = doc.data() as Map<String, dynamic>;
        if (user.containsKey('entries')) {
          List<dynamic> entries = List.from(user['entries'] as List<dynamic>);

          entries.add(entry);

          await db
              .collection("studentUsers")
              .doc(id)
              .update({"entries": entries});
        } else {
          return "Entries doesn't exist for this document";
        }
        return "Successfully updated student user!";
      } else {
        return "User doesn't exist!";
      }
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
