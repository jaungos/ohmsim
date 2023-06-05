import 'package:flutter/material.dart';

class DeleteEntry extends StatefulWidget {
  @override
  _DeleteEntryState createState() => _DeleteEntryState();
}

class _DeleteEntryState extends State<DeleteEntry> {
  // HARDCODE DATEEEEE
  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      title: const Text(
        'Health Assessment',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w700,
          color: Color(0xFF191313),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // @TODO: add the date part only of the entry as part of the text
            Text(
              'Are you sure you want to delete June ${_date.day}, ${_date.year}\'s entry ?',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF333333),
          ),
          child: const Text(
            'Cancel',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Color(0xFFf9fefa),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // @TODO: Handle delete entry here

            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6c1915),
          ),
          child: const Text(
            'Delete',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Color(0xFFf9fefa),
            ),
          ),
        ),
      ],
    );
  }
}
