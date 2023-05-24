// Define a provider class
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String _id = "";
  String _privilege = "";
  String _view = "";

  String _status = "";

  String _name = "";

  String get id => _id;

  String get privilege => _privilege;
  String get view => _view;
  String get status => _status;
  String get name => _name;

  List<List<String>> data = [
    ["Juan Makasalanan", "123456", "juanmakasalanan@up.edu.ph", "Admin"]
  ];

  Future<Map> authenticateUser(email, password) {
    for (int i = 0; i < data.length; i++) {
      if (data[i][2] == email && data[i][1] == password) {
        _name = data[i][0];
        _privilege = data[i][3];
        return Future.value(
            {"isLoggedIn": true, "message": "Logged In!", data: data});
      }
    }
    return Future.value(
        {"isLoggedIn": false, "message": "User does not exist", data: []});
  }
}
