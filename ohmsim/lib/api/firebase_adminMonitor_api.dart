import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ohmsim/models/adminMonitor.dart';
import 'package:ohmsim/models/studentUserModel.dart';

class FirebaseAdminMonitorAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<AdminMonitor?> searchAdminMonitorByEmail(String? email) async {
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

  Future<String> elevateUser(
    StudentUser user,
    String newPrivilege,
  ) async {
    try {
      // Map<String, dynamic> updatedUser = {
      //   "email": user.email,
      //   "password": user.password,
      //   "fname": user.fname,
      //   "mname": user.mname,
      //   "lname": user.lname,
      //   "username": user.username,
      //   "studentNo": user.studentNo,
      //   "college": user.college,
      //   "course": user.course,
      //   "privilege": newPrivilege,
      //   "preexistingIllnesses": user.preexistingIllnesses,
      //   "hasDailyEntry": user.hasDailyEntry,
      // };

      // await db.collection("adminMonitor").add(updatedUser);
      await db.collection("studentUsers").doc(user.id).update({
        "privilege": newPrivilege,
      });

      return "Successfully added admin/monitor user!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}'";
    }
  }

  Future<String> elevateAdminMonitor(
    String userId,
  ) async {
    try {
      await db.collection("adminMonitor").doc(userId).update({
        "privilege": "Admin",
      });

      return "Successfully added admin/monitor user!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}'";
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

  Stream<QuerySnapshot> searchStudentLogs(String searchText) {
    return db
        .collection('studentUsers')
        .where('entries', arrayContains: searchText)
        .snapshots();
  }

  Stream<QuerySnapshot> getEnteredStudentLogs() {
    return db
        .collection('studentUsers')
        .where('entered', isEqualTo: true)
        .snapshots();
  }

  Future<String> updateLogs(String location, String studentNo, String status) async {
    try {
      final snapshot = await db
          .collection('studentUsers')
          .where('studentNo', isEqualTo: studentNo)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final studentId = snapshot.docs[0].id;
        await db
            .collection('studentUsers')
            .doc(studentId)
            .update({'location': location, 'status': status});

        return 'Logs updated successfully!';
      } else {
        return 'No student found with the provided student number.';
      }
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}'";
    }
  }
}
