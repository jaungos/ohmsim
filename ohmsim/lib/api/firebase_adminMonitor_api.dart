import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ohmsim/models/adminMonitor.dart';

class FirebaseAdminMonitorAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  // @TODO: search student using email
  Future<AdminMonitor?> searchStudentByEmail(String? email) async {
    Map<String, dynamic> adminMonitorResult = {};
    try {
      final adminMonitorSearch = await db
          .collection('adminMonitor')
          .where('email', isEqualTo: email)
          .get();
      if (adminMonitorSearch.docs.isNotEmpty) {
        adminMonitorResult = adminMonitorSearch.docs[0].data();

        return AdminMonitor(
          email: adminMonitorResult['email'],
          password: adminMonitorResult['password'],
          fname: adminMonitorResult['fname'],
          mname: adminMonitorResult['mname'],
          lname: adminMonitorResult['lname'],
          employeeNo: adminMonitorResult['employeeNo'],
          position: adminMonitorResult['position'],
          homeUnit: adminMonitorResult['homeUnit'],
          privilege: adminMonitorResult['privilege'],
        );
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> elevateUser(Map<String, dynamic> user) async {
    try {
      await db.collection("adminMonitor").add(user);

      return "Successfully added admin/monitor user!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

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
