import 'package:flutter/material.dart';
import 'package:ohmsim/screens/admin/viewrequest.dart';

class AdminHomePage extends StatefulWidget {
  AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => AdminHomePageState();
}

class AdminHomePageState extends State<AdminHomePage> {
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
  // ==============================================================

  // @TODO: have a provider method to get the needed data from the database

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          adminHeader(),
          editDeleteRequestsHeader(),
          editDeleteRequests(),
        ],
      ),
    );
  }

  // Widget for the name and status
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
                                // @TODO: Replace the IconButtons with a single TextButton of View Details
                                IconButton(
                                  icon: const Icon(
                                    Icons.check_rounded,
                                    size: 30,
                                    color: Color(0xFF21523c),
                                  ),
                                  onPressed: () {
                                    // @TODO: implement approve request
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.close_sharp,
                                    size: 30,
                                    color: Color(0xFF6c1915),
                                  ),
                                  onPressed: () {
                                    // @TODO: implement deny request
                                  },
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
