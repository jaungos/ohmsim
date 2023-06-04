import 'package:flutter/material.dart';

class ViewAllLogs extends StatefulWidget {
  ViewAllLogs({super.key});

  @override
  State<ViewAllLogs> createState() => ViewAllLogsState();
}

class ViewAllLogsState extends State<ViewAllLogs> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Enter student\'s name',
                // Changes the border color when the field is active/clicked
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF21523c),
                    width: 2,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Color(0xFF21523c),
                  ),
                  onPressed: () {
                    // Call the search function here
                    // searchStudents(searchController.text);
                  },
                ),
              ),
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          // Show header for search results
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
            child: Text(
              'Search Results',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF191313),
              ),
            ),
          ),
          // @TODO: show the list of student logs here
        ],
      ),
    );
  }
}
