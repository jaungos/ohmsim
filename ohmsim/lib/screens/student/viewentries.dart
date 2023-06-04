import 'package:flutter/material.dart';

class ViewAllEntries extends StatefulWidget {
  ViewAllEntries({super.key});

  @override
  State<ViewAllEntries> createState() => ViewAllEntriesState();
}

class ViewAllEntriesState extends State<ViewAllEntries> {
  // =================== HARD CODED VALUES ONLY ===================
  List<List> entries = [
    ['May 30, 2023', 'Exposed'],
    ['May 29, 2023', 'Healthy'],
    ['May 28, 2023', 'Healthy'],
    ['May 27, 2023', 'Healthy'],
    ['May 26, 2023', 'Healthy'],
    ['May 25, 2023', 'Healthy'],
    ['May 24, 2023', 'Healthy'],
    ['May 23, 2023', 'Exposed'],
  ];
  // ==============================================================

  // @TODO: have a provider method to get the needed data from the database

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: const Color(0xFFffbeab),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleHeader(),
            allHealthEntries(entries),
          ],
        ),
      ),
    );
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
  Widget allHealthEntries(List<List> entries) {
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
              itemCount: entries.length,
              itemBuilder: ((context, index) {
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
                      entries[index][1],
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          color: entries[index][1] == 'Healthy'
                              ? const Color(0xFF21523c)
                              : const Color(0xFF6c1915)),
                    ),
                    trailing: Text(
                      entries[index][0],
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
              }),
            ),
          ],
        ),
      ),
    );
  }
}
