import 'package:flutter/material.dart';

class AddModal extends StatefulWidget {
  BuildContext context;

  AddModal({super.key, required this.context});
  @override
  _AddModalState createState() => _AddModalState();
}

class _AddModalState extends State<AddModal> {
  String? exposure;

  Map<String, bool> symptoms = {
    'Fever (37.8 C and above)': false,
    'Feeling feverish': false,
    ' Muscle or joint pains': false,
    'Cough': false,
    'Colds': false,
    'Sore throat': false,
    'Difficulty of breathing': false,
    'Diarrhea': false,
    'Loss of taste': false,
    'Loss of smell': false,
  };

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: symptoms.length,
                  itemBuilder: (BuildContext context, int index) {
                    String key = symptoms.keys.elementAt(index);
                    return CheckboxListTile(
                      dense: true,
                      title: Text(key),
                      value: symptoms[key],
                      onChanged: (bool? selected) {
                        setState(() {
                          symptoms[key] = selected!;
                        });
                      },
                    );
                  },
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                          'Did you recently have a face-to-face encounter or contact with a confirmed COVID-19 case?'),
                      RadioListTile(
                        title: const Text('Yes'),
                        value: 'Yes',
                        groupValue: exposure,
                        onChanged: (value) {
                          setState(() {
                            exposure = value.toString();
                          });
                        },
                      ),
                      RadioListTile(
                        title: const Text('No'),
                        value: 'No',
                        groupValue: exposure,
                        onChanged: (value) {
                          setState(() {
                            exposure = value.toString();
                          });
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {}, // call add to database
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Confirm'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
