import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OHMSIM'),
      ),
      body: const Text('Monitor View Screen'),
    );
  }
}
