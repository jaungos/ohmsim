import 'package:flutter/material.dart';

class RequestModalForm extends StatelessWidget {
  final String date;
  final String email;
  final String status;
  final List<String>? newSymptoms;
  final bool? exposure;
  final bool isEditRequest;

  RequestModalForm({
    required this.date,
    required this.email,
    required this.status,
    this.newSymptoms,
    this.exposure,
    required this.isEditRequest,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Request Details',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: Color(0xFF191313),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: Padding(
        padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Current Status',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF191313),
                    ),
                  ),
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: status == 'Cleared'
                          ? const Color(0xFF21523c)
                          : status == 'Under Monitoring'
                              ? const Color(0xFFf65151)
                              : status == 'Under Quarantine'
                                  ? const Color(0xFFff0000)
                                  : const Color(0xFF191313),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Date',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF191313),
                    ),
                  ),
                  Text(
                    date,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: Color(0xFF191313),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF191313),
                    ),
                  ),
                  Text(
                    email,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: Color(0xFF191313),
                    ),
                  ),
                ],
              ),
            ),
            if (isEditRequest) ...[
              if (newSymptoms != null) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'New Symptoms:',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          color: Color(0xFF191313),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          newSymptoms!.length,
                          (index) {
                            final symptom = newSymptoms![index];
                            return Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                '${index + 1}. $symptom',
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                  color: Color(0xFF191313),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              if (exposure != null) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Exposure',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          color: Color(0xFF191313),
                        ),
                      ),
                      Text(
                        exposure! ? 'Yes' : 'No',
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          color: Color(0xFF191313),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // TODO: Handle approve button press
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF21523c),
                  ),
                  child: Text('Approve'),
                ),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Handle decline button press
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6c1915),
                  ),
                  child: Text('Decline'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
