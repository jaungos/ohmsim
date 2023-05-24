import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseStudentUserAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> addStudentUser(Map<String, dynamic> user) async {
    try {
      await db.collection("studentUsers").add(user);

      return "Successfully added student user!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }


  Stream<QuerySnapshot> getAllStudentUsers(){
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
}