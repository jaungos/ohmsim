import 'package:flutter/material.dart';
import 'package:ohmsim/providers/authProvider.dart';
import 'package:provider/provider.dart';

class MonitorProfilePage extends StatefulWidget {
  // static String routeName = '/home';
  MonitorProfilePage({super.key});

  @override
  State<MonitorProfilePage> createState() => MonitorProfilePagePageState();
}

class MonitorProfilePagePageState extends State<MonitorProfilePage> {
  @override
  Widget build(BuildContext context) {
    // =================== HARD CODED VALUES ONLY ===================
    final Map<String, dynamic> sampleData = {
      'fname': 'Juan',
      'mname': 'D.',
      'lname': 'Makasalanan',
      'privilege': 'Entrance Monitor',
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
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
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
                    color: const Color(0xFFf6d583)),
                child: IntrinsicWidth(
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Text(
                            '${userInfo['privilege']}',
                            style: const TextStyle(
                              color: Color(0xFF191313),
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
        'icon': Icons.document_scanner,
        'text': 'Scan QR Code',
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
                                  'Scan QR Code') {
                                // @TODO: go to page for scanning the qr code
                              }
                              if (generalButtonsList[index]['text'] ==
                                  'Change to User View') {
                                // @TODO: implement change to user
                              }
                              if (generalButtonsList[index]['text'] ==
                                  'Logout') {
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
