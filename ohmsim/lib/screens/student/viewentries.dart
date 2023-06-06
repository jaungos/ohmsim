import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ohmsim/models/studentUserModel.dart';
import 'package:ohmsim/providers/authProvider.dart';
import 'package:ohmsim/providers/studentUser_provider.dart';
import 'package:provider/provider.dart';

class ViewAllEntries extends StatefulWidget {
  ViewAllEntries({super.key});

  @override
  State<ViewAllEntries> createState() => ViewAllEntriesState();
}

class ViewAllEntriesState extends State<ViewAllEntries> {
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
        child: Container(
          color: const Color(0xFFffbeab),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleHeader(),
              allHealthEntries(),
            ],
          ),
        ),
      );
    }
  }

  // Widget for the title header
  Widget titleHeader() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
      child: Text(
        'All Health Entries',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: Color(0xFF191313),
        ),
        textAlign: TextAlign.left,
      ),
    );
  }

  // Widget for the list of all health entries
  Widget allHealthEntries() {
    return Container(
      color: const Color(0xFFf9fefa),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
        child: Column(
          children: [
            // ListView builder for at most 5 entries only
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: studentUser!.entries.length,
              itemBuilder: ((context, index) {
                try {
                  DateTime curDate =
                      studentUser!.entries[index]['date'].toDate();

                  return Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFe5e5e5),
                        ),
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        studentUser!.entries[index]['closeContact'] == 'false'
                            ? 'Exposed'
                            : 'Healthy',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                            color: studentUser!.entries[index]
                                        ['closeContact'] ==
                                    'false'
                                ? const Color(0xFF21523c)
                                : const Color(0xFF6c1915)),
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
                  );
                } catch (e) {
                  print(e);
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
