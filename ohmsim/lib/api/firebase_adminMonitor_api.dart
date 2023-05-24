import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAdminMonitorAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> elevateUser(Map<String, dynamic> user) async {
    try {
      await db.collection("adminMonitor").add(user);

      return "Successfully added admin/monitor user!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Stream<QuerySnapshot> getAdminMonitors() {
    return db.collection("AdminMonitor").snapshots();
  }

  Future<String> deleteAdminMonitor(String? id) async {
    try {
      await db.collection("AdminMonitor").doc(id).delete();

      return "Successfully deleted admin/monitor!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }
}
