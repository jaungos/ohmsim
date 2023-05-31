import 'package:flutter/material.dart';
import 'package:ohmsim/providers/adminProvider.dart';
import 'package:ohmsim/providers/authProvider.dart';
import 'package:provider/provider.dart';

List<Widget> adminView(String name, String privilege, BuildContext context) {
  return [
    DrawerHeader(
      decoration: BoxDecoration(
        color: Colors.orange,
      ),
      child: Text(name),
    ),
    ListTile(
        title: const Text('Home'),
        onTap: () {
          context.read<AdminProvider>().changeScreen("home");
          Navigator.pop(context);
        }),
    ListTile(
        title: const Text('Profile'),
        onTap: () {
          context.read<AdminProvider>().changeScreen("profile");
          Navigator.pop(context);
        }),
    ListTile(
        title: const Text('View All Users'),
        onTap: () {
          context.read<AdminProvider>().changeScreen("viewAllUsers");
          Navigator.pop(context);
        }),
    ListTile(
        title: const Text('View Quarantined Users'),
        onTap: () {
          context.read<AdminProvider>().changeScreen("viewQuarantinedUsers");
          Navigator.pop(context);
        }),
    ListTile(
        title: const Text('View Monitored Users'),
        onTap: () {
          context.read<AdminProvider>().changeScreen("viewMonitoredUsers");
          Navigator.pop(context);
        }),
    ListTile(),
    ListTile(title: const Text('Switch To User View'), onTap: () {}),
    ListTile(
      title: const Text('Log Out'),
      onTap: () {
        context.read<AuthProvider>().signOut();
        // pop all screens and go to login
        Navigator.popUntil(context, ModalRoute.withName('/'));
        Navigator.pushNamed(context, '/');
      },
    )
  ];
}
