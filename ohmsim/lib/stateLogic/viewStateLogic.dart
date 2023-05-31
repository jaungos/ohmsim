import 'package:flutter/material.dart';
import 'package:ohmsim/states/adminScreenStates.dart';
import 'package:ohmsim/stateLogic/adminContentStateLogic.dart';

Column viewStateLogic(
  String screen, BuildContext context
) {
  if (screen == "user") {
    return Column();
  } // TODO
  else if (screen == "admin") {
    return adminContentStateLogic(screen, context);
  } else if (screen == "monitor") {
    return Column(); // TODO
  } else {
    return Column();
  }
}
