class AdminMonitor {
  String? id;
  String fname;
  String mname;
  String lname;

  String employeeNo;
  String position;
  String homeUnit;
  String? status;
  String privilege;
  String currentLocation = "";
  String assignedLocation = "";
  String email;
  String password;
  List<String> preexistingIllnesses = [];

  AdminMonitor({
    this.id,
    required this.email,
    required this.password,
    required this.fname,
    required this.mname,
    required this.lname,
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
      fname: json['fname'],
      mname: json['mname'],
      lname: json['lname'],
      email: json['email'],
      password: json['password'],
      employeeNo: json['employeeNo'],
      position: json['position'],
      homeUnit: json['homeUnit'],
      status: json['status'],
      privilege: json['privilege'],
      currentLocation: json['currentLocation'],
      assignedLocation: json['assignedLocation'],
      preexistingIllnesses:
          List<String>.from(json['preexistingIllnesses'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      "fname": fname,
      "mname": mname,
      "lname": lname,
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
