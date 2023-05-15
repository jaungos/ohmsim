class User {
  String id;
  String name;

  String? username;
  String? college;
  String? studentNo;

  String? employeeNo;
  String? position;
  String? homeUnit;

  String status;
  String privilege;

  String currentLocation = "";
  List<String> preexistingIllnesses = [];
  User.studentUser(this.id, this.name, this.username, this.college,
      this.studentNo, this.status, this.privilege);
  User.adminMonitor(this.id, this.name, this.status, this.privilege);
}
