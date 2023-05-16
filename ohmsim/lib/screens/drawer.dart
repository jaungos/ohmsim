import 'package:flutter/material.dart';

Drawer drawerView(String view, String status, String name) {
  return Drawer(
    child: ListView(padding: EdgeInsets.zero, children: [
      DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.orange,
        ),
        child: Text(name),
      )
    ]),
  );
}
