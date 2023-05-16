// Define a provider class
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ohmsim/models/samplemodel.dart';

class AuthProvider with ChangeNotifier {
  String _id = "";
  String _type = "";
  String _signupType = "";
  String _view = "";

  String _status = "";

  String _name = "";

  String get id => _id;
  String get signupType => _signupType;
  String get view => _view;
  String get status => _status;
  String get name => _name;

  List<List<String>> data = [
    ["Juan Makasalanan", "123456", "juanmakasalanan@up.edu.ph", "User"]
  ];

  Future<Map> authenticateUser(email, password) {
    return Future.value(
        {"isLoggedIn": false, "message": "User does not exist", data: []});
  }
}
