import 'package:flutter/material.dart';
import 'package:ohmsim/states/drawerStates.dart';

Drawer drawerView(String view, String status, String name, String privilege,
    BuildContext context) {
  return Drawer(
    child: ListView(
        padding: EdgeInsets.zero,
        children:
            privilege == "Admin" ? adminView(name, privilege, context) : []),
  );
}
