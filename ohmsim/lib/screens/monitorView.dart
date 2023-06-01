import 'package:flutter/material.dart';
import 'package:ohmsim/providers/adminProvider.dart';
import 'package:ohmsim/providers/authProvider.dart';
import 'package:ohmsim/states/adminScreenStates.dart';
import 'package:ohmsim/stateLogic/adminContentStateLogic.dart';
import './drawer.dart';
import 'package:provider/provider.dart';
import 'package:ohmsim/providers/entryProvider.dart';
import 'package:ohmsim/models/entryModel.dart';

/*

TODO: Refactor adminView to just view. 

1. Replace the state logic in the body section.

Instead of solely relying on the adminContentStateLogic file. Replace and refactor it with
viewState Logic where the userContentStateLogic and monitorStateLogic can be included
under the stateLogic folder.

2. Add content in the drawer state and refactor the children section of the drawer widget.

It lacks a stateLogic file of its own and certainly more states are needed in the drawerStates file.

*/
class MonitorView extends StatefulWidget {
  static String routeName = '/monitor';
  MonitorView({super.key});

  @override
  State<MonitorView> createState() => MonitorViewState();
}

class MonitorViewState extends State<MonitorView> {
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
    screen = context.watch<AdminProvider>().screen;
    return Scaffold(
      drawer: drawerView(view, status, name, privilege, context),
      appBar: AppBar(
        title: const Text('OHMSIM'),
      ),
      body: const Text('Monitor View Screen'),
      // body: adminContentStateLogic(screen, context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final test = Entry(
            symptoms: ["covid", "asdadasdasdasda"],
            closeContact: false,
            email: "email",
            date: DateTime.now(),
          );

          context.read<EntryProvider>().addEntry(test);
          if (context.mounted) {
            Navigator.pushNamed(context, '/admin');
          }
        },
        child: const Icon(Icons.add),
      ),
      // body:Widget(co),
    );
  }
}
