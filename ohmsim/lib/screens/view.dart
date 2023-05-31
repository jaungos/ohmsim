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
          Navigator.pushNamed(context, "/"); // Go to add entry
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

_showAddModal(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog();
    },
  );
}
