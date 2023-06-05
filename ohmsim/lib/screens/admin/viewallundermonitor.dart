import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ohmsim/models/studentUserModel.dart';
import 'package:ohmsim/providers/adminProvider.dart';
import 'package:ohmsim/providers/studentUser_provider.dart';
import 'package:ohmsim/screens/admin/adminview.dart';
import 'package:provider/provider.dart';

class UnderMonitorView extends StatefulWidget {
  static String routeName = '/viewundermonitor';
  UnderMonitorView({super.key});

  @override
  State<UnderMonitorView> createState() => UnderMonitorViewState();
}

class UnderMonitorViewState extends State<UnderMonitorView> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> allStudentStream =
        context.watch<StudentUserProvider>().users;

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Under Monitor Students',
          ),
        ),
        backgroundColor: const Color(0xFF6c1915),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Show the list of students here
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
              child: StreamBuilder<QuerySnapshot>(
                stream: allStudentStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error encountered! ${snapshot.error}"),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      try {
                        StudentUser student = StudentUser.fromJson(
                            snapshot.data?.docs[index].data()
                                as Map<String, dynamic>);
                        student.id = snapshot.data?.docs[index].id;
                        if (student.status == "Under Monitoring") {
                          return Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color(0xFFe5e5e5),
                                ),
                              ),
                            ),
                            child: ListTile(
                              onTap: () {
                                // Create a modal that would display all of the student's information
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return studentInfo(student);
                                  },
                                );
                              },
                              title: Text(
                                "${student.fname} ${student.mname} ${student.lname}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF191313),
                                ),
                              ),
                              subtitle: Text(
                                student.email,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xFF191313),
                                ),
                              ),
                              trailing: const Text(
                                'View More',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xFF191313),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for back button
  Widget backButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF21523c),
      ),
      child: const Text(
        'Close',
        style: TextStyle(
          color: Color(0xFFf9fefa),
        ),
      ),
      onPressed: () {
        Navigator.popUntil(context, ModalRoute.withName(AdminView.routeName));
      },
    );
  }

  // Widget for the student information modal
  AlertDialog studentInfo(StudentUser student) {
    return AlertDialog(
      insetPadding: const EdgeInsets.fromLTRB(10, 80, 10, 80),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Student Information',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: Color(0xFF191313),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: Center(
        child: SizedBox(
          width: double.maxFinite,
          child: ListView(
            children: [
              ListTile(
                title: const Text(
                  'Status',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF191313),
                  ),
                ),
                subtitle: Text(
                  student.status == 'Cleared'
                      ? 'Healthy'
                      : student.status == 'Under Monitoring'
                          ? 'Under Monitoring'
                          : student.status == 'Under Quarantine'
                              ? 'Under Quarantined'
                              : 'No Healthy Entry Yet',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                    color: student.status == 'Cleared'
                        ? const Color(0xFF21523c)
                        : student.status == 'Under Monitoring'
                            ? const Color(0xFFf65151)
                            : student.status == 'Under Quarantine'
                                ? const Color(0xFFff0000)
                                : const Color(0xFF191313),
                  ),
                ),
              ),
              ListTile(
                title: const Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF191313),
                  ),
                ),
                subtitle: Text(
                  student.email,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                    color: Color(0xFF191313),
                  ),
                ),
              ),
              ListTile(
                title: const Text(
                  'Full Name',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF191313),
                  ),
                ),
                subtitle: Text(
                  '${student.fname} ${student.mname} ${student.lname}',
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                    color: Color(0xFF191313),
                  ),
                ),
              ),
              ListTile(
                title: const Text(
                  'Username',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF191313),
                  ),
                ),
                subtitle: Text(
                  student.username,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                    color: Color(0xFF191313),
                  ),
                ),
              ),
              ListTile(
                title: const Text(
                  'College',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF191313),
                  ),
                ),
                subtitle: Text(
                  student.college,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                    color: Color(0xFF191313),
                  ),
                ),
              ),
              ListTile(
                title: const Text(
                  'Course',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF191313),
                  ),
                ),
                subtitle: Text(
                  student.course,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                    color: Color(0xFF191313),
                  ),
                ),
              ),
              ListTile(
                title: const Text(
                  'Student Number',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF191313),
                  ),
                ),
                subtitle: Text(
                  student.studentNo,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                    color: Color(0xFF191313),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF21523c),
          ),
          child: const Text(
            'Move to Quarantine',
            style: TextStyle(
              color: Color(0xFFf9fefa),
            ),
          ),
          onPressed: () async {
            final message = await context
                .read<AdminMonitorProvider>()
                .moveToQuarantine(student.id!);

            debugPrint(message);

            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6c1915),
          ),
          child: const Text(
            'End Monitoring',
            style: TextStyle(
              color: Color(0xFFf9fefa),
            ),
          ),
          onPressed: () async {
            final message = await context
                .read<AdminMonitorProvider>()
                .endMonitoring(student.id!);

            debugPrint(message);

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
