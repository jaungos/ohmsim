import 'package:flutter/material.dart';

List<Widget> adminView(name, privilege) {
  return [
    DrawerHeader(
      decoration: BoxDecoration(
        color: Colors.orange,
      ),
      child: Text(name),
    ),
    ListTile(title: const Text('Home'), onTap: () {}),
    ListTile(title: const Text('Profile'), onTap: () {}),
    ListTile(title: const Text('View All Users'), onTap: () {}),
    ListTile(title: const Text('View Quarantined Users'), onTap: () {}),
    ListTile(title: const Text('View Monitored Users'), onTap: () {}),
    ListTile(),
    ListTile(title: const Text('Switch To User View'), onTap: () {}),
    ListTile(title: const Text('Log Out'), onTap: () {})
  ];
}
