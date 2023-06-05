import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ohmsim/models/entryModel.dart';
import 'package:provider/provider.dart';
import 'package:ohmsim/providers/authProvider.dart';
import 'package:ohmsim/providers/entryProvider.dart';
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
  late User? user;
  late DateTime date;
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

  void addEntry()
  async{
    symptomCheckList = [];

    List<String> symptomKeys = symptoms.keys.toList();
    
    for(int i = 0; i < symptomKeys.length; i++)
    {
      if(symptoms[symptomKeys[i]] == true && symptomKeys[i] != "None")
      {
        symptomCheckList.add(symptomKeys[i]);
      }
    }
    hasContactValue = exposureRadioValue >= 1? true:false;
    await context.read<EntryProvider>().setEntry(symptomsProvider, hasContactValue, email!);
    await context.read<EntryProvider>().addEntry(Entry(symptoms: symptomCheckList, closeContact: hasContact, email: email!, date: date));
  }
  @override
  Widget build(BuildContext context) {
    symptomsProvider = context.watch<EntryProvider>().symptoms;
    hasContact = context.watch<EntryProvider>().hasContact;
    user = context.watch<AuthProvider>().currentUser;
    date = context.watch<EntryProvider>().date;
    email = user!.email;
    
    return AlertDialog(
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
          onPressed: () {
            // @TODO: Handle form submission here including validation
            addEntry();
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
