import 'package:flutter/material.dart';
import 'package:ohmsim/screens/viewentries.dart';

class HomePage extends StatefulWidget {
  // static String routeName = '/home';
  HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  // =================== HARD CODED VALUES ONLY ===================
  final Map<String, dynamic> sample = {
    'name': 'Juan',
    'status': 'Healthy',
    'dailyStatus': null,
    'exposure': 'Yes',
    'healthEntries': [
      ['May 30, 2023', 'Exposed'],
      ['May 29, 2023', 'Healthy'],
      ['May 28, 2023', 'Healthy'],
      ['May 27, 2023', 'Healthy'],
      ['May 26, 2023', 'Healthy'],
      ['May 25, 2023', 'Healthy'],
      ['May 24, 2023', 'Healthy'],
      ['May 23, 2023', 'Exposed'],
    ],
  };
  // ==============================================================

  // @TODO: have a provider method to get the needed data from the database

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          welcomeHeader(),
          entryHeader(),
          entry(),
          healthEntriesHeader(),
          healthEntries(),
        ],
      ),
    );
  }

  // Widget for the name and status
  Widget welcomeHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
      child: Column(
        children: [
          Row(
            // ===========================================================
            // @TODO: implement dynamic method to fetch the name and status
            children: [
              Text(
                'Hi, ${sample['name']}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF191313),
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          Row(
            children: [
              if (sample['status'] == 'Healthy') ...[
                Text(
                  '${sample['status']} (Not Quarantined)',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF21523c),
                  ),
                ),
              ] else ...[
                Text(
                  '${sample['status']} (Quarantined)',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFf65151),
                  ),
                ),
              ]
            ],
          ),
        ],
      ),
    );
  }

  // Widget for today's entry header
  Widget entryHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                children: [
                  Text(
                    'Today\'s Entry',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF191313),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        hoverColor: const Color(0xFFd07173),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Sample Prompt'),
                              content: const Text('This is a sample prompt.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Okay'),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(Icons.create_outlined),
                        color: const Color(0xFF00a65a),
                      ),
                      IconButton(
                        hoverColor: const Color(0xFFd07173),
                        onPressed: () {
                          // create an sample prompt that the button is pressed
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Sample Prompt'),
                              content: const Text('This is a sample prompt.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Okay'),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(Icons.delete_outlined),
                        color: const Color(0xFFf65151),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget for the daily entry itself
  Widget entry() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: const Color(0xFF1d4429),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Symptom Header
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 40, 20, 10),
                    child: Row(
                      children: [
                        Text(
                          'Daily Health Status',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFFe9ae48),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Symptoms Itself
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (sample['dailyStatus'] == null) ...[
                          const Text(
                            'No Symptom/s',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.italic,
                              color: Color(0xFFf9fefa),
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                  // Exposure Header
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 15, 20, 10),
                    child: Row(
                      children: [
                        Text(
                          'Exposure to a Confirmed COVID-19 Case',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFFe9ae48),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Exposure Itself
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (sample['exposure'] == 'Yes') ...[
                          Text(
                            '${sample['exposure']}. Needs to be quarantined',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.italic,
                              color: Color(0xFFf9fefa),
                            ),
                            // textAlign: TextAlign.center,
                          ),
                        ]
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget for health entries header
  Widget healthEntriesHeader() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    'Health Entries',
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

  // Widget for the health entry itself
  Widget healthEntries() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
      child: Column(
        children: [
          // ListView builder for at most 5 entries only
          ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: 5,
            itemBuilder: ((context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: index % 2 == 0
                        ? const Color(0xFFe4bc79)
                        : const Color(0xFFe7cda1),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: ListTile(
                        title: Text(
                          sample['healthEntries'][index][1],
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 25,
                              color:
                                  sample['healthEntries'][index][1] == 'Healthy'
                                      ? const Color(0xFF21523c)
                                      : const Color(0xFF6c1915)),
                        ),
                        subtitle: Text(
                          sample['healthEntries'][index][0],
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
