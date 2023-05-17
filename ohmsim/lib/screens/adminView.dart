import 'package:flutter/material.dart';
import 'package:ohmsim/providers/adminProvider.dart';
import 'package:ohmsim/providers/authProvider.dart';
import './drawer.dart';
import 'package:provider/provider.dart';

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
  @override
  Widget build(BuildContext context) {
    view = context.watch<AuthProvider>().view;
    status = context.watch<AuthProvider>().status;
    name = context.watch<AuthProvider>().name;
    privilege = context.watch<AuthProvider>().privilege;
    return Scaffold(
      drawer: drawerView(view, status, name, privilege),
      appBar: AppBar(
        title: const Text('Admin View'),
      ),
      // body:Widget(co),
    );
  }
}