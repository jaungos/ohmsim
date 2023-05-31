import 'package:flutter/material.dart';
import 'package:ohmsim/providers/adminProvider.dart';
import 'package:ohmsim/providers/authProvider.dart';
import 'package:ohmsim/states/adminScreenStates.dart';
import 'package:ohmsim/stateLogic/adminContentStateLogic.dart';
import 'package:ohmsim/stateLogic/viewStateLogic.dart';
import './drawer.dart';
import 'package:provider/provider.dart';

class GeneralView extends StatefulWidget {
  static String routeName = '/view';
  GeneralView({super.key});

  @override
  State<GeneralView> createState() => GeneralViewState();
}

class GeneralViewState extends State<GeneralView> {
  late String view;
  late String status;
  late String name;
  late String privilege;
  late String screen;

  @override
  void initState() {
    context.read<AuthProvider>().getCredentials();
  }

  @override
  Widget build(BuildContext context) {
    view = context.watch<AuthProvider>().view;
    status = context.watch<AuthProvider>().status;
    name = context.watch<AuthProvider>().name;
    privilege = context.watch<AuthProvider>().privilege;
    screen = context
        .watch<AdminProvider>()
        .screen; // Change the provider package to include all user types.
    return Scaffold(
      drawer: drawerView(view, status, name, privilege, context),
      appBar: AppBar(
        title: const Text('OHMSIM'),
      ),
      body: viewStateLogic(screen),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddModal(context); // Go to add entry
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  _showAddModal(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  constraints: const BoxConstraints(maxHeight: 560),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
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
                  ),
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
              ],
            ),
          ),
        );
      },
    );
  }
}
