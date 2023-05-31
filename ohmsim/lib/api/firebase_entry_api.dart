import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseEntryAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> addEntry(Map<String, dynamic> entry) async {
    try {
      await db.collection("entries").add(entry);
      return "Successfully added entry!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Stream<QuerySnapshot> getAllEntries() {
    return db.collection("entries").snapshots();
  }

  Future<String> toggleStatus(String? id, bool closeContact) async {
    try {
      await db
          .collection("entries")
          .doc(id)
          .update({"closeContact": closeContact});

      return "Successfully edited entry!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> updateSymptoms(String? id, List<String> symptoms) async {
    try {
      await db.collection("entries").doc(id).update({"symptoms": symptoms});

      return "Successfully updated entry!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }
}
