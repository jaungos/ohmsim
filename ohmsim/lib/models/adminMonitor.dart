class AdminMonitor {
  String? id;
  String name;
  String employeeNo;
  String position;
  String homeUnit;
  String? status;
  String privilege;
  String currentLocation = "";
  String assignedLocation = "";
  List<String> preexistingIllnesses = [];

  AdminMonitor({
    this.id,
    required this.name,
    required this.employeeNo,
    required this.position,
    required this.homeUnit,
    this.status,
    required this.privilege,
    this.currentLocation = "",
    this.assignedLocation = "",
    this.preexistingIllnesses = const [],
  });

  factory AdminMonitor.fromJson(Map<String, dynamic> json) {
    return AdminMonitor(
      id: json['id'],
      name: json['name'],
      employeeNo: json['employeeNo'],
      position: json['position'],
      homeUnit: json['homeUnit'],
      status: json['status'],
      privilege: json['privilege'],
      currentLocation: json['currentLocation'],
      assignedLocation: json['assignedLocation'],
      preexistingIllnesses: List<String>.from(json['preexistingIllnesses'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'employeeNo': employeeNo,
      'position': position,
      'homeUnit': homeUnit,
      'status': status,
      'privilege': privilege,
      'currentLocation': currentLocation,
      'assignedLocation': assignedLocation,
      'preexistingIllnesses': preexistingIllnesses,
    };
  }
}
