import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseStudentUserAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  // @TODO: Ok lang ba na irevise 'to ito nalang icall sa authProvider??
  Future<String> addStudentUser(Map<String, dynamic> user) async {
    try {
      await db.collection("studentUsers").add(user);

      return "Successfully added student user!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }
  // ====================================================================

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
