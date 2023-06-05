import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ohmsim/models/studentUserModel.dart';
import 'package:ohmsim/providers/adminProvider.dart';
import 'package:ohmsim/providers/studentUser_provider.dart';
import 'package:provider/provider.dart';

class StudentListView extends StatefulWidget {
  StudentListView({super.key});

  @override
  State<StudentListView> createState() => StudentListViewState();
}

class StudentListViewState extends State<StudentListView> {
  TextEditingController searchController = TextEditingController();
  String name = "";

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> allStudentStream =
        context.watch<StudentUserProvider>().users;

    if (allStudentStream == null) {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Enter student\'s name',
                  // Changes the border color when the field is active/clicked
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF21523c),
                      width: 2,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Color(0xFF21523c),
                    ),
                    onPressed: () {
                      // Call the search function here
                      // searchStudents(searchController.text);
                    },
                  ),
                ),
                style: const TextStyle(
                  fontSize: 18,
                ),
                onChanged: (val) {
                  setState(() {
                    name = val;
                  });
                },
              ),
            ),
            // Show header for search results
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
              child: Text(
                'Search Results',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF191313),
                ),
              ),
            ),
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
                        if (student.privilege == 'Student' && name.isEmpty) {
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
                                    return AlertDialog(
                                      insetPadding: const EdgeInsets.fromLTRB(
                                          10, 80, 10, 80),
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                          ),
                                        ],
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      content: Center(
                                        child: SizedBox(
                                          width: double.maxFinite,
                                          child: ListView(
                                            children: [
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
                                                    fontWeight:
                                                        FontWeight.normal,
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
                                                    fontWeight:
                                                        FontWeight.normal,
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
                                                    fontWeight:
                                                        FontWeight.normal,
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
                                                    fontWeight:
                                                        FontWeight.normal,
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
                                                    fontWeight:
                                                        FontWeight.normal,
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
                                                    fontWeight:
                                                        FontWeight.normal,
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
                                            backgroundColor:
                                                const Color(0xFF21523c),
                                          ),
                                          child: const Text(
                                            'Elevate To Entrance Monitor',
                                            style: TextStyle(
                                              color: Color(0xFFf9fefa),
                                            ),
                                          ),
                                          onPressed: () async {
                                            final message = await context
                                                .read<AdminMonitorProvider>()
                                                .elevateUser(
                                                  student,
                                                  'Entrance Monitor',
                                                );

                                            debugPrint(message);

                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFF21523c),
                                          ),
                                          child: const Text(
                                            'Elevate To Admin',
                                            style: TextStyle(
                                              color: Color(0xFFf9fefa),
                                            ),
                                          ),
                                          onPressed: () async {
                                            final message = await context
                                                .read<AdminMonitorProvider>()
                                                .elevateUser(
                                                  student,
                                                  'Admin',
                                                );

                                            debugPrint(message);

                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
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
                        } else if (student.privilege == 'Student' &&
                            '${student.fname} ${student.mname} ${student.lname}'
                                .toLowerCase()
                                .contains(name)) {
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
                                    return AlertDialog(
                                      insetPadding: const EdgeInsets.fromLTRB(
                                          10, 80, 10, 80),
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                          ),
                                        ],
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      content: Center(
                                        child: SizedBox(
                                          width: double.maxFinite,
                                          child: ListView(
                                            children: [
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
                                                    fontWeight:
                                                        FontWeight.normal,
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
                                                    fontWeight:
                                                        FontWeight.normal,
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
                                                    fontWeight:
                                                        FontWeight.normal,
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
                                                    fontWeight:
                                                        FontWeight.normal,
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
                                                    fontWeight:
                                                        FontWeight.normal,
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
                                                    fontWeight:
                                                        FontWeight.normal,
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
                                            backgroundColor:
                                                const Color(0xFF21523c),
                                          ),
                                          child: const Text(
                                            'Elevate To Entrance Monitor',
                                            style: TextStyle(
                                              color: Color(0xFFf9fefa),
                                            ),
                                          ),
                                          onPressed: () async {
                                            final message = await context
                                                .read<AdminMonitorProvider>()
                                                .elevateUser(
                                                  student,
                                                  'Entrance Monitor',
                                                );

                                            debugPrint(message);

                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFF21523c),
                                          ),
                                          child: const Text(
                                            'Elevate To Admin',
                                            style: TextStyle(
                                              color: Color(0xFFf9fefa),
                                            ),
                                          ),
                                          onPressed: () async {
                                            final message = await context
                                                .read<AdminMonitorProvider>()
                                                .elevateUser(
                                                  student,
                                                  'Admin',
                                                );

                                            debugPrint(message);

                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
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
      );
    }
  }
}
