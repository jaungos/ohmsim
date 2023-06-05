import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ohmsim/providers/authProvider.dart';

class ProfilePage extends StatefulWidget {
  // static String routeName = '/home';
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    // =================== HARD CODED VALUES ONLY ===================
    final Map<String, dynamic> sampleData = {
      'fname': 'Juan',
      'mname': 'D.',
      'lname': 'Makasalanan',
      'status': 'Cleared',
      // 'status': 'Under Monitoring',
      // 'status': 'Under Quarantine',
    };
    // ==============================================================

    // @TODO: layout the profile page and add the logout button here
    return SingleChildScrollView(
      child: Column(
        children: [
          profileInfo(sampleData),
          logoutButton(),
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
                  color: userInfo['status'] == 'Cleared'
                      ? const Color(0xFFb8c9ba)
                      : userInfo['status'] == 'Under Monitoring'
                          ? const Color(0xFFffbeab)
                          : const Color(0xFFffaaaa),
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
                                  color: userInfo['status'] == 'Cleared'
                                      ? const Color(0xFF21523c)
                                      : userInfo['status'] == 'Under Monitoring'
                                          ? const Color(0xFFf65151)
                                          : const Color(0xFFff0000),
                                  size: 15,
                                ),
                              ),
                              Text(
                                userInfo['status'],
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: userInfo['status'] == 'Cleared'
                                      ? const Color(0xFF21523c)
                                      : userInfo['status'] == 'Under Monitoring'
                                          ? const Color(0xFFf65151)
                                          : const Color(0xFFff0000),
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
            if (userInfo['status'] == 'Cleared' ||
                userInfo['status'] == 'Under Monitoring') ...[
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
