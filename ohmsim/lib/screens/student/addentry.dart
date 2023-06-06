import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ohmsim/models/studentUserModel.dart';

import 'package:ohmsim/providers/studentUser_provider.dart';
import 'package:provider/provider.dart';
import 'package:ohmsim/providers/authProvider.dart';

class AddEntry extends StatefulWidget {
  @override
  _AddEntryState createState() => _AddEntryState();
}

class _AddEntryState extends State<AddEntry> {
  String? email;
  List<String> symptomCheckList = [];
  bool hasContactValue = false;
  late List<String> symptomsProvider;
  late bool hasContact;

  late DateTime date;
  StudentUser? user;
  @override
  void initState() {
    super.initState();
    fetchStudentUser();
  }

  Future<void> fetchStudentUser() async {
    User? currentUser = context.read<AuthProvider>().currentUser;
    String email = currentUser!.email!;
    StudentUser student =
        await context.read<StudentUserProvider>().getStudentUser(email);
    setState(() {
      user = student;
    });
  }

  Map<String, bool> symptoms = {
    'None': false,
    'Fever (37.8°C and above)': false,
    'Feeling feverish': false,
    'Muscle or joint pains': false,
    'Cough': false,
    'Colds': false,
    'Sore throat': false,
    'Difficulty of breathing': false,
    'Diarrhea': false,
    'Loss of taste': false,
    'Loss of smell': false,
  };
  int exposureRadioValue = -1;
  bool closecontact = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      title: const Text(
        'Health Assessment',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w700,
          color: Color(0xFF191313),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select your symptoms:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
            Column(
              children: symptoms.keys.map((String symptom) {
                return CheckboxListTile(
                  title: Text(
                    symptom,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  value: symptoms[symptom],
                  activeColor: const Color(0xFF21523c),
                  onChanged: (bool? value) {
                    setState(() {
                      if (symptom == 'None') {
                        // If 'None' is selected, disable other symptoms
                        symptoms.forEach((key, _) {
                          symptoms[key] = false;
                        });
                      } else {
                        // Uncheck 'None' if any other symptom is selected
                        symptoms['None'] = false;
                      }
                      symptoms[symptom] = value!;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Did you recently have a face-to-face encounter or contact with a confirmed COVID-19 case?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 0,
                            groupValue: exposureRadioValue,
                            activeColor: const Color(0xFF21523c),
                            onChanged: (value) {
                              setState(() {
                                exposureRadioValue = value!;
                              });
                            },
                          ),
                          const Text(
                            'Yes',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 1,
                            groupValue: exposureRadioValue,
                            activeColor: const Color(0xFF21523c),
                            onChanged: (value) {
                              setState(() {
                                exposureRadioValue = value!;
                              });
                            },
                          ),
                          const Text(
                            'No',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6c1915),
          ),
          child: const Text(
            'Close',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Color(0xFFf9fefa),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            if (exposureRadioValue == 0) {
              closecontact = true;
            } else {
              closecontact = false;
            }
            bool todaysEntry = true;
            List<String> symptomss = symptoms.entries
                .where((entry) => entry.value == true)
                .map((entry) => entry.key)
                .toList();

            final Map<String, dynamic> entry = {
              "symptoms": symptomss,
              "closeContact": closecontact,
              "date": DateTime.now()
            };

            // ignore: use_build_context_synchronously
            context
                .read<StudentUserProvider>()
                .addTodaysEntry(user!.id!, entry, todaysEntry);
            // @TODO: Handle form submission here including validation
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF21523c),
          ),
          child: const Text(
            'Submit',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Color(0xFFf9fefa),
            ),
          ),
        ),
      ],
    );
  }
}
