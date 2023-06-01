import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAdminMonitorAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  // @TODO: Ok lang ba na irevise 'to ito nalang icall sa authProvider??
  Future<String> elevateUser(Map<String, dynamic> user) async {
    try {
      await db.collection("adminMonitor").add(user);

      return "Successfully added admin/monitor user!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }
  // ====================================================================

  Stream<QuerySnapshot> getAdminMonitors() {
    return db.collection("adminMonitor").snapshots();
  }

  Future<String> deleteAdminMonitor(String? id) async {
    try {
      await db.collection("adminMonitor").doc(id).delete();

      return "Successfully deleted admin/monitor!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> addStudentToQuarantine(String studentId) async {
    try {
      await db
          .collection("studentUsers")
          .doc(studentId)
          .update({"status": "Under Quarantine"});

      return "Student added to quarantine successfully!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> removeStudentFromQuarantine(String studentId) async {
    try {
      await db
          .collection("studentUsers")
          .doc(studentId)
          .update({"status": "Cleared"});

      return "Student removed from quarantine successfully!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> moveToQuarantine(String studentId) async {
    try {
      await db
          .collection("studentUsers")
          .doc(studentId)
          .update({"status": "Under Quarantine"});

      return "Student moved to quarantine successfully!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> endMonitoring(String studentId) async {
    try {
      await db
          .collection("studentUsers")
          .doc(studentId)
          .update({"status": "Cleared"});

      return "Monitoring ended for the student successfully!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> approveDeleteRequest(String studentId) async {
    try {
      await db.collection("studentUsers").doc(studentId).delete();

      return "Delete request for the student approved and student deleted successfully!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> rejectDeleteRequest(String studentId) async {
    try {
      await db
          .collection("studentUsers")
          .doc(studentId)
          .update({"deleteRequest": false});

      return "Delete request for the student rejected successfully!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }
}
