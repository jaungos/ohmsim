import 'dart:convert';

class adminMonitor {
  String? id;
  String name;

  String employeeNo;
  String position;
  String homeUnit;

  String? status;
  String privilege;

  String currentLocation = "";
  List<String> preexistingIllnesses = [];

  adminMonitor(
      {this.id,
      required this.name,
      required this.employeeNo,
      required this.position,
      required this.homeUnit,
      this.status,
      required this.privilege,
      currentLocation,
      preexistingIllnesses});

  factory adminMonitor.fromJson(Map<String, dynamic> json) {
    return adminMonitor(
      id: json['id'],
      name: json['name'],
      employeeNo: json['employeeNo'],
      position: json['position'],
      homeUnit: json['homeUnit'],
      status: json['status'],
      privilege: json['privilege'],
      currentLocation: json['currentLocation'],
      preexistingIllnesses: json['preexistingIllnesses'],
    );
  }

  static List<adminMonitor> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data
        .map<adminMonitor>((dynamic d) => adminMonitor.fromJson(d))
        .toList();
  }

  Map<String, dynamic> toJson(adminMonitor adminMonitor) {
    return {
      'id': adminMonitor.id,
      'name': adminMonitor.name,
      'employeeNo': adminMonitor.employeeNo,
      'position': adminMonitor.position,
      'homeUnit': adminMonitor.homeUnit,
      'status': adminMonitor.status,
      'privilege': adminMonitor.privilege,
      'currentLocation': adminMonitor.currentLocation,
      'preexistingIllnesses': adminMonitor.preexistingIllnesses,
    };
  }
}
