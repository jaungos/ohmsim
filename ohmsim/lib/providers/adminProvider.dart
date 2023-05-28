// Define a provider class
import 'package:flutter/material.dart';
import 'package:ohmsim/models/samplemodel.dart';

class AdminProvider with ChangeNotifier {
  List _listOfAllUsers = [];
  List _listOfQuarantinedUsers = [];
  List _listOfMonitoredUsers = [];
  String _userToQuarantine = "";
  String _userToMonitor = "";
  String _userToElevate = "";
  String _userToClear = "";

  List get listOfAllUsers => _listOfAllUsers;
  List get listOfQuarantinedUsers => _listOfQuarantinedUsers;
  List get listOfMonitoredUsers => _listOfMonitoredUsers;
  String get userToMonitor => _userToMonitor;
  String get userToQuarantine => _userToQuarantine;
  String get userToElevate => _userToElevate;
  String get userToClear => _userToClear;

  List<List<String>> data = [
    ["Juan Makasalanan", "123456", "User"]
  ];

  Future<Map> viewAllUsers() async {
    await cleanValues();
    _listOfAllUsers = data;
    return Future.value({});
  }

  Future<Map> viewSpecificUsers() async {
    await cleanValues();
    _listOfAllUsers = data;
    return Future.value({});
  }

  Future<Map> viewQuarantinedUsers() async {
    await cleanValues();
    _listOfAllUsers = data;
    return Future.value({});
  }

  Future<Map> viewMonitoredUsers() async {
    await cleanValues();
    _listOfMonitoredUsers = data;
    return Future.value({});
  }

  Future<Map> quarantineUser(id) async {
    await cleanValues();
    _userToQuarantine = "0";
    return Future.value({});
  }

  Future<Map> monitorUser(id) async {
    await cleanValues();
    _userToMonitor = "0";
    return Future.value({});
  }

  Future<Map> moveStudentToQuarantine(id) async {
    await cleanValues();
    _userToMonitor = "0";
    return Future.value({});
  }

  Future<Map> moveStudentOutOfQuarantine(id) async {
    await cleanValues();
    _userToQuarantine = "0";
    return Future.value({});
  }

  Future<Map> moveStudentOutOfMonitoring(id) async {
    await cleanValues();
    _userToMonitor = "0";
    return Future.value({});
  }

  Future<Map> elevateUser(id) async {
    await cleanValues();
    _userToElevate = "0";
    return Future.value({});
  }

  Future cleanValues() async {
    _listOfAllUsers = [];
    _listOfQuarantinedUsers = [];
    _listOfMonitoredUsers = [];
    _userToQuarantine = "";
    _userToMonitor = "";
    _userToElevate = "";
    return Future.value();
  }
}
