import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ohmsim/models/studentUserModel.dart';
import 'package:ohmsim/providers/authProvider.dart';
import 'package:ohmsim/providers/studentUser_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  // static String routeName = '/home';
  HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  // =================== HARD CODED VALUES ONLY ===================
  final Map<String, dynamic> sample = {
    'name': 'Juan',
    // 'status': 'Cleared',
    // 'status': 'Under Monitoring',
    'status': 'Under Quarantine',
    'dailyStatus': null,
    'exposure': 'Yes',
    'healthEntries': [
      ['May 30, 2023', 'Exposed'],
      ['May 29, 2023', 'Healthy'],
      ['May 28, 2023', 'Healthy'],
      ['May 27, 2023', 'Healthy'],
      ['May 26, 2023', 'Healthy'],
      ['May 25, 2023', 'Healthy'],
      ['May 24, 2023', 'Healthy'],
      ['May 23, 2023', 'Exposed'],
    ],
  };
  // ==============================================================
  // @TODO: have a provider method to get the needed data from the database
  StudentUser? studentUser;

  @override
  void initState() {
    super.initState();
    fetchStudentUser();
  }

  Future<void> fetchStudentUser() async {
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
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return SingleChildScrollView(
        child: Column(
          children: [
            welcomeHeader(),
            entryHeader(),
            entry(),
            healthEntriesHeader(),
            healthEntries(),
          ],
        ),
      );
    }
  }

  // Widget for the name and status
  Widget welcomeHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
      child: Column(
        children: [
          Row(
            // ===========================================================
            // @TODO: implement dynamic method to fetch the name and status
            children: [
              Text(
                'Hi, ${studentUser!.fname}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF191313),
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          Row(
            children: [
              if (studentUser!.status == 'Cleared') ...[
                const Text(
                  'Healthy',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF21523c),
                  ),
                ),
              ] else if (studentUser!.status == 'Under Monitoring') ...[
                Text(
                  '${studentUser!.status}',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFf65151),
                  ),
                ),
              ] else if (studentUser!.status == 'Under Quarantine') ...[
                Text(
                  '${studentUser!.status}',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFff0000),
                  ),
                ),
              ] else ...[
                const Text(
                  'No Health Entry Yet',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF191313),
                  ),
                ),
              ]
            ],
          ),
        ],
      ),
    );
  }

  // Widget for today's entry header
  Widget entryHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: const [
                  Text(
                    'Today\'s Entry',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF191313),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        hoverColor: const Color(0xFFd07173),
                        // @TODO: implement edit function
                        onPressed: () {},
                        icon: const Icon(Icons.create_outlined),
                        color: const Color(0xFF00a65a),
                      ),
                      IconButton(
                        hoverColor: const Color(0xFFd07173),
                        // @TODO: implement delete function
                        onPressed: () {},
                        icon: const Icon(Icons.delete_outlined),
                        color: const Color(0xFFf65151),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget for the daily entry itself
  Widget entry() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: const Color(0xFF356c46),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Symptom Header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
                    child: Row(
                      children: const [
                        Text(
                          'Daily Health Status',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFFe9ae48),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Symptoms Itself
                  // @TODO: implement dynamic method to fetch the symptoms
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (sample['dailyStatus'] == null) ...[
                          const Text(
                            'No Symptom/s',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.italic,
                              color: Color(0xFFf9fefa),
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                  // Exposure Header
                  // @TODO: implement dynamic method to fetch the exposure
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
                    child: Row(
                      children: const [
                        Text(
                          'Exposure to a Confirmed COVID-19 Case',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFFe9ae48),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Exposure Itself
                  // @TODO: implement dynamic method to fetch the exposure
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (sample['exposure'] == 'Yes') ...[
                          Text(
                            '${sample['exposure']}. Needs to be quarantined',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.italic,
                              color: Color(0xFFf9fefa),
                            ),
                            // textAlign: TextAlign.center,
                          ),
                        ]
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget for health entries header
  Widget healthEntriesHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: const [
                  Text(
                    'Health Entries',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF191313),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget for the health entry itself
  Widget healthEntries() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: const Color(0xFFffebc7),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Column(
                children: [
                  // @TODO: implement dynamic method to fetch the health entries
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    separatorBuilder: (context, index) {
                      return const Divider(
                        thickness: 2,
                      );
                    },
                    itemBuilder: ((context, index) {
                      return Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          // @TODO: change the layout gayahin medj 'yung sa google classroom
                          child: ListTile(
                            dense: true,
                            title: Text(
                              sample['healthEntries'][index][1],
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                  color: sample['healthEntries'][index][1] ==
                                          'Healthy'
                                      ? const Color(0xFF21523c)
                                      : const Color(0xFF6c1915)),
                            ),
                            trailing: Text(
                              sample['healthEntries'][index][0],
                              style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                color: Color(0xFF191313),
                              ),
                            ),
                            leading: const Icon(
                              Icons.medical_information_outlined,
                              size: 25,
                              color: Color(0xFF191313),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
