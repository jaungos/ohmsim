import 'package:flutter/material.dart';
import 'package:ohmsim/states/adminScreenStates.dart';

Column adminContentStateLogic(
  String screen,
) {
  if (screen == "home")
    return adminHomePage();
  else if (screen == "screen")
    return Column();
  else
    return Column();
}
