import 'package:flutter/material.dart';
import 'package:ohmsim/providers/adminProvider.dart';
import 'package:ohmsim/providers/authProvider.dart';
import 'package:ohmsim/states/adminScreenStates.dart';
import 'package:ohmsim/stateLogic/adminContentStateLogic.dart';
import './drawer.dart';
import 'package:provider/provider.dart';

/*

TODO: Refactor adminView to just view. 

1. Replace the state logic in the body section.

Instead of solely relying on the adminContentStateLogic file. Replace and refactor it with
viewState Logic where the userContentStateLogic and monitorStateLogic can be included
under the stateLogic folder.

2. Add content in the drawer state and refactor the children section of the drawer widget.

It lacks a stateLogic file of its own and certainly more states are needed in the drawerStates file.

*/
class AdminView extends StatefulWidget {
  static String routeName = '/admin';
  AdminView({super.key});

  @override
  State<AdminView> createState() => AdminViewState();
}

class AdminViewState extends State<AdminView> {
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
      body: adminContentStateLogic(screen),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/"); // Go to add entry
        },
        child: const Icon(Icons.add),
      ),
      // body:Widget(co),
    );
  }
}
