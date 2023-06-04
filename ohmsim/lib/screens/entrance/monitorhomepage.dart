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
}
