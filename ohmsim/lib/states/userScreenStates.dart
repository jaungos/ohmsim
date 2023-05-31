import 'package:flutter/material.dart';
import 'package:ohmsim/providers/adminProvider.dart';
import 'package:provider/provider.dart';

Column userHomePage() {
  return Column(
    children: [
      Text(
        "Hello Juan Makasalanan!",
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

Column userProfile() {
  return Column(
    children: [
      SizedBox(height: 30),
      Center(
        child: CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey,
          child: Icon(
            Icons.person,
            size: 50,
            color: Colors.white,
          ),
        ),
      ),
      SizedBox(height: 20),
      Text(
        "Juan Makasalanan",
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 15),
      profileAttributeText("User Type: ", "Admin"),
      profileAttributeText("Position: ", "SAIS Director"),
      profileAttributeText("Home Unit: ", "UP Batanes"),
      profileAttributeText("Status: ", "Healthy"),
      profileAttributeText("Date Created: ", "666/420"),
    ],
  );
}



// UTIL FUNCTIONS

Center profileAttributeText(String attribute, String value) {
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          attribute,
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 15.0,
          ),
        )
      ],
    ),
  );
}
