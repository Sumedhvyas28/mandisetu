import 'package:flutter/material.dart';
import 'package:mandisetu/constants/style/style_constants.dart';

class NewsBullettin extends StatefulWidget {
  const NewsBullettin({super.key});

  @override
  State<NewsBullettin> createState() => _NewsBullettinState();
}

class _NewsBullettinState extends State<NewsBullettin> {
  // Dummy data for news items
  final List<Map<String, String>> newsItems = [
    {
      "title": "Tomato Prices Drop by 20%",
      "description":
          "Farmers report a bumper harvest of tomatoes this season, leading to a significant price drop across major markets.",
      "image":
          "https://cdn-icons-png.flaticon.com/512/590/590781.png", // Example image
      "date": "30 Nov 2024"
    },
    {
      "title": "Onion Prices Hit Record High",
      "description":
          "Due to a supply shortage, onion prices have surged by 35% in the past week, impacting consumers nationwide.",
      "image":
          "https://cdn-icons-png.flaticon.com/512/415/415682.png", // Example image
      "date": "29 Nov 2024"
    },
    {
      "title": "Potato Harvest Yield Improves",
      "description":
          "The latest crop of potatoes is yielding better than expected, stabilizing market prices.",
      "image":
          "https://cdn-icons-png.flaticon.com/512/3081/3081998.png", // Example image
      "date": "28 Nov 2024"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Bulletin'),
        backgroundColor: StyleConstants.darkGreen,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: newsItems.length,
          itemBuilder: (context, index) {
            final item = newsItems[index];
            return Card(
              color: Colors.white,
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                    child: Image.network(
                      item['image']!,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title']!,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: StyleConstants.darkGreen,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item['description']!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.grey[700]),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item['date']!,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
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
