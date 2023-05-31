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
}
