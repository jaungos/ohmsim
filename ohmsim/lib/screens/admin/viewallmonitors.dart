import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ohmsim/models/adminMonitor.dart';
import 'package:ohmsim/models/studentUserModel.dart';
import 'package:ohmsim/providers/adminProvider.dart';
import 'package:ohmsim/providers/studentUser_provider.dart';
import 'package:ohmsim/screens/admin/adminview.dart';
import 'package:provider/provider.dart';

class MonitorListView extends StatefulWidget {
  static String routeName = '/viewallmonitors';
  MonitorListView({super.key});

  @override
  State<MonitorListView> createState() => MonitorListViewState();
}

class MonitorListViewState extends State<MonitorListView> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> allAdminMonitorStream =
        context.watch<AdminMonitorProvider>().adminMonitors;

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Entrance Monitors',
          ),
        ),
        backgroundColor: const Color(0xFF6c1915),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Show the list of students here
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
              child: StreamBuilder<QuerySnapshot>(
                stream: allAdminMonitorStream,
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
                        AdminMonitor adminMonitor = AdminMonitor.fromJson(
                            snapshot.data?.docs[index].data()
                                as Map<String, dynamic>);
                        adminMonitor.id = snapshot.data?.docs[index].id;
                        print(snapshot.data?.docs.length);
                        print(adminMonitor.id);
                        if (adminMonitor.privilege == 'Admin') {
                          return Container();
                        }
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
                                        10, 100, 10, 100),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Employee Information',
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
                                      borderRadius: BorderRadius.circular(10.0),
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
                                                adminMonitor.email,
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
                                                '${adminMonitor.fname} ${adminMonitor.mname} ${adminMonitor.lname}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 18,
                                                  color: Color(0xFF191313),
                                                ),
                                              ),
                                            ),
                                            ListTile(
                                              title: const Text(
                                                'Employee Number',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300,
                                                  color: Color(0xFF191313),
                                                ),
                                              ),
                                              subtitle: Text(
                                                adminMonitor.employeeNo,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 18,
                                                  color: Color(0xFF191313),
                                                ),
                                              ),
                                            ),
                                            ListTile(
                                              title: const Text(
                                                'Home Unit',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300,
                                                  color: Color(0xFF191313),
                                                ),
                                              ),
                                              subtitle: Text(
                                                adminMonitor.homeUnit,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 18,
                                                  color: Color(0xFF191313),
                                                ),
                                              ),
                                            ),
                                            ListTile(
                                              title: const Text(
                                                'Position',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300,
                                                  color: Color(0xFF191313),
                                                ),
                                              ),
                                              subtitle: Text(
                                                adminMonitor.position,
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
                                              .elevateEntranceMonitor(
                                                adminMonitor.id!,
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
                              "${adminMonitor.fname} ${adminMonitor.mname} ${adminMonitor.lname}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF191313),
                              ),
                            ),
                            subtitle: Text(
                              adminMonitor.email,
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
                      } catch (e) {
                        print(e);
                      }
                    },
                  );
                },
              ),
            ),
            backButton(),
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
}
