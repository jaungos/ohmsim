import 'package:flutter/material.dart';
import 'package:ohmsim/providers/authProvider.dart';
import 'package:provider/provider.dart';

class AdminProfilePage extends StatefulWidget {
  // static String routeName = '/home';
  AdminProfilePage({super.key});

  @override
  State<AdminProfilePage> createState() => AdminProfilePageState();
}

class AdminProfilePageState extends State<AdminProfilePage> {
  @override
  Widget build(BuildContext context) {
    // =================== HARD CODED VALUES ONLY ===================
    final Map<String, dynamic> sampleData = {
      'fname': 'Jerico Luis',
      'mname': 'A.',
      'lname': 'Ungos',
      'privilege': 'Admin',
    };
    // ==============================================================

    return SingleChildScrollView(
      child: Column(
        children: [
          profileInfo(sampleData),
          generalButtons(),
        ],
      ),
    );
  }

  // Widget for the profile info
  Widget profileInfo(Map<String, dynamic> userInfo) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
      child: Center(
        child: Column(
          children: [
            // Logo of the app
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(75),
                child: Image.asset(
                  'assets/samplelogo.png',
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
                '${userInfo['fname']} ${userInfo['mname']} ${userInfo['lname']}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Status of the user
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Text(
                '${userInfo['privilege']}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for the general buttons for the different features of the app
  Widget generalButtons() {
    final List<Map<String, dynamic>> generalButtonsList = [
      {
        'icon': Icons.supervisor_account,
        'text': 'Under Monitoring Students',
      },
      {
        'icon': Icons.accessibility_new,
        'text': 'Quarantined Students',
      },
      {
        'icon': Icons.switch_account,
        'text': 'Change to User View',
      },
      {
        'icon': Icons.logout,
        'text': 'Logout',
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(15),
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
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: generalButtonsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          ListTile(
                            leading: Icon(
                              generalButtonsList[index]['icon'],
                              color: const Color(0xFF191313),
                              size: 25,
                            ),
                            title: Text(
                              generalButtonsList[index]['text'],
                              style: const TextStyle(
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
                              if (generalButtonsList[index]['text'] ==
                                  'Under Monitoring Students') {
                                // @TODO: go to page for under monitoring students
                              }
                              if (generalButtonsList[index]['text'] ==
                                  'Quarantined Students') {
                                // @TODO: go to page for quarantine students
                              }
                              if (generalButtonsList[index]['text'] ==
                                  'Change to User View') {
                                // @TODO: implement change to user
                              }
                              if (generalButtonsList[index]['text'] ==
                                  'Logout') {
                                // @TODO: go to page for quarantine students
                                context.read<AuthProvider>().signOut();
                                // pop all screens and go to login
                                Navigator.popUntil(
                                    context, ModalRoute.withName('/'));
                                Navigator.pushNamed(context, '/');
                              }
                            },
                          ),
                          const Divider(
                            thickness: 2,
                            height: 0,
                            color: Color(0xFFe5e5e5),
                          ),
                        ],
                      );
                    },
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
