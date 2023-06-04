import 'package:flutter/material.dart';

class AddEntry extends StatefulWidget {
  @override
  _AddEntryState createState() => _AddEntryState();
}

class _AddEntryState extends State<AddEntry> {
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

  @override
  Widget build(BuildContext context) {
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
