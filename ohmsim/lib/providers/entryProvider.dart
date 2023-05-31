import 'package:flutter/material.dart';
import '../models/entryModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../api/firebase_entry_api.dart';

class EntryProvider with ChangeNotifier {
  late FirebaseEntryAPI firebaseService;
  late Stream<QuerySnapshot> _entryStream;

  EntryProvider() {
    firebaseService = FirebaseEntryAPI();
    fetchEntries();
  }

  Stream<QuerySnapshot> get entries => _entryStream;

  fetchEntries() {
    _entryStream = firebaseService.getAllEntries();
    notifyListeners();
  }

  Future<void> addEntry(Entry entry) async {
    String message = await firebaseService.addEntry(entry.toJson());
    print(message);

    notifyListeners();
  }

  Future<void> toggleStatus(String id, bool closeContact) async {
    String message = await firebaseService.toggleStatus(id, closeContact);
    notifyListeners();
  }
}
