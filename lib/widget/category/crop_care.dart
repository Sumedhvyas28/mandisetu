import 'package:flutter/material.dart';
import 'package:mandisetu/constants/style/style_constants.dart';

class CropCarePage extends StatefulWidget {
  const CropCarePage({super.key});

  @override
  State<CropCarePage> createState() => _CropCarePageState();
}

class _CropCarePageState extends State<CropCarePage> {
  // Dummy crop care tips data
  final List<Map<String, String>> cropCareTips = [
    {
      "crop": "Tomato",
      "tip":
          "Tomatoes require a lot of sunlight. Water regularly but ensure the soil drains well to prevent root rot."
    },
    {
      "crop": "Carrot",
      "tip":
          "Carrots thrive in loose, sandy soil. Keep the soil moist and remove weeds that may interfere with root growth."
    },
    {
      "crop": "Spinach",
      "tip":
          "Spinach prefers cooler temperatures and rich, well-drained soil. Keep the soil consistently moist."
    },
    {
      "crop": "Cabbage",
      "tip":
          "Cabbage needs cool weather. Ensure it gets enough water and protection from pests like aphids and cabbage worms."
    },
    {
      "crop": "Potato",
      "tip":
          "Potatoes grow best in loose, well-drained soil. Ensure regular watering but avoid soggy conditions."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CropCare'),
        backgroundColor: StyleConstants.darkGreen,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: cropCareTips.length,
          itemBuilder: (context, index) {
            final cropCare = cropCareTips[index];
            return Card(
              color: Colors.white,
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ExpansionTile(
                title: Text(
                  cropCare['crop']!,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      cropCare['tip']!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
