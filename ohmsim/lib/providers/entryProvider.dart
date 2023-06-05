import 'package:flutter/material.dart';
import '../models/entryModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../api/firebase_entry_api.dart';

class EntryProvider with ChangeNotifier {
  late FirebaseEntryAPI firebaseService;
  late Stream<QuerySnapshot> _entryStream;
  List<String> _symptoms = [];
  bool _hasContact = false;
  String _email = "";
  DateTime _date = DateTime.now();

  List<String> get symptoms => _symptoms;
  bool get hasContact => _hasContact;
  String get email => _email;
  DateTime get date => _date;


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

  Future<void> updateSymptoms(String id, List<String> symptoms) async {
    String message = await firebaseService.updateSymptoms(id, symptoms);
  }

  Future <void> cleanValues()
  {
    _symptoms = [];
    _hasContact = false;
    _email = "";
    _date = DateTime.now();

    notifyListeners();
    return Future.value();
  }
  Future <void> setEntry(List<String> symptom, bool contact, String emailAdd)
  {
    _symptoms = symptom;
    _hasContact = contact;
    _email = emailAdd;
    _date = DateTime.now();
    return Future.value();
  }
}
