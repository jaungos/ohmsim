/*

Reasons why I did this model:

id: unique identifier of a user object in the database
name: required since each of the user objects must have a name

The following are nullables for these reasons:

username, college, studentNo - for the basic user privilege

employee, position, homeUnit - for the admin and monitor privilege types

status - whether they are quarantined, under monitor, or healthy

privilege - whether they are a user, admin, or monitor, also used by Provider 

to determine which view should be seen by the end-user.

*/

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
  User.adminMonitor(this.id, this.name, this.employeeNo, this.position,
      this.homeUnit, this.status, this.privilege);
}
