import 'package:flutter/material.dart';
import 'package:ohmsim/screens/admin/viewrequest.dart';

class AdminHomePage extends StatefulWidget {
  AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => AdminHomePageState();
}

class AdminHomePageState extends State<AdminHomePage> {
  // =================== HARD CODED VALUES ONLY ===================
  final Map<String, dynamic> sample = {
    'name': 'Jerico',
    'privilege': 'Admin',
    'requests': [
      {
        'type': 'Edit',
        'email': 'jdmakasalanan@up.edu.ph',
        'date': '04-06-2023',
        'status': 'Under Monitoring',
        'symptoms': ['Cough', 'Colds', 'Sore Throat'],
        'closeContact': false,
      },
      {
        'type': 'Edit',
        'email': 'jdmakasalanan@up.edu.ph',
        'date': '03-12-2022',
        'status': 'Under Quarantine',
        'symptoms': ['None'],
        'closeContact': false,
      },
      {
        'type': 'Delete',
        'email': 'jdmakasalanan@up.edu.ph',
        'date': '01-06-2023',
        'status': 'Cleared',
      },
    ],
  };

  final List<String> quarantinedStudents = [
    'jaungos@up.edu.ph',
    'jlaungos@up.edu.ph',
    'juanmakasalanan@up.edu.ph',
  ];
  // ==============================================================

  // @TODO: have a provider method to get the needed data from the database

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          adminHeader(),
          quarantineCounter(),
          editDeleteRequestsHeader(),
          editDeleteRequests(),
        ],
      ),
    );
  }

  // Widget for the name and privilege
  Widget adminHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Hi, ${sample['name']}',
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
                Text(
                  sample['privilege'],
                  style: const TextStyle(
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
      ),
    );
  }

  // Widget for the tracker of the number of students in quarantine
  Widget quarantineCounter() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 210,
            height: 210,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(
                  color: Color(0xFF191313),
                  width: 1.0,
                ),
              ),
              color: const Color(0xFFe6b8b7),
              elevation: 4, // Add elevation for the shadow effect
              shadowColor: Colors.grey[400], // Set the shadow color
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Quarantined',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.coronavirus),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${quarantinedStudents.length}',
                          style: const TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Text(
                          'Students',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget for the edit and delete today's entry requests header
  Widget editDeleteRequestsHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
      child: Column(
        children: [
          Row(
            children: const [
              Text(
                'Incoming Requests',
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
    );
  }

  // Widget for the edit and delete today's entry requests
  Widget editDeleteRequests() {
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
                    itemCount: sample['requests'].length,
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
                              "${sample['requests'][index]['date']}  - ${sample['requests'][index]['type']}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF191313),
                              ),
                            ),
                            subtitle: Text(
                              sample['requests'][index]['email'],
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                color: Color(0xFF191313),
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return RequestModalForm(
                                          date: sample['requests'][index]
                                              ['date'],
                                          email: sample['requests'][index]
                                              ['email'],
                                          status: sample['requests'][index]
                                              ['status'],
                                          isEditRequest: sample['requests']
                                                      [index]['type'] ==
                                                  'Edit'
                                              ? true
                                              : false,
                                          newSymptoms: sample['requests'][index]
                                                      ['type'] ==
                                                  'Edit'
                                              ? sample['requests'][index]
                                                  ['symptoms']
                                              : null,
                                          exposure: sample['requests'][index]
                                                      ['type'] ==
                                                  'Edit'
                                              ? sample['requests'][index]
                                                  ['closeContact']
                                              : null,
                                        );
                                      },
                                    );
                                  },
                                  child: const Text(
                                    'View Details',
                                    style: TextStyle(
                                      color: Color(0xFF191313),
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return RequestModalForm(
                                    date: sample['requests'][index]['date'],
                                    email: sample['requests'][index]['email'],
                                    status: sample['requests'][index]['status'],
                                    isEditRequest: sample['requests'][index]
                                                ['type'] ==
                                            'Edit'
                                        ? true
                                        : false,
                                    newSymptoms: sample['requests'][index]
                                                ['type'] ==
                                            'Edit'
                                        ? sample['requests'][index]['symptoms']
                                        : null,
                                    exposure: sample['requests'][index]
                                                ['type'] ==
                                            'Edit'
                                        ? sample['requests'][index]
                                            ['closeContact']
                                        : null,
                                  );
                                },
                              );
                            },
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
