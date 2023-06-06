import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ohmsim/models/studentUserModel.dart';
import 'package:ohmsim/providers/authProvider.dart';
import 'package:ohmsim/providers/studentUser_provider.dart';
import 'package:ohmsim/screens/student/deleteentry.dart';
import 'package:ohmsim/screens/student/editentry.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  // static String routeName = '/home';
  HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
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
                  studentUser!.status,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFf65151),
                  ),
                ),
              ] else if (studentUser!.status == 'Under Quarantine') ...[
                Text(
                  studentUser!.status,
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
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return EditEntry();
                            },
                          );
                        },
                        icon: const Icon(Icons.create_outlined),
                        color: const Color(0xFF00a65a),
                      ),
                      IconButton(
                        hoverColor: const Color(0xFFd07173),
                        // @TODO: implement delete function
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return DeleteEntry();
                            },
                          );
                        },
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
              child: studentUser!.hasDailyEntry
                  ? Column(
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
                              if (studentUser!
                                  .entries[0]['symptoms'].isEmpty) ...[
                                const Text(
                                  'No Symptom/s',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                    fontStyle: FontStyle.italic,
                                    color: Color(0xFFf9fefa),
                                  ),
                                ),
                              ] else ...[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                    studentUser!.entries[0]['symptoms'].length,
                                    (index) {
                                      final symptom = studentUser!.entries[0]
                                          ['symptoms'][index];
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16),
                                        child: Text(
                                          '${index + 1}. $symptom',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w300,
                                            fontStyle: FontStyle.italic,
                                            color: Color(0xFFf9fefa),
                                          ),
                                        ),
                                      );
                                    },
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
                              if (studentUser!.entries[0]['closeContact'] ==
                                  false) ...[
                                const Text(
                                  'Exposed. Needs to be quarantined',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                    fontStyle: FontStyle.italic,
                                    color: Color(0xFFf9fefa),
                                  ),
                                  // textAlign: TextAlign.center,
                                ),
                              ] else ...[
                                const Text(
                                  'Not Exposed',
                                  style: TextStyle(
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
                    )
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (studentUser!.hasDailyEntry == false) ...[
                            const Text(
                              'Has not filled up the daily health status yet!',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.normal,
                                color: Color(0xFFf9fefa),
                              ),
                            ),
                          ]
                        ],
                      ),
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
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: studentUser!.entries.length < 5
                        ? studentUser!.entries.length
                        : 5,
                    separatorBuilder: (context, index) {
                      return const Divider(
                        thickness: 2,
                      );
                    },
                    itemBuilder: ((context, index) {
                      try {
                        DateTime curDate =
                            studentUser!.entries[index]['date'].toDate();

                        return Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            // @TODO: change the layout gayahin medj 'yung sa google classroom
                            child: ListTile(
                              dense: true,
                              title: Text(
                                studentUser!.entries[index]['closeContact'] ==
                                        'false'
                                    ? 'Exposed'
                                    : 'Healthy',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                  color: studentUser!.entries[index]
                                              ['closeContact'] ==
                                          'false'
                                      ? const Color(0xFF21523c)
                                      : const Color(0xFF6c1915),
                                ),
                              ),
                              trailing: Text(
                                "${curDate.month.toString()}/${curDate.day.toString()}/${curDate.year.toString()}",
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
                      } catch (e) {
                        print(e);
                      }
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
