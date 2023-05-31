import 'package:flutter/material.dart';
import 'package:ohmsim/providers/adminProvider.dart';
import 'package:provider/provider.dart';

Column adminHomePage() {
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

Column adminProfile() {
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

Column adminViewUsers(BuildContext context) {
  List<String> filteredData = []; // Initialize filteredData list
  List<List<String>> dummyData = context.watch<AdminProvider>().listOfAllUsers;
  TextEditingController searchController = TextEditingController();

  void filterData(String searchTerm) {
    searchTerm = searchTerm.toLowerCase();
    // Filtering logic goes here based on your data source
    // For now, let's use dummy data for testing
    List<String> dummyData = [
      'Juan Makasalanan',
      'Bayani Santos',
      'Jonah Pamulaklakin',
      'Ama Namin',
      'Juan Makasalanan',
    ];
    filteredData = dummyData
        .where((item) => item.toLowerCase().contains(searchTerm))
        .toList();
    print(filteredData);
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Search',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<AdminProvider>().viewSpecificUsers();
              },
              child: Text('Search'),
            ),
          ],
        ),
      ),
      Expanded(
        child: ListView.builder(
          itemCount: dummyData.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(dummyData[index][0]),
            );
          },
        ),
      ),
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
