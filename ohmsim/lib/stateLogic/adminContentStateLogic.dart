import 'package:flutter/material.dart';
import 'package:ohmsim/providers/adminProvider.dart';
import 'package:ohmsim/providers/authProvider.dart';
import 'package:ohmsim/states/adminScreenStates.dart';
import 'package:provider/provider.dart';

Column adminContentStateLogic(
  String screen, BuildContext context
) {
  if (screen == "home")
    return adminHomePage();
  else if (screen == "profile")
    return adminProfile();
  else if (screen == "viewAllUsers")
  {
    context.read<AdminProvider>().viewAllUsers();
    return adminViewUsers(context);
  }
    
  else
    return Column();
}
