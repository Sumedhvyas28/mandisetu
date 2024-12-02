import 'package:flutter/material.dart';
import 'package:mandisetu/constants/style/style_constants.dart';

class CropCarePage extends StatefulWidget {
  const CropCarePage({super.key});

  @override
  State<CropCarePage> createState() => _CropCarePageState();
}

class _CropCarePageState extends State<CropCarePage> {
  final TextEditingController cropController = TextEditingController();
  final TextEditingController problemController = TextEditingController();

  void findSolution() {
    final crop = cropController.text.trim();
    final problem = problemController.text.trim();

    if (crop.isEmpty || problem.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Please fill in both fields to find a solution.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // Replace this with logic to find a solution based on the input.
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Solution'),
          content: Text(
              'Finding a solution for "$crop" with the problem "$problem".'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CropCare'),
        backgroundColor: StyleConstants.darkGreen,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Field for Crop Name
            TextField(
              controller: cropController,
              decoration: InputDecoration(
                labelText: 'Crop Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // Field for Problem Description
            TextField(
              controller: problemController,
              decoration: InputDecoration(
                labelText: 'Describe Your Problem',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16.0),

            // Button to Find Solution
            ElevatedButton(
              onPressed: findSolution,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                backgroundColor: StyleConstants.darkGreen,
              ),
              child: const Text(
                'Find Solution',
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
