import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ohmsim/models/studentUserModel.dart';
import 'package:ohmsim/providers/studentUser_provider.dart';
import 'package:provider/provider.dart';
import 'package:ohmsim/providers/authProvider.dart';

class ProfilePage extends StatefulWidget {
  // static String routeName = '/home';
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  StudentUser? studentUser;

  @override
  void initState() {
    super.initState();
    fetchAdminMonitorUser();
  }

  Future<void> fetchAdminMonitorUser() async {
    User? currentUser = context.read<AuthProvider>().currentUser;
    String email = currentUser!.email!;
    StudentUser user =
        await context.read<StudentUserProvider>().getStudentUser(email);
    setState(() {
      studentUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (studentUser == null) {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return SingleChildScrollView(
        child: Column(
          children: [
            profileInfo(),
            logoutButton(),
          ],
        ),
      );
    }
  }

  // Widget for the profile info
  Widget profileInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
      child: Center(
        child: Column(
          children: [
            // Logo of the app
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(75),
                child: Image.asset(
                  'assets/Logo4B.png',
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Name of the user
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Text(
                '${studentUser!.fname} ${studentUser!.mname} ${studentUser!.lname}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF191313),
                ),
                textAlign: TextAlign.left,
              ),
            ),
            // Status of the user
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: studentUser!.status == 'Cleared'
                      ? const Color(0xFFb8c9ba)
                      : studentUser!.status == 'Under Monitoring'
                          ? const Color(0xFFffbeab)
                          : studentUser!.status == 'Under Quarantine'
                              ? const Color(0xFFffaaaa)
                              : const Color(0xFF333333),
                ),
                child: IntrinsicWidth(
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Icon(
                                  Icons.circle,
                                  color: studentUser!.status == 'Cleared'
                                      ? const Color(0xFF21523c)
                                      : studentUser!.status ==
                                              'Under Monitoring'
                                          ? const Color(0xFFf65151)
                                          : studentUser!.status ==
                                                  'Under Quarantine'
                                              ? const Color(0xFFff0000)
                                              : const Color(0xFFf9fefa),
                                  size: 15,
                                ),
                              ),
                              Text(
                                studentUser!.status,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: studentUser!.status == 'Cleared'
                                      ? const Color(0xFF21523c)
                                      : studentUser!.status ==
                                              'Under Monitoring'
                                          ? const Color(0xFFf65151)
                                          : studentUser!.status ==
                                                  'Under Quarantine'
                                              ? const Color(0xFFff0000)
                                              : const Color(0xFFf9fefa),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // @TODO: Conditional QR Code Rendering
            if (studentUser!.status == 'Cleared' ||
                studentUser!.status == 'Under Monitoring') ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Widget for the logout button
  Widget logoutButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Column(
        children: [
          Row(
            children: const [
              Text(
                'General',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        leading: const Icon(
                          Icons.logout,
                          color: Color(0xFF191313),
                          size: 25,
                        ),
                        title: const Text(
                          'Logout',
                          style: TextStyle(
                            color: Color(0xFF191313),
                            fontSize: 17,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFF191313),
                          size: 15,
                        ),
                        onTap: () {
                          context.read<AuthProvider>().signOut();
                          // pop all screens and go to login
                          Navigator.popUntil(context, ModalRoute.withName('/'));
                          Navigator.pushNamed(context, '/');
                        },
                      ),
                      const Divider(
                        thickness: 2,
                        height: 0,
                        color: Color(0xFFe5e5e5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
