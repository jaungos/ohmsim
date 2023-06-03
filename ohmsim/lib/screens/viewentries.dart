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
      child: Column(
        children: [
          titleHeader(),
          allHealthEntries(entries),
        ],
      ),
    );
  }

  // Widget for the title header
  Widget titleHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: const [
                  Text(
                    'All Health Entries',
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

  // Widget for the list of all health entries
  Widget allHealthEntries(List<List> entries) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        children: [
          // ListView builder for at most 5 entries only
          ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: entries.length,
            itemBuilder: ((context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: index % 2 == 0
                        ? const Color(0xFFc68932)
                        : const Color(0xFFf0c974),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: ListTile(
                        title: Text(
                          entries[index][1],
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 25,
                              color: entries[index][1] == 'Healthy'
                                  ? const Color(0xFF21523c)
                                  : const Color(0xFF6c1915)),
                        ),
                        subtitle: Text(
                          entries[index][0],
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                            color: Color(0xFF191313),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
