import 'package:flutter/material.dart';

class MonitorHomePage extends StatefulWidget {
  MonitorHomePage({Key? key});

  @override
  State<MonitorHomePage> createState() => MonitorHomePageState();
}

class MonitorHomePageState extends State<MonitorHomePage> {
  final Map<String, dynamic> sample = {
    'name': 'Jerico',
    'privilege': 'Entrance Monitor',
  };
  // ==============================================================
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          monitorHeader(),
          studentLogsHeader(),
        ],
      ),
    );
  }

  // Widget for the name and status
  Widget monitorHeader() {
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

  // Widget for the student logs header
  Widget studentLogsHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
      child: Column(
        children: [
          Row(
            children: const [
              Text(
                'Students Logs',
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

  // Widget for the list of student logs
  Widget studentLogs() {
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
